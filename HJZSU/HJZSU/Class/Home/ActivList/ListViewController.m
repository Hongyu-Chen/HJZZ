//
//  ListViewController.m
//  HJZSS
//
//  Created by apple on 2019/2/26.
//  Copyright © 2019 apple. All rights reserved.
//

#import "ListViewController.h"
#import "AListTableViewCell.h"
#import "ALButton.h"
#import "ACInfoViewController.h"
#import "CertificationViewController.h"

@interface ListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic) UITableView *tableView;
@property (strong,nonatomic) UIButton *refesh;
@property (assign,nonatomic) NSInteger page;
@property (strong,nonatomic) QMUIButton *zonghe;
@property (strong,nonatomic) ALButton *star;
@property (strong,nonatomic) ALButton *time;
@property (strong,nonatomic) NSMutableArray *listData;

@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleLab.text = @"活动列表";
    self.rightBtn.hidden = YES;
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.refesh];
    [self.view addSubview:self.zonghe];
    [self.view addSubview:self.star];
    [self.view addSubview:self.time];
    
    [self.tableView.mj_header beginRefreshing];
}

- (QMUIButton *)zonghe{
    if (!_zonghe) {
        _zonghe = [[QMUIButton alloc] initWithFrame:CGRectMake(0, NavigationContentTopConstant, SCREEN_WIDTH/3, 50)];
        [_zonghe setTitle:@"综合排序" forState:UIControlStateNormal];
        _zonghe.imagePosition = QMUIButtonImagePositionLeft;
        _zonghe.imageView.contentMode = UIViewContentModeScaleAspectFit;
        _zonghe.spacingBetweenImageAndTitle = 5;
        [_zonghe setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_zonghe setTitleColor:UIColorMake(255, 80, 0) forState:UIControlStateSelected];
        [_zonghe setImage:[UIImage imageNamed:@"综合排序"] forState:UIControlStateNormal];
        _zonghe.backgroundColor = UIColorMake(51, 51, 51);
        _zonghe.titleLabel.font = [UIFont systemFontOfSize:13];
        _zonghe.imageEdgeInsets = UIEdgeInsetsMake(3, 0, 6, 0);
        [_zonghe addTarget:self action:@selector(zontheBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        _zonghe.adjustsImageWhenHighlighted = NO;
        _zonghe.adjustsImageWhenDisabled = NO;
        _zonghe.selected = NO;
    }
    return _zonghe;
}

- (ALButton *)star{
    if (!_star) {
        _star = [[ALButton alloc] init];
        _star.frame = CGRectMake(SCREEN_WIDTH/3, NavigationContentTopConstant, SCREEN_WIDTH/3, 50);
        _star.iconImage = [UIImage imageNamed:@"时间排序"];
        _star.valueStr = @"星级";
        __weak typeof(self) weakself = self;
        _star.buttonPressedBlock = ^(NSInteger style) {
            if (style != 0) {
                weakself.zonghe.selected = NO;
                weakself.time.style = 0;
                weakself.time.iconImage = [UIImage imageNamed:@"时间排序"];
                if (style == 1) {
                    weakself.star.iconImage = [UIImage imageNamed:@"收藏-未选中"];
                }
                else if (style == 2){
                    weakself.star.iconImage = [UIImage imageNamed:@"收藏-已选中"];
                }
            }
            else{
                weakself.star.iconImage = [UIImage imageNamed:@"时间排序"];
                if (weakself.time.style == 0) {
                    weakself.zonghe.selected = YES;
                }
            }
            [weakself.tableView.mj_header beginRefreshing];
        };
    }
    return _star;
}

- (ALButton *)time{
    if (!_time) {
        _time = [[ALButton alloc] init];
        _time.frame = CGRectMake(SCREEN_WIDTH/3 * 2, NavigationContentTopConstant, SCREEN_WIDTH/3, 50);
        _time.iconImage = [UIImage imageNamed:@"时间排序"];
        _time.valueStr = @"时间";
        __weak typeof(self) weakself = self;
        _time.buttonPressedBlock = ^(NSInteger style) {
            if (style != 0) {
                weakself.zonghe.selected = NO;
                weakself.star.style = 0;
                weakself.star.iconImage = [UIImage imageNamed:@"时间排序"];
                if (style == 1) {
                    weakself.time.iconImage = [UIImage imageNamed:@"收藏-未选中"];
                }
                else if (style == 2){
                    weakself.time.iconImage = [UIImage imageNamed:@"收藏-已选中"];
                }
                
            }
            else{
                weakself.time.iconImage = [UIImage imageNamed:@"时间排序"];
                if (weakself.star.style == 0) {
                    weakself.zonghe.selected = YES;
                }
            }
            [weakself.tableView.mj_header beginRefreshing];
        };
    }
    return _time;
}

- (void)zontheBtnPressed:(UIButton *)sender{
    sender.selected = !sender.selected;
    if (sender.selected) {
        _star.style = 0;
        _time.style = 0;
        _star.iconImage = [UIImage imageNamed:@"时间排序"];
        _time.iconImage = [UIImage imageNamed:@"时间排序"];
        [self.tableView.mj_header beginRefreshing];
    }
}


- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NavigationContentTopConstant + 50, SCREEN_WIDTH, SCREEN_HEIGHT - NavigationContentTopConstant - 50)];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[AListTableViewCell class] forCellReuseIdentifier:NSStringFromClass([AListTableViewCell class])];
        _tableView.backgroundColor = UIColorMake(239, 239, 239);
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        _tableView.mj_header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(reloadRefershViewData)];
        _tableView.mj_footer = [MJRefreshAutoGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(reloadMoreData)];
    }
    return _tableView;
}

