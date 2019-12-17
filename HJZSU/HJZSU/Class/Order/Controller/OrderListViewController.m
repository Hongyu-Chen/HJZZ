//
//  OrderListViewController.m
//  HJZSU
//
//  Created by apple on 2019/3/13.
//  Copyright © 2019 apple. All rights reserved.
//

#import "OrderListViewController.h"
#import "OrderListTableViewCell.h"
#import "OrderInfoViewController.h"

@interface OrderListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic) UITableView *tableView;
@property (strong,nonatomic) NSMutableArray *tableData;
@property (assign,nonatomic) NSInteger page;

@end

@implementation OrderListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.view.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.tableView];
}


- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - NavigationContentTopConstant - 50 - TabBarHeight)];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[OrderListTableViewCell class] forCellReuseIdentifier:NSStringFromClass([OrderListTableViewCell class])];
        _tableView.backgroundColor = UIColorMake(239, 239, 239);
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        __weak typeof(self) weakself= self;
        _tableView.mj_header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
            weakself.page = 1;
            [weakself reloadViewData];
        }];
        _tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
            weakself.page++;
            [weakself reloadViewData];
        }];
    }
    return _tableView;
}

- (void)reloadViewData{
    [self getOrderList:self.orderType page:self.page size:20 success:^(id  _Nonnull result) {
        if (self.page == 1) {
            [self setTableData:result];
        }
        else{
            self.tableData = [[self.tableData arrayByAddingObjectsFromArray:result] mutableCopy];
        }
        [self.tableView reloadData];
        NSMutableArray *tmp = result;
        if (tmp.count < 20) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        else{
            [self.tableView.mj_footer endRefreshing];
        }
        [self.tableView.mj_header endRefreshing];
    } failed:^(NSString * _Nonnull reson) {
        if (self.page != 1) {
            self.page--;
        }
        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_header endRefreshing];
    }];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tableData ? self.tableData.count : 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 119;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([OrderListTableViewCell class])];
    [cell setCellinfoWithModel:self.tableData ? self.tableData[indexPath.row] : nil];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderModel *model = self.tableData[indexPath.row];
    OrderInfoViewController *orderInfo = [[OrderInfoViewController alloc] init];
    orderInfo.orderNo = model.order_no;
    [self.navigationController pushViewController:orderInfo animated:YES];
}

- (void)reloadViewDataWithTableiew{
    [self.tableView.mj_header beginRefreshing];
}


@end
