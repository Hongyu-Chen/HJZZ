//
//  PhysicianVisitsVC.m
//  HJZSU
//
//  Created by apple on 2019/3/7.
//  Copyright © 2019 apple. All rights reserved.
//

#import "PhysicianVisitsVC.h"
#import "PVTableViewCell.h"
#import "SubPhysicianVC.h"

@interface PhysicianVisitsVC ()<UITableViewDataSource,UITableViewDelegate>

@property (strong,nonatomic) UITableView *tableView;
@property (strong,nonatomic) NSMutableArray *listData;
@property (assign,nonatomic) NSInteger page;

@end

@implementation PhysicianVisitsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleLab.text = @"终端问诊";
    [self.view addSubview:self.tableView];
    self.rightBtn.hidden = NO;
    [self.rightBtn setTitle:@"发布" forState:UIControlStateNormal];
    [self.tableView.mj_header beginRefreshing];
}

- (void)righttemButtenPressed:(UIButton *)sender{
    [self.navigationController pushViewController:[[SubPhysicianVC alloc] init] animated:YES];
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NavigationContentTopConstant, SCREEN_WIDTH, SCREEN_HEIGHT - NavigationContentTopConstant)];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = UIColorMake(239, 239, 239);
        [_tableView registerClass:[PVTableViewCell class] forCellReuseIdentifier:NSStringFromClass([PVTableViewCell class])];
        _tableView.estimatedRowHeight = SCREEN_WIDTH * 480.0/750.0 + 200;
        _tableView.mj_header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(reloadViewData)];
        _tableView.mj_footer = [MJRefreshAutoGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(reloadViewMoreData)];
    }
    return _tableView;
}
- (void)reloadViewData{
    self.page = 1;
    [self getArticleListWith:@{@"page":[NSNumber numberWithInteger:self.page],@"size":@"10"} success:^(id  _Nonnull result) {
        NSLog(@"%@",result);
        NSArray *tmp = (NSArray *)result;
        self.listData = [[NSMutableArray alloc] initWithArray:tmp];
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        if (tmp.count < 10) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        else{
            [self.tableView.mj_footer resetNoMoreData];
        }
    } failed:^(NSString * _Nonnull reson) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer resetNoMoreData];
    }];
}

- (void)reloadViewMoreData{
    self.page++;
    [self getArticleListWith:@{@"page":[NSNumber numberWithInteger:self.page],@"size":@"10"} success:^(id  _Nonnull result) {
        NSArray *tmp = (NSArray *)result;
        self.listData = [[self.listData arrayByAddingObjectsFromArray:tmp] mutableCopy];
        [self.tableView reloadData];
        if (tmp.count < 10) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        else{
            [self.tableView.mj_footer resetNoMoreData];
        }
    } failed:^(NSString * _Nonnull reson) {
        [self.tableView.mj_footer endRefreshing];
        self.page--;
    }];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.listData ? self.listData.count : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PVTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PVTableViewCell class])];
    cell.cellInfo = self.listData ? self.listData[indexPath.row] : nil;
    __weak typeof(self) weakself = self;
    cell.userDeleteSuccess = ^{
        [weakself.tableView.mj_header beginRefreshing];
    };
    return cell;
}

@end
