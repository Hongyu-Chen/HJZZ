//
//  ServerViewController.m
//  HJZSU
//
//  Created by apple on 2019/3/7.
//  Copyright © 2019 apple. All rights reserved.
//

#import "ServerViewController.h"
#import "SInfoTableViewCell.h"
#import "SlistTableViewCell.h"
#import "TeamInfoViewController.h"

@interface ServerViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic) UITableView *tableView;
@property (strong,nonatomic) NSMutableArray *tableData;

@end

@implementation ServerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleLab.text = @"战神榜";
    [self.view addSubview:self.tableView];
    [self.tableView.mj_header beginRefreshing];
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NavigationContentTopConstant, SCREEN_WIDTH, SCREEN_HEIGHT - NavigationContentTopConstant)];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = UIColorMake(239, 239, 239);
        [_tableView registerClass:[SInfoTableViewCell class] forCellReuseIdentifier:NSStringFromClass([SInfoTableViewCell class])];
        [_tableView registerClass:[SlistTableViewCell class] forCellReuseIdentifier:NSStringFromClass([SlistTableViewCell class])];
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
    [self getRankListsuccess:^(id  _Nonnull result) {
        [self setTableData:result];
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    } failed:^(NSString * _Nonnull reson) {
        [self.tableView.mj_header endRefreshing];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    else{
        return self.tableData.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }
    else{
        return SCREEN_WIDTH * 59.5/375.0;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return nil;
    }
    else{
        UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH * 59.5/375.0)];
        image.image = [UIImage imageNamed:@"战神榜底图"];
        image.contentMode = UIViewContentModeScaleAspectFit;
        
        UILabel *tip = [LabelCreat creatLabelWith:@"战神榜" font:[UIFont boldSystemFontOfSize:18] color:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter];
        tip.frame = image.bounds;
        [image addSubview:tip];
        
        return image;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        SInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SInfoTableViewCell class])];
        return cell;
    }
    else{
        SlistTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SlistTableViewCell class])];
        cell.model = self.tableData ? self.tableData[indexPath.row] : nil;
        cell.indexPath = indexPath;
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        RankModel *model = self.tableData[indexPath.row];
        TeamInfoViewController *info = [[TeamInfoViewController alloc] init];
        info.teamId = model.id;
        [self.navigationController pushViewController:info animated:YES];
    }
}


@end
