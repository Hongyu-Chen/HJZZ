//
//  ALipayViewController.m
//  HJZSS
//
//  Created by apple on 2019/3/4.
//  Copyright © 2019 apple. All rights reserved.
//

#import "ALipayViewController.h"

@interface ALipayViewController ()

@property (strong,nonatomic) UIView *tipView;
@property (strong,nonatomic) UITextField *account;
@property (strong,nonatomic) UITextField *name;
@property (strong,nonatomic) UITextField *phone;
@property (strong,nonatomic) UITextField *code;
@property (strong,nonatomic) TheCountdown *countDown;
@property (strong,nonatomic) UIButton *sure;


@end

@implementation ALipayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleLab.text = @"提现";
    
    self.account = [self creatWith:@"输入支付宝账号" placeholder:@"输入支付宝账号" tag:100];
    self.name = [self creatWith:@"输入姓名" placeholder:@"输入姓名" tag:101];
    self.phone = [self creatWith:@"输入手机号" placeholder:@"输入手机号" tag:102];
    self.code = [self creatWith:@"验证码" placeholder:@"验证码" tag:103];
    [self.view addSubview:self.tipView];
    [self.view addSubview:self.account];
    [self.view addSubview:self.name];
    [self.view addSubview:self.phone];
    [self.view addSubview:self.code];
    [self.view addSubview:self.sure];
    
    [_tipView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(NavigationContentTopConstant);
        make.left.right.equalTo(self.view).offset(0);
        make.height.offset(50);
    }];
    
    [_account mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tipView.mas_bottom).offset(0);
        make.left.right.equalTo(self.view).offset(0);
        make.height.offset(50);
    }];
    
    [_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.account.mas_bottom).offset(0);
        make.left.right.equalTo(self.view).offset(0);
        make.height.offset(50);
    }];
    
    [_phone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.name.mas_bottom).offset(0);
        make.left.right.equalTo(self.view).offset(0);
        make.height.offset(50);
    }];

    [_code mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.phone.mas_bottom).offset(0);
        make.left.right.equalTo(self.view).offset(0);
        make.height.offset(50);
    }];
    
    [_sure mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-SafeAreaInsetsConstantForDeviceWithNotch.bottom - 40);
        make.left.equalTo(self.view).offset(13);
        make.right.equalTo(self.view).offset(-13);
        make.height.offset(50);
    }];
}

- (UIView *)tipView{
    if (!_tipView) {
        _tipView = [[UIView alloc] init];
        _tipView.backgroundColor = [UIColor whiteColor];
        UILabel *label = [LabelCreat creatLabelWith:@"验证支付宝账号" font:[UIFont boldSystemFontOfSize:14] color:UIColorMake(34, 34, 34) textAlignment:NSTextAlignmentLeft];
        [_tipView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.tipView).offset(0);
            make.left.equalTo(self.tipView).offset(13);
        }];
        UIView *lien = [[UIView alloc] init];
        lien.backgroundColor = UIColorMake(239, 239, 239);
        [_tipView addSubview:lien];
        [lien mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.tipView).offset(13);
            make.right.equalTo(self.tipView).offset(-13);
            make.bottom.equalTo(self.tipView).offset(0);
            make.height.offset(1);
        }];
    }
    return _tipView;
}

- (CHYTextField *)creatWith:(NSString *)tipStr placeholder:(NSString *)placeholder tag:(NSInteger)tag{
    CHYTextField *textFiled = [[CHYTextField alloc] init];
    textFiled.backgroundColor = [UIColor whiteColor];
    textFiled.placeholder = placeholder;
    textFiled.font = [UIFont boldSystemFontOfSize:14];
    UIView *left = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 13, 50)];
    textFiled.leftView = left;
    if (tag == 103) {
        textFiled.rightView = self.countDown;
    }
    else{
        UIView *right = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 13, 50)];
        textFiled.rightView = right;
    }
    textFiled.leftViewMode = textFiled.rightViewMode = UITextFieldViewModeAlways;
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = self.view.backgroundColor;
    [textFiled addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(textFiled).offset(0);
        make.height.offset(1);
    }];
    return textFiled;
}

- (TheCountdown *)countDown{
    if (!_countDown) {
        _countDown = [[TheCountdown alloc] init];
        _countDown.frame = CGRectMake(0, 0, 100, 50);
        _countDown.codeType = VitedCodeTypeBindPhone;
        _countDown.style = TheCountdownStyleOnlyTime;
        _countDown.timeLabColor = UIColorMake(255, 80, 0);
        _countDown.stateLabColor = UIColorMake(255, 80, 0);
        _countDown.loadColor = UIColorMake(255, 80, 0);
        _countDown.stateFont = [UIFont boldSystemFontOfSize:15];
        _countDown.timeFont = [UIFont boldSystemFontOfSize:15];
        __weak typeof(self) weakself = self;
        _countDown.userClickedBtn = ^(BOOL state) {
            if (![weakself.phone.text authenicationIsPhone]) {
                return;
            }
            [weakself.countDown requestToServiceGetCodeWith:weakself.phone.text codeType:1];
        };
    }
    return _countDown;
}

- (UIButton *)sure{
    if (!_sure) {
        _sure = [[UIButton alloc] init];
        [_sure setTitle:@"提现" forState:UIControlStateNormal];
        _sure.titleLabel.font = [UIFont systemFontOfSize:15];
        [_sure setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _sure.layer.cornerRadius = 5;
        _sure.backgroundColor = UIColorMake(255, 80, 0);
        [_sure addTarget:self action:@selector(bottomBottonPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sure;
}

- (void)bottomBottonPressed:(UIButton *)sender{
    if (IsNullString(_account.text)) {
        [QMUITips showError:_account.placeholder];
        return;
    }
    if (IsNullString(_name.text)) {
        [QMUITips showError:_name.placeholder];
        return;
    }
    
    if (![_phone.text authenicationIsPhone]) {
        return;
    }
    if (![_code.text authenicationMessageCode]) {
        return;
    }
    
    [_input setObject:_account.text forKey:@"account"];
    [_input setObject:_name.text forKey:@"name"];
    [_input setObject:_code.text forKey:@"code"];
    __weak typeof(self) weakself = self;
    [self withdrawalWith:_input success:^(id  _Nonnull result) {
        SuccessViewController *success = [[SuccessViewController alloc] init];
        success.type = SuccessTypeWithdrawal;
        [weakself.navigationController pushViewController:success animated:YES];
    } failed:^(NSString * _Nonnull reson) {
        [QMUITips showError:reson];
    }];
}


@end
