//
//  InvitePhoneViewController.m
//  HJZSS
//
//  Created by apple on 2019/3/5.
//  Copyright © 2019 apple. All rights reserved.
//

#import "InvitePhoneViewController.h"

@interface InvitePhoneViewController ()

@property (strong,nonatomic) CHYTextField *phone;
@property (strong,nonatomic) CHYTextField *code;
@property (strong,nonatomic) CHYTextField *intive;
@property (strong,nonatomic) TheCountdown *countDown;
@property (strong,nonatomic) UIButton *sure;

@end

@implementation InvitePhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationView.backgroundColor = [UIColor clearColor];
    [self.leftItem setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    UILabel *titlelab = [LabelCreat creatLabelWith:@"手机验证" font:[UIFont boldSystemFontOfSize:24] color:UIColorMake(51, 51, 51) textAlignment:NSTextAlignmentCenter];
    self.phone = [self creatTextFieldWith:@"请输入手机号" image:[UIImage imageNamed:@"手机"] tag:100];
    self.code = [self creatTextFieldWith:@"请输入验证码" image:[UIImage imageNamed:@"验证码"] tag:101];
    self.intive = [self creatTextFieldWith:@"邀请码" image:[UIImage imageNamed:@"邀请码"] tag:104];
    
    [self.view addSubview:titlelab];
    [self.view addSubview:self.phone];
    [self.view addSubview:self.code];
    [self.view addSubview:self.intive];
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
    
    [_intive mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.code.mas_bottom).offset(13);
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
    
    UIImageView *left = [[UIImageView alloc] initWithFrame:CGRectMake(0, 12.5, 38, 15)];
    left.contentMode = UIViewContentModeScaleAspectFit;
    left.image = image;
    textField.leftView = left;
    
    if (tag == 101) {
        textField.rightView = self.countDown;
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
            [weakself.countDown requestToServiceGetCodeWith:@"" codeType:1];
        };
    }
    return _countDown;
}

- (UIButton *)sure{
    if (!_sure) {
        _sure = [[UIButton alloc] init];
        _sure.layer.cornerRadius = 5;
        _sure.backgroundColor = UIColorMake(255, 80, 0);
        [_sure setTitle:@"登入" forState:UIControlStateNormal];
        [_sure setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _sure.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    }
    return _sure;
}


@end
