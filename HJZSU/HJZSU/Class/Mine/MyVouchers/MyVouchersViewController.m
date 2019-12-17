//
//  MyVouchersViewController.m
//  HJZSU
//
//  Created by apple on 2019/3/14.
//  Copyright © 2019 apple. All rights reserved.
//

#import "MyVouchersViewController.h"
#import "VoucherTableViewCell.h"
#import "CUVoichersViewController.h"

@interface MyVouchersViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic) UITableView *tableView;
@property (strong,nonatomic) NSMutableArray *tableData;

@end

@implementation MyVouchersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (self.isChooseStyle) {
        self.titleLab.text = @"选择代金券";
        self.rightBtn.hidden = NO;
        [self.rightBtn setTitle:@"完成" forState:UIControlStateNormal];
    }
    else{
        self.titleLab.text = @"我的代金券";
        self.rightBtn.hidden = NO;
        [self.rightBtn setTitle:@"已失效" forState:UIControlStateNormal];
    }
    [self.view addSubview:self.tableView];
    [self.tableView.mj_header beginRefreshing];
    
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NavigationContentTopConstant, SCREEN_WIDTH, SCREEN_HEIGHT - NavigationContentTopConstant)];
        _tableView.backgroundColor = self.view.backgroundColor;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[VoucherTableViewCell class] forCellReuseIdentifier:NSStringFromClass([VoucherTableViewCell class])];
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        __weak typeof(self) weakself= self;
        _tableView.mj_header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
            [weakself reloadViewData];
        }];
    }
    return _tableView;
}

- (void)righttemButtenPressed:(UIButton *)sender{
    if (self.isChooseStyle) {
        BOOL back = NO;
        VocherModel *backModel = nil;
        for (VocherModel *model in self.tableData) {
            if (model.chooseStatus) {
                back = YES;
                backModel = model;
                break;
            }
        }
        if (self.userChooseBlock != nil) {
            self.userChooseBlock(backModel);
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
    else{
        [self.navigationController pushViewController:[[CUVoichersViewController alloc] init] animated:YES];
    }
}

- (void)reloadViewData{
    [self getVocherListsuccess:^(id  _Nonnull result) {
        
        if (!self.tableData) {
            self.tableData = [[NSMutableArray alloc] init];
        }
        else{
            [self.tableData removeAllObjects];
        }
        
        for (VocherModel *model in result) {
            if(self.isChooseStyle){
                if (model.status == 0 && model.type == self.type) {
                    [self.tableData addObject:model];
                }
            }
            else{
                if (model.status == 0) {
                    [self.tableData addObject:model];
                }
            }
        }
        
        if (self.isChooseStyle && self.chooiseModel) {
            
            for (VocherModel *model in self.tableData) {
                if (model.id == self.chooiseModel.id) {
                    model.chooseStatus = YES;
                }
            }
        }
        
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    } failed:^(NSString * _Nonnull reson) {
        [self.tableView.mj_header endRefreshing];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tableData.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    VoucherTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([VoucherTableViewCell class])];
    cell.model = self.tableData ? self.tableData[indexPath.row] : nil;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.isChooseStyle) {
        VocherModel *model = self.tableData[indexPath.row];
        model.chooseStatus = !model.chooseStatus;
        if (model.chooseStatus) {
            for (VocherModel *tmp in self.tableData) {
                if (model.id != tmp.id) {
                    tmp.chooseStatus = NO;
                }
            }
        }
        [self.tableView reloadData];
    }
}


@end
