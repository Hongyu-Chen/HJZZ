//
//  BankViewController.m
//  HJZSU
//
//  Created by apple on 2019/3/15.
//  Copyright © 2019 apple. All rights reserved.
//

#import "BankViewController.h"
#import "BankAddTableViewCell.h"
#import "BankTableViewCell.h"
#import "AddBankViewController.h"

@interface BankViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic) UITableView *tableView;
@property (strong,nonatomic) NSMutableArray *tableData;

@end

@implementation BankViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleLab.text = @"我的银行卡";
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
        [_tableView registerClass:[BankAddTableViewCell class] forCellReuseIdentifier:NSStringFromClass([BankAddTableViewCell class])];
        [_tableView registerClass:[BankTableViewCell class] forCellReuseIdentifier:NSStringFromClass([BankTableViewCell class])];
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
    [self getMyBankListsuccess:^(id  _Nonnull result) {
        [self setTableData:result];
        [self.tableView.mj_header endRefreshing];
    } failed:^(NSString * _Nonnull reson) {
        [self.tableView.mj_header endRefreshing];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return section == 0  ? self.tableData.count : 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        BankTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([BankTableViewCell class])];
        return cell;
    }
    else{
        BankAddTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([BankAddTableViewCell class])];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.navigationController pushViewController:[[AddBankViewController alloc] init] animated:YES];
}


@end
