//
//  MineViewController.m
//  呼叫战神
//
//  Created by apple on 2019/2/25.
//  Copyright © 2019 apple. All rights reserved.
//

#import "MineViewController.h"
#import "TheWalletViewController.h"
#import "SettingViewController.h"
#import "MyVouchersViewController.h"
#import "MySubmitViewController.h"
#import "ByPlanViewController.h"
#import "MCollectionViewController.h"
#import "UserInfoViewController.h"
#import "ToPromoteViewController.h"

#define topViewHeight SCREEN_WIDTH * 428.0/750.0
@interface MineViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>

//@property (strong,nonatomic) UIView *topView;
@property (strong,nonatomic) UIImageView *topBg;
@property (strong,nonatomic) UITableView *tableView;
@property (strong,nonatomic) UIImageView *headerImage;
@property (strong,nonatomic) UILabel *name;
@property (strong,nonatomic) UILabel *idLabel;
@property (strong,nonatomic) UserBaseModel *userInfo;
@property (strong,nonatomic) UILabel *authStatus;

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationView.hidden = YES;
    
    [self.view addSubview:self.topBg];
    [self.view addSubview:self.tableView];
    [self.view sendSubviewToBack:self.tableView];
    [self addUserInfo];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self reloadSelfViewData];
}

- (void)reloadSelfViewData{
    __weak typeof(self) weakself = self;
    [self getUserInfoSuccess:^(id  _Nonnull result) {
        [weakself setUserInfo:result];
        weakself.name.text = weakself.userInfo.name;
        [weakself.headerImage sd_setImageWithURL:[NSURL URLWithString:weakself.userInfo.head] placeholderImage:PLACEHOLDERIMAGE];
        weakself.authStatus.text = @[@"未认证",@"认证中",@"认证通过",@"认证未通过"][weakself.userInfo ? weakself.userInfo.auth : 0];
        [[YYCacheManager shareYYCacheManager] uploadUserInfoWith:@{@"auth":[NSNumber numberWithInteger:weakself.userInfo.auth]}];
    } failed:^(NSString * _Nonnull reson) {
        [QMUITips showError:reson];
    }];
}


- (void)addUserInfo{
    _topBg.frame = CGRectMake(0, 0, SCREEN_WIDTH, topViewHeight);
    self.name = [LabelCreat creatLabelWith:@"" font:[UIFont boldSystemFontOfSize:18] color:[UIColor whiteColor] textAlignment:NSTextAlignmentLeft];
    self.idLabel = [LabelCreat creatLabelWith:[NSString stringWithFormat:@"ID:%@",[[YYCacheManager shareYYCacheManager] uid]] font:[UIFont boldSystemFontOfSize:13] color:[UIColor whiteColor] textAlignment:NSTextAlignmentLeft];

    [self.topBg addSubview:self.headerImage];
    [self.topBg addSubview:self.name];
    [self.topBg addSubview:self.idLabel];
    [self.topBg addSubview:self.authStatus];

    [_headerImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topBg).offset((topViewHeight - 84)/2);
        make.left.equalTo(self.topBg).offset(13);
        make.width.height.offset(84);
    }];

    [_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerImage.mas_top).offset(0);
        make.bottom.equalTo(self.headerImage.mas_bottom).offset(0);
        make.left.equalTo(self.headerImage.mas_right).offset(13);
    }];
    
    [_authStatus mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headerImage.mas_right).offset(13);
        make.top.equalTo(self.topBg).offset((topViewHeight - 84)/2 + 42 + 15);
    }];

    [_idLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topBg).offset((topViewHeight - 84)/2);
        make.height.equalTo(self.headerImage);
        make.right.equalTo(self.topBg).offset(-13);
    }];
}

- (UIImageView *)headerImage{
    if (!_headerImage) {
        _headerImage = [[UIImageView alloc] init];
        _headerImage.layer.cornerRadius = 42;
        _headerImage.layer.borderWidth = 3.0;
        _headerImage.layer.borderColor = [UIColor whiteColor].CGColor;
        _headerImage.userInteractionEnabled = YES;
        _headerImage.clipsToBounds = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headerTap)];
        [_headerImage addGestureRecognizer:tap];
    }
    return _headerImage;
}

