//
//  CUVoichersViewController.m
//  HJZSU
//
//  Created by apple on 2019/6/17.
//  Copyright © 2019 apple. All rights reserved.
//

#import "CUVoichersViewController.h"
#import "VoucherTableViewCell.h"

@interface CUVoichersViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic) UITableView *tableView;
@property (strong,nonatomic) NSMutableArray *tableData;

@end

@implementation CUVoichersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleLab.text = @"已失效";
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

- (void)reloadViewData{
    [self getVocherListsuccess:^(id  _Nonnull result) {
        if (!self.tableData) {
            self.tableData = [[NSMutableArray alloc] init];
        }
        else{
            [self.tableData removeAllObjects];
        }
        
        for (VocherModel *model in result) {
            if (model.status != 0) {
                [self.tableData addObject:model];
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

@end
