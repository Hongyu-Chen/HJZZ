//
//  ForgetViewController.m
//  HJZSS
//
//  Created by apple on 2019/3/5.
//  Copyright © 2019 apple. All rights reserved.
//

#import "ForgetViewController.h"

@interface ForgetViewController ()

@property (strong,nonatomic) CHYTextField *phone;
@property (strong,nonatomic) CHYTextField *code;
@property (strong,nonatomic) CHYTextField *password;
@property (strong,nonatomic) CHYTextField *passwordArgin;
@property (strong,nonatomic) TheCountdown *countDown;
@property (strong,nonatomic) UIButton *sure;

@end

@implementation ForgetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationView.backgroundColor = [UIColor clearColor];
    [self.leftItem setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    UILabel *titlelab = [LabelCreat creatLabelWith:@"忘记密码" font:[UIFont boldSystemFontOfSize:24] color:UIColorMake(51, 51, 51) textAlignment:NSTextAlignmentCenter];
    self.phone = [self creatTextFieldWith:@"请输入手机号" image:[UIImage imageNamed:@"手机"] tag:100];
    self.code = [self creatTextFieldWith:@"请输入验证码" image:[UIImage imageNamed:@"验证码"] tag:101];
    self.password = [self creatTextFieldWith:@"请输入新密码" image:[UIImage imageNamed:@"密码"] tag:102];
    self.passwordArgin = [self creatTextFieldWith:@"请在此输入密码" image:[UIImage imageNamed:@"密码"] tag:103];
    
    [self.view addSubview:titlelab];
    [self.view addSubview:self.phone];
    [self.view addSubview:self.code];
    [self.view addSubview:self.password];
    [self.view addSubview:self.passwordArgin];
    [self.view addSubview:self.sure];
    
    [titlelab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(16 + NavigationContentTopConstant);
        make.left.equalTo(self.view).offset(25);
        make.right.equalTo(self.view).offset(-25);
    }];
    
    [_phone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titlelab.mas_bottom).offset(38);
        make.left.equalTo(self.view).offset(25);
        make.right.equalTo(self.view).offset(-25);
        make.height.offset(40);
    }];
    
    [_code mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.phone.mas_bottom).offset(13);
        make.left.equalTo(self.view).offset(25);
        make.right.equalTo(self.view).offset(-25);
        make.height.offset(40);
    }];
    
    [_password mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.code.mas_bottom).offset(13);
        make.left.equalTo(self.view).offset(25);
        make.right.equalTo(self.view).offset(-25);
        make.height.offset(40);
    }];
    
    [_passwordArgin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.password.mas_bottom).offset(13);
        make.left.equalTo(self.view).offset(25);
        make.right.equalTo(self.view).offset(-25);
        make.height.offset(40);
    }];
    
    [_sure mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-SafeAreaInsetsConstantForDeviceWithNotch.bottom - 40);
        make.left.equalTo(self.view).offset(25);
        make.right.equalTo(self.view).offset(-25);
        make.height.offset(50);
    }];
}

- (CHYTextField *)creatTextFieldWith:(NSString *)placeholder image:(UIImage *)image tag:(NSInteger)tag{
    CHYTextField *textField = [[CHYTextField alloc] init];
    textField.placeholder = placeholder;
    textField.tag = tag;
    UIImageView *left = [[UIImageView alloc] initWithFrame:CGRectMake(0, 12.5, 38, 15)];
    left.contentMode = UIViewContentModeScaleAspectFit;
    left.image = image;
    textField.leftView = left;
    
    if (tag == 101) {
        textField.rightView = self.countDown;
    }
    if (tag < 102) {
        textField.keyboardType = UIKeyboardTypeNumberPad;
    }
    else{
        if (textField.tag == 102 || textField.tag == 103) {
            textField.secureTextEntry = YES;
        }
        textField.keyboardType = UIKeyboardTypeDefault;
    }
    
    textField.leftViewMode = textField.rightViewMode = UITextFieldViewModeAlways;
    textField.font = [UIFont boldSystemFontOfSize:15];
    textField.backgroundColor = UIColorMake(239, 239, 239);
    textField.layer.cornerRadius = 5;
    textField.clipsToBounds = YES;
    return textField;
}

- (TheCountdown *)countDown{
    if (!_countDown) {
        _countDown = [[TheCountdown alloc] init];
        _countDown.frame = CGRectMake(0, 0, 130, 40);
        _countDown.codeType = VitedCodeTypeBindPhone;
        _countDown.style = TheCountdownStyleOnlyTime;
        _countDown.timeLabColor = UIColorMake(255, 80, 0);
        _countDown.stateLabColor = UIColorMake(255, 80, 0);
        _countDown.loadColor = UIColorMake(255, 80, 0);
        _countDown.stateFont = [UIFont boldSystemFontOfSize:15];
        _countDown.timeFont = [UIFont boldSystemFontOfSize:15];
        _countDown.backgroundColor = [UIColor whiteColor];
        _countDown.layer.cornerRadius = 5.0;
        _countDown.layer.borderColor = UIColorMake(222, 222, 222).CGColor;
        _countDown.layer.borderWidth = 1.0;
        __weak typeof(self) weakself = self;
        _countDown.userClickedBtn = ^(BOOL state) {
            HIDDENKEYBORD;
            if (![weakself.phone.text authenicationIsPhone]) {
                return;
            }
            [weakself.countDown requestToServiceGetCodeWith:weakself.phone.text codeType:4];
        };
    }
    return _countDown;
}

- (UIButton *)sure{
    if (!_sure) {
        _sure = [[UIButton alloc] init];
        _sure.layer.cornerRadius = 5;
        _sure.backgroundColor = UIColorMake(255, 80, 0);
        [_sure setTitle:@"确定" forState:UIControlStateNormal];
        [_sure setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _sure.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        [_sure addTarget:self action:@selector(changedPassword:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sure;
}

- (void)changedPassword:(UIButton *)sender{
    HIDDENKEYBORD;
    if (![_phone.text authenicationIsPhone]) {
        return;
    }
    if (![_code.text authenicationMessageCode]) {
        return;
    }
    if (![_password.text authenicationPassword]) {
        return;
    }
    if (![_passwordArgin.text authenicationAgreenPassword]) {
        return;
    }
    if (![_password.text isEqualToString:_passwordArgin.text]) {
        [QMUITips showError:@"两次不一致" inView:[UIApplication sharedApplication].keyWindow hideAfterDelay:1.0];
        return;
    }
    
    [self userChangPassword:@{@"phone":_phone.text,@"code":_code.text,@"password":[_password.text md5Digest]} success:^(id  _Nonnull result) {
        [QMUITips showSucceed:@"密码更改成功" inView:KINGWIDWOWN hideAfterDelay:1.0];
        [self.navigationController popViewControllerAnimated:YES];
    } failed:^(NSString * _Nonnull reson) {
        [QMUITips showError:reson inView:[UIApplication sharedApplication].keyWindow hideAfterDelay:1.0];
    }];
    
}

@end
