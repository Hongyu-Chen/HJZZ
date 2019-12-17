//
//  MySubmitViewController.m
//  HJZSU
//
//  Created by apple on 2019/3/14.
//  Copyright © 2019 apple. All rights reserved.
//

#import "MySubmitViewController.h"
#import "MSTableViewCell.h"
#import "OrderInfoViewController.h"

@interface MySubmitViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic) UITableView *tableView;
@property (strong,nonatomic) NSMutableArray *tableData;

@end

@implementation MySubmitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleLab.text = @"发布记录";
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
        [_tableView registerClass:[MSTableViewCell class] forCellReuseIdentifier:NSStringFromClass([MSTableViewCell class])];
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
    [self getSubmitHistorysuccess:^(id  _Nonnull result) {
        [self setTableData:result];
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 112;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MSTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MSTableViewCell class])];
    cell.model = self.tableData ? self.tableData[indexPath.row] : nil;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SubHisModel *model = self.tableData[indexPath.row];
    OrderInfoViewController *order = [[OrderInfoViewController alloc] init];
    order.orderNo = model.orderNo;
    [self.navigationController pushViewController:order animated:YES];
}

@end
