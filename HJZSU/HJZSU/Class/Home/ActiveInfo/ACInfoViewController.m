//
//  ACInfoViewController.m
//  HJZSS
//
//  Created by apple on 2019/2/27.
//  Copyright © 2019 apple. All rights reserved.
//

#import "ACInfoViewController.h"

#import "ACInfoTableViewCell.h"
#import "ACDetailTableViewCell.h"
#import "StartTableViewCell.h"
#import "ACTeamTableViewCell.h"

@interface ACInfoViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic) UITableView *tableView;
@property (strong,nonatomic) NSDictionary *activitInfo;

@end

@implementation ACInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.rightBtn.hidden = YES;
    self.titleLab.hidden = YES;
    self.navigationView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.tableView];
    [self.view sendSubviewToBack:self.tableView];
    [self getActiviteInfoWith:self.activiteId Success:^(id  _Nonnull result) {
        self.activitInfo = result;
        [self.tableView reloadData];
    } failed:^(NSString * _Nonnull reson) {
        ;
    }];
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - SafeAreaInsetsConstantForDeviceWithNotch.bottom)];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[ACInfoTableViewCell class] forCellReuseIdentifier:NSStringFromClass([ACInfoTableViewCell class])];
        [_tableView registerClass:[ACDetailTableViewCell class] forCellReuseIdentifier:NSStringFromClass([ACDetailTableViewCell class])];
        [_tableView registerClass:[ACTeamTableViewCell class] forCellReuseIdentifier:NSStringFromClass([ACTeamTableViewCell class])];
        [_tableView registerClass:[StartTableViewCell class] forCellReuseIdentifier:NSStringFromClass([StartTableViewCell class])];
        _tableView.backgroundColor = UIColorMake(239, 239, 239);
        if (@available(iOS 11.0, *)) {
            self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
    return _tableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.activitInfo ? IsNullString(self.activitInfo[@"teamName"]) ? 3 : 4 : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        ACInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ACInfoTableViewCell class])];
        cell.activiteInfo = self.activitInfo ? self.activitInfo : nil;
        return cell;
    }
    else if (indexPath.row == 1){
        ACDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ACDetailTableViewCell class])];
        cell.activiteInfo = self.activitInfo ? self.activitInfo : nil;
        return cell;
    }
    else if (indexPath.row == 2){
        StartTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([StartTableViewCell class])];
        cell.activiteInfo = self.activitInfo ? self.activitInfo : nil;
        return cell;
    }
    else{
        ACTeamTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ACTeamTableViewCell class])];
        cell.activiteInfo = self.activitInfo ? self.activitInfo : nil;
        return cell;
    }
    
}

@end
