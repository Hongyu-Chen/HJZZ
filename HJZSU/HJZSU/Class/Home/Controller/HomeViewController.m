//
//  HomeViewController.m
//  呼叫战神
//
//  Created by apple on 2019/2/25.
//  Copyright © 2019 apple. All rights reserved.
//

#import "HomeViewController.h"
#import "LoginViewController.h"
#import "HomeListTableViewCell.h"
#import "HomeSCTableViewCell.h"
#import "LocationViewController.h"
#import "ACInfoViewController.h"
#import "GYZChooseCityController.h"
#import "CertificationViewController.h"


@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource,GYZChooseCityDelegate>

@property (strong,nonatomic) UITableView *tableView;
@property (strong,nonatomic) NSArray *bannerList;
@property (strong,nonatomic) NSArray *listData;
@property (strong,nonatomic) AMapLocationManager *locationManager;
@property (strong,nonatomic) QMUIButton *locationBtn;

@end

@implementation HomeViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"firstStart"]){
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstStart"];
        LeadView *leadView = [[LeadView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) withData:@[@"引导页1",@"引导页2",@"引导页3"]];
        [leadView show];
    }else{
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleLab.text = @"呼叫战神";
    self.leftItem.hidden = YES;
    [self.navigationView addSubview:self.locationBtn];
    [self.rightBtn setImage:[UIImage imageNamed:@"消息"] forState:UIControlStateNormal];
    [self.view addSubview:self.tableView];
    
    [self refershTableViewData];
    
    self.locationManager = [[AMapLocationManager alloc] init];
    self.locationManager.locatingWithReGeocode = YES;
    [self.locationManager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        [self.locationBtn setTitle:regeocode.city forState:UIControlStateNormal];
    }];
}

- (QMUIButton *)locationBtn{
    if (!_locationBtn) {
        _locationBtn = [[QMUIButton alloc] initWithFrame:CGRectMake(0, StatusBarHeightConstant, 60, NavigationBarHeight)];
        [_locationBtn setImage:[UIImage imageNamed:@"首页-定位"] forState:UIControlStateNormal];
        [_locationBtn setTitle:@"定位..." forState:UIControlStateNormal];
        _locationBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [_locationBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _locationBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [_locationBtn addTarget:self action:@selector(locationBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    }
    return _locationBtn;
}

- (void)locationBtnPressed{
    GYZChooseCityController *cityPickerVC = [[GYZChooseCityController alloc] init];
    [cityPickerVC setDelegate:self];
    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:cityPickerVC] animated:YES completion:^{
        
    }];
}

- (void)refershTableViewData{
    [self getHomePageBannerSuccess:^(id  _Nonnull result) {
        self.bannerList = result;
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
    } failed:^(NSString * _Nonnull reson) {
        ;
    }];
    
    [self getHomeActiviteListSuccess:^(id  _Nonnull result) {
        self.listData = result;
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
        [self.tableView.mj_header endRefreshing];
    } failed:^(NSString * _Nonnull reson) {
        [self.tableView.mj_header endRefreshing];
    }];
}

- (void)righttemButtenPressed:(UIButton *)sender{
    [self.navigationController pushViewController:[[MessageListViewController alloc] init] animated:YES];
}


- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NavigationContentTopConstant, SCREEN_WIDTH, SCREEN_HEIGHT - TabBarHeight - NavigationContentTopConstant)];
        _tableView.backgroundColor = self.view.backgroundColor;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[HomeSCTableViewCell class] forCellReuseIdentifier:NSStringFromClass([HomeSCTableViewCell class])];
        [_tableView registerClass:[HomeListTableViewCell class] forCellReuseIdentifier:NSStringFromClass([HomeListTableViewCell class])];
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        _tableView.mj_header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(refershTableViewData)];
    }
    return _tableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    else{
        return self.listData ? self.listData.count : 0;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 415;
    }
    else{
        return 130;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        HomeSCTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HomeSCTableViewCell class])];
        cell.bannerData = self.bannerList ? self.bannerList : nil;
        return cell;
    }
    else{
        HomeListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HomeListTableViewCell class])];
        cell.cellInfo = self.listData ? self.listData[indexPath.row] : nil;
        return cell;
    }
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

- (void) cityPickerController:(GYZChooseCityController *)chooseCityController
                didSelectCity:(GYZCity *)city{
    [self.locationBtn setTitle:city.cityName forState:UIControlStateNormal];
    [chooseCityController dismissViewControllerAnimated:YES completion:^{
        
    }];
    
}
- (void) cityPickerControllerDidCancel:(GYZChooseCityController *)chooseCityController{
    [chooseCityController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

@end