-(UIImageView *)topBg{
    if (!_topBg) {
        _topBg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_HEIGHT, topViewHeight)];
        _topBg.contentMode = UIViewContentModeScaleAspectFill;
        _topBg.clipsToBounds = YES;
        _topBg.image = [UIImage imageNamed:@"个人中心底图.png"];
        _topBg.userInteractionEnabled = YES;
    }
    return _topBg;
}

- (UILabel *)authStatus{
    if (!_authStatus) {
        _authStatus = [LabelCreat creatLabelWith:@" " font:[UIFont systemFontOfSize:12] color:[UIColor whiteColor] textAlignment:NSTextAlignmentLeft];
    }
    return _authStatus;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, topViewHeight, SCREEN_WIDTH, SCREEN_HEIGHT - TabBarHeight - topViewHeight)];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        //        _tableView.sc
        _tableView.backgroundColor = UIColorMake(239, 239, 239);
    }
    return _tableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return section == 0 ? 3 : 4;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return section == 0 ? 0 : 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = UIColorMake(239, 239, 239);;
    if (section == 0) {
        return nil;
    }
    else{
        return view;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mineCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"mainCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UIImageView *icon = [[UIImageView alloc] init];
        icon.contentMode = UIViewContentModeScaleAspectFit;
        icon.tag = 100;
        UILabel *tip = [LabelCreat creatLabelWith:@"" font:[UIFont systemFontOfSize:15] color:UIColorMake(51, 51, 51) textAlignment:NSTextAlignmentLeft];
        tip.tag = 101;
        UIImageView *next = [[UIImageView alloc] init];
        next.contentMode = UIViewContentModeScaleAspectFit;
        next.image = [UIImage imageNamed:@"箭头-向右"];
        
        [cell addSubview:icon];
        [cell addSubview:tip];
        [cell addSubview:next];
        
        [icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(cell).offset(0);
            make.left.equalTo(cell).offset(13);
            make.width.offset(20);
        }];
        
        [tip mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(cell).offset(0);
            make.left.equalTo(icon.mas_right).offset(10);
        }];
        
        [next mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(cell).offset(0);
            make.right.equalTo(cell).offset(-13);
            make.width.offset(7.5);
        }];
        
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = self.view.backgroundColor;
        [cell addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(cell).offset(0);
            make.height.offset(1);
        }];
    }
    
    UIImageView *tmpIcon = [cell viewWithTag:100];
    UILabel *value = [cell viewWithTag:101];
    tmpIcon.image = [UIImage imageNamed:@[@[@"我的钱包",@"购买的砝码",@"我的收藏"],@[@"代金券",@"发布记录",@"我的推广",@"设置"]][indexPath.section][indexPath.row]];
    value.text = @[@[@"我的钱包",@"购买砝码",@"我的收藏"],@[@"代金券",@"发布记录",@"我的推广",@"设置"]][indexPath.section][indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            TheWalletViewController *moneny = [[TheWalletViewController alloc] init];
            moneny.model = self.userInfo;
            [self.navigationController pushViewController:moneny animated:YES];
        }
        else if (indexPath.row == 1){
            [self.navigationController pushViewController:[[ByPlanViewController alloc] init] animated:YES];
        }
        else if (indexPath.row == 2){
            [self.navigationController pushViewController:[[MCollectionViewController alloc] init] animated:YES];
        }
    }
    else{
        if (indexPath.row == 0) {
            [self.navigationController pushViewController:[[MyVouchersViewController alloc] init] animated:YES];
        }
        else if (indexPath.row == 1){
            [self.navigationController pushViewController:[[MySubmitViewController alloc] init] animated:YES];
        }
        else if (indexPath.row == 2){
            [self.navigationController pushViewController:[[ToPromoteViewController alloc] init] animated:YES];
        }
        else if(indexPath.row == 3){
            [self.navigationController pushViewController:[[SettingViewController alloc] init] animated:YES];
        }
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.y < 0) {
        self.topBg.frame = CGRectMake(0, 0, SCREEN_WIDTH, topViewHeight - scrollView.contentOffset.y);
    }
}

- (void)headerTap{
    UserInfoViewController *userInfo = [[UserInfoViewController alloc] init];
    [self.navigationController pushViewController:userInfo animated:YES];
}


@end
