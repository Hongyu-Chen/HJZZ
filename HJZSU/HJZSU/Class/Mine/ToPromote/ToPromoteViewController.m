//
//  ToPromoteViewController.m
//  HJZSU
//
//  Created by apple on 2019/3/15.
//  Copyright © 2019 apple. All rights reserved.
//

#import "ToPromoteViewController.h"
#import "TPTopTableViewCell.h"
#import "TPListTableViewCell.h"

@interface ToPromoteViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic) UITableView *tableView;
@property (strong,nonatomic) NSMutableArray *tableData;

@end

@implementation ToPromoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationView.backgroundColor = [UIColor clearColor];
    self.titleLab.text = @"我的推广";
    [self.view addSubview:self.tableView];
    [self.view sendSubviewToBack:self.tableView];
    
    [self reloadViewData];
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - NavigationContentTopConstant)];
        _tableView.backgroundColor = self.view.backgroundColor;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[TPTopTableViewCell class] forCellReuseIdentifier:NSStringFromClass([TPTopTableViewCell class])];
        [_tableView registerClass:[TPListTableViewCell class] forCellReuseIdentifier:NSStringFromClass([TPListTableViewCell class])];
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
    return _tableView;
}

- (void)reloadViewData{
    [self getTopPromotesuccess:^(id  _Nonnull result) {
        [self setTableData:result];
        [self.tableView reloadData];
    } failed:^(NSString * _Nonnull reson) {
        [QMUITips showError:reson];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return section == 0  ? 1 : self.tableData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        TPTopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TPTopTableViewCell class])];
        return cell;
    }
    else{
        TPListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TPListTableViewCell class])];
        cell.model = self.tableData ? self.tableData[indexPath.row] : nil;
        return cell;
//        ChatViewc
    }
}


@end