- (void)reloadRefershViewData{
    self.page = 1;
    [self getActiviteListWith:[self parameter] success:^(id  _Nonnull result) {
        NSArray *tmp = (NSArray *)result;
        self.listData = [[NSMutableArray alloc] initWithArray:result];
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        if (tmp.count < 10) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        else{
            [self.tableView.mj_footer endRefreshing];
        }
    } failed:^(NSString * _Nonnull reson) {
        [QMUITips showError:reson];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer resetNoMoreData];
    }];
}

- (void)reloadMoreData{
    self.page++;
    [self getActiviteListWith:[self parameter] success:^(id  _Nonnull result) {
        NSArray *tmp = (NSArray *)result;
        self.listData = [self.listData arrayByAddingObjectsFromArray:result];
        [self.tableView reloadData];
        if (tmp.count < 10) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        else{
            [self.tableView.mj_footer endRefreshing];
        }
    } failed:^(NSString * _Nonnull reson) {
        [QMUITips showError:reson];
        [self.tableView.mj_footer resetNoMoreData];
        self.page--;
    }];
}

- (NSDictionary *)parameter{
    NSInteger sort = 0;
    if (_zonghe.selected) {
        sort = 0;
    }
    else{
        if (_star.style == 1) {
            sort = 1;
        }
        else if (_star.style == 2){
            sort = 2;
        }
        else if (_time.style == 1){
            sort = 3;
        }
        else if (_time.style == 2){
            sort = 4;
        }
        else{
            sort = 4;
        }
    }
    
    NSMutableDictionary *par = [[NSMutableDictionary alloc] init];
    [par setObject:[NSNumber numberWithInteger:self.page] forKey:@"page"];
    [par setObject:@"10" forKey:@"size"];
    if (sort) {
        [par setObject:sort ? [NSNumber numberWithInteger:sort] : @"" forKey:@"sort"];
    }
    if (self.type) {
        [par setObject:self.type ? [NSNumber numberWithInteger:self.type] : @"" forKey:@"type"];
    }
    return par;
}

- (UIButton *)refesh{
    if (!_refesh) {
        _refesh = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 55, SCREEN_HEIGHT - SafeAreaInsetsConstantForDeviceWithNotch.bottom - 20 - 40, 40, 40)];
        [_refesh setImage:[UIImage imageNamed:@"刷新-按钮"] forState:UIControlStateNormal];
        _refesh.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [_refesh addTarget:self action:@selector(reloadRefershViewData) forControlEvents:UIControlEventTouchUpInside];
    }
    return _refesh;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.listData ? self.listData.count : 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 112;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([AListTableViewCell class])];
    cell.cellInfo = self.listData ? self.listData[indexPath.row] : nil;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([[YYCacheManager shareYYCacheManager] isAuth]) {
        ACInfoViewController *info = [[ACInfoViewController alloc] init];
        info.activiteId = [self.listData[indexPath.row][@"id"] integerValue];
        [self.navigationController pushViewController:info animated:YES];
    }
    else{
        CertificationViewController *info = [[CertificationViewController alloc] init];
        [self.navigationController pushViewController:info animated:YES];
    }
}

@end
