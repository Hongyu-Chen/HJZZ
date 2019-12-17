//
//  TheWalletViewController.m
//  HJZSU
//
//  Created by apple on 2019/3/14.
//  Copyright © 2019 apple. All rights reserved.
//

#import "TheWalletViewController.h"
#import "WithdrawalViewController.h"
#import "DetailViewController.h"
#import "TopUpViewController.h"
#import "BankViewController.h"


#define BGImageHeight SCREEN_WIDTH * 827.0/750.0
@interface TheWalletViewController ()

@property (strong,nonatomic) UIImageView *bgImage;
@property (strong,nonatomic) UIButton *moneny;
@property (strong,nonatomic) UIButton *topUp;
@property (strong,nonatomic) UILabel *tip;
@property (strong,nonatomic) UIButton *withdrawal;
@property (strong,nonatomic) UIButton *detailMoneny;
@property (strong,nonatomic) UIButton *cared;

@end

@implementation TheWalletViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.titleLab.text = @"我的钱包";
    self.navigationView.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:self.bgImage];
    [self.view sendSubviewToBack:self.bgImage];
    
    
    self.tip = [LabelCreat creatLabelWith:@"余额（元）" font:[UIFont boldSystemFontOfSize:15] color:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter];
    self.withdrawal = [self bottomBttonWith:@"提现" andTag:100];
    self.detailMoneny = [self bottomBttonWith:@"明细" andTag:101];
    self.cared = [self bottomBttonWith:@"银行卡" andTag:102];
    [self.view addSubview:self.moneny];
    [self.view addSubview:self.tip];
    [self.view addSubview:self.topUp];
    [self.view addSubview:self.withdrawal];
    [self.view addSubview:self.detailMoneny];
    [self.view addSubview:self.cared];
    
    
    [_moneny mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(120.0 * 870.0/750.0);
        make.left.right.equalTo(self.view).offset(0);
    }];
    [_tip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.moneny.mas_bottom).offset(0);
        make.left.right.equalTo(self.view).offset(0);
    }];
    
    [_topUp mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tip.mas_bottom).offset(45);
        make.left.equalTo(self.view).offset((SCREEN_WIDTH - 150)/2);
        make.width.offset(150);
        make.height.offset(50);
    }];
    
    [_withdrawal mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgImage.mas_bottom).offset(0);
        make.left.right.equalTo(self.view).offset(0);
        make.height.offset(64);
    }];
    
    [_detailMoneny mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.withdrawal.mas_bottom).offset(0);
        make.left.right.equalTo(self.view).offset(0);
        make.height.offset(64);
    }];
    
    [_cared mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.detailMoneny.mas_bottom).offset(0);
        make.left.right.equalTo(self.view).offset(0);
        make.height.offset(64);
    }];
    [self.moneny setTitle:[NSString stringWithFormat:@"%.0f",_model.money/100] forState:UIControlStateNormal];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    __weak typeof(self) weakself = self;
    [self getUserInfoSuccess:^(id  _Nonnull result) {
        [weakself setModel:result];
        [weakself.moneny setTitle:[NSString stringWithFormat:@"%.0f",weakself.model.money/100] forState:UIControlStateNormal];
    } failed:^(NSString * _Nonnull reson) {
        [QMUITips showError:reson];
    }];
}

- (UIImageView *)bgImage{
    if (!_bgImage) {
        _bgImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, BGImageHeight)];
        _bgImage.contentMode = UIViewContentModeScaleAspectFill;
        _bgImage.image = [UIImage imageNamed:@"我的钱包底图"];
    }
    return _bgImage;
}

- (UIButton *)moneny{
    if (!_moneny) {
        _moneny = [[UIButton alloc] init];
        [_moneny setTitle:@"0" forState:UIControlStateNormal];
        [_moneny setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _moneny.titleLabel.font = [UIFont boldSystemFontOfSize:45];
        [_moneny addTarget:self action:@selector(topupButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    }
    return _moneny;
}

- (UIButton *)topUp{
    if (!_topUp) {
        _topUp = [[UIButton alloc] init];
        [_topUp setTitleColor:UIColorMake(34, 34, 34) forState:UIControlStateNormal];
        _topUp.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        [_topUp setTitle:@"充值" forState:UIControlStateNormal];
        _topUp.backgroundColor = [UIColor whiteColor];
        _topUp.layer.cornerRadius = 5;
        [_topUp addTarget:self action:@selector(topupButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    }
    return _topUp;
}

- (UIButton *)bottomBttonWith:(NSString *)title andTag:(NSInteger)tag{
    UIButton *button = [[UIButton alloc] init];
    button.tag = tag;
    UILabel *tip = [LabelCreat creatLabelWith:title font:[UIFont boldSystemFontOfSize:15] color:UIColorMake(34, 34, 34) textAlignment:NSTextAlignmentLeft];
    UIImageView *next = [[UIImageView alloc] init];
    next.contentMode = UIViewContentModeScaleAspectFit;
    next.image = [UIImage imageNamed:@"箭头-向右"];
    
    [button addSubview:tip];
    [button addSubview:next];
    [tip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(button).offset(0);
        make.left.equalTo(button).offset(13);
    }];
    [next mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(button).offset(0);
        make.right.equalTo(button).offset(-13);
        make.width.offset(7.5);
    }];
    
    UIView *lien = [[UIView alloc] init];
    lien.backgroundColor = UIColorMake(239, 239, 239);
    [button addSubview:lien];
    [lien mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(button).offset(13);
        make.right.equalTo(button).offset(-13);
        make.bottom.equalTo(button).offset(0);
        make.height.offset(1);
    }];
    [button addTarget: self action:@selector(addMoneyButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

- (void)addMoneyButtonPressed:(UIButton *)sender{
    if (sender.tag == 100) {
        WithdrawalViewController *with = [[WithdrawalViewController alloc] init];
        with.model = self.model;
        [self.navigationController pushViewController:with animated:YES];
    }
    else if(sender.tag == 101){
        [self.navigationController pushViewController:[[DetailViewController alloc] init] animated:YES];
    }
    else if (sender.tag == 102){
        [self.navigationController pushViewController:[[BankViewController alloc] init] animated:YES];
    }
}

- (void)topupButtonPressed{
    [self.navigationController pushViewController:[[TopUpViewController alloc] init] animated:YES];
}

@end
