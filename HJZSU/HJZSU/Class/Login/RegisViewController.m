//
//  RegisViewController.m
//  HJZSS
//
//  Created by apple on 2019/3/5.
//  Copyright © 2019 apple. All rights reserved.
//

#import "RegisViewController.h"
#import "HelpViewController.h"

@interface RegisViewController ()
@property (strong,nonatomic) UILabel *titlelabRegis;
@property (strong,nonatomic) CHYTextField *phone;
@property (strong,nonatomic) CHYTextField *code;
@property (strong,nonatomic) CHYTextField *password;
@property (strong,nonatomic) CHYTextField *passwordArgin;
@property (strong,nonatomic) CHYTextField *intive;
@property (strong,nonatomic) TheCountdown *countDown;
@property (strong,nonatomic) UIButton *regist;
@property (strong,nonatomic) UIButton *selected;
@property (strong,nonatomic) UIButton *protocol;
@property (strong,nonatomic) UILabel *bottom;
@property (strong,nonatomic) UILabel *centerTip;

@end

@implementation RegisViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (instancetype)init{
    self = [super init];
    if (self) {
        self.view.backgroundColor = [UIColor whiteColor];
        self.navigationView.backgroundColor = [UIColor clearColor];
        [self.leftItem setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
        self.titlelabRegis = [LabelCreat creatLabelWith:@"注册" font:[UIFont boldSystemFontOfSize:24] color:UIColorMake(51, 51, 51) textAlignment:NSTextAlignmentCenter];
        UILabel *tip = [LabelCreat creatLabelWith:@"邀请码为推荐的重要凭证，动动手，感谢朋友" font:[UIFont boldSystemFontOfSize:15] color:UIColorMake(137, 137, 137) textAlignment:NSTextAlignmentLeft];
        self.phone = [self creatTextFieldWith:@"请输入手机号" image:[UIImage imageNamed:@"手机"] tag:100];
        self.phone.maxLength = 11;
        self.code = [self creatTextFieldWith:@"请输入验证码" image:[UIImage imageNamed:@"验证码"] tag:101];
        self.code.maxLength = 6;
        self.password = [self creatTextFieldWith:@"请输入新密码" image:[UIImage imageNamed:@"密码"] tag:102];
        self.password.maxLength = 16;
        self.passwordArgin = [self creatTextFieldWith:@"请在此输入密码" image:[UIImage imageNamed:@"密码"] tag:103];
        self.passwordArgin.maxLength = 16;
        self.intive = [self creatTextFieldWith:@"邀请码" image:[UIImage imageNamed:@"邀请码"] tag:104];
        self.intive.maxLength = 8;
        self.bottom = [LabelCreat creatLabelWith:@"商家注册送6000代金券" font:[UIFont systemFontOfSize:15] color:UIColorMake(255, 80, 0) textAlignment:NSTextAlignmentCenter];
        self.centerTip = [LabelCreat creatLabelWith:@"我已阅读并同意" font:[UIFont systemFontOfSize:15] color:UIColorMake(137, 137, 137) textAlignment:NSTextAlignmentLeft];
        
        [self.view addSubview:self.titlelabRegis];
        [self.view addSubview:self.phone];
        [self.view addSubview:self.code];
        [self.view addSubview:self.password];
        [self.view addSubview:self.passwordArgin];
        [self.view addSubview:self.intive];
        [self.view addSubview:tip];
        [self.view addSubview:self.selected];
        [self.view addSubview:self.centerTip];
        [self.view addSubview:self.protocol];
        [self.view addSubview:self.regist];
        [self.view addSubview:self.bottom];
        
        [_titlelabRegis mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).offset(16 + NavigationContentTopConstant);
            make.left.equalTo(self.view).offset(25);
            make.right.equalTo(self.view).offset(-25);
        }];
        
        [_phone mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_titlelabRegis.mas_bottom).offset(38);
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
        
        [_intive mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.passwordArgin.mas_bottom).offset(13);
            make.left.equalTo(self.view).offset(25);
            make.right.equalTo(self.view).offset(-25);
            make.height.offset(40);
        }];
        
        [tip mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.intive.mas_bottom).offset(13);
            make.left.equalTo(self.view).offset(25);
            make.right.equalTo(self.view).offset(-25);
        }];
        
        [_bottom mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.view).offset(-SafeAreaInsetsConstantForDeviceWithNotch.bottom - 40);
            make.left.equalTo(self.view).offset(25);
            make.right.equalTo(self.view).offset(-25);
        }];
        
        [_regist mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.bottom.mas_top).offset(-26);
            make.left.equalTo(self.view).offset(25);
            make.right.equalTo(self.view).offset(-25);
            make.height.offset(50);
        }];
        
        [_selected mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.regist.mas_top).offset(-36);
            make.left.equalTo(self.view).offset(25);
            make.width.height.offset(30);
        }];
        
        [_centerTip mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.regist.mas_top).offset(-36);
            make.left.equalTo(self.selected.mas_right).offset(10);
            make.height.equalTo(self.selected);
        }];
        
        [_protocol mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.regist.mas_top).offset(-36);
            make.left.equalTo(self.centerTip.mas_right).offset(10);
            make.height.equalTo(self.selected);
        }];
    }
    return self;
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
            [weakself.countDown requestToServiceGetCodeWith:weakself.phone.text codeType:2];
        };
    }
    return _countDown;
}

- (UIButton *)regist{
    if (!_regist) {
        _regist = [[UIButton alloc] init];
        _regist.layer.cornerRadius = 5;
        _regist.backgroundColor = UIColorMake(255, 80, 0);
        [_regist setTitle:@"注册" forState:UIControlStateNormal];
        [_regist setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _regist.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        [_regist addTarget:self action:@selector(registerButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _regist;
}

- (UIButton *)selected{
    if (!_selected) {
        _selected = [[UIButton alloc] init];
        [_selected setImage:[UIImage imageNamed:@"勾选-未选中"] forState:UIControlStateNormal];
        [_selected setImage:[UIImage imageNamed:@"勾选"] forState:UIControlStateSelected];
        _selected.imageView.contentMode = UIViewContentModeScaleAspectFit;
        _selected.imageEdgeInsets = UIEdgeInsetsMake(7.5, 7.5, 7.5, 7.5);
        [_selected addTarget:self action:@selector(selectedButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selected;
}

- (void)setOtherLogin:(NSMutableDictionary *)otherLogin{
    _otherLogin = otherLogin;
    if (_otherLogin) {
        if ([self.otherLogin[@"loginType"] integerValue] == 2) {
            self.titlelabRegis.text = @"手机验证";
            self.password.hidden = YES;
            self.passwordArgin.hidden = YES;
            [self.intive mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.code.mas_bottom).offset(13);
            }];
            [self.regist setTitle:@"验证" forState:UIControlStateNormal];
            self.selected.hidden = YES;
            self.bottom.hidden = YES;
            self.centerTip.hidden = YES;
            self.protocol.hidden = YES;
        }
    }
}

- (UIButton *)protocol{
    if (!_protocol) {
        _protocol = [[UIButton alloc] init];
        [_protocol setTitle:@"《用户协议》" forState:UIControlStateNormal];
        [_protocol setTitleColor:UIColorMake(51, 51, 51) forState:UIControlStateNormal];
        _protocol.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        [_protocol addTarget:self action:@selector(protolButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    }
    return _protocol;
}

- (void)protolButtonPressed{
    HIDDENKEYBORD;
    HelpViewController *help = [[HelpViewController alloc] init];
    help.type = HelpStatusProtol;
    [self.navigationController pushViewController:help animated:YES];
}

- (void)selectedButtonPressed:(UIButton *)sender{
    HIDDENKEYBORD;
    sender.selected = !sender.selected;
}

- (void)registerButtonPressed:(UIButton *)sender{
    HIDDENKEYBORD;
    if (![_phone.text authenicationIsPhone]) {
        return;
    }
    
    if (![_code.text authenicationMessageCode]) {
        return;
    }
    
    if (!_otherLogin){
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
        if (!_selected.selected) {
            [QMUITips showError:@"请阅读并同意《用户协议》" inView:[UIApplication sharedApplication].keyWindow hideAfterDelay:1.0];
            return;
        }
    }
    
    if (!self.otherLogin) {
        self.otherLogin = [[NSMutableDictionary alloc] init];
        [self.otherLogin setObject:@"1" forKey:@"loginType"];
    }
    [self.otherLogin setObject:_phone.text forKey:@"phone"];
    if ([self.otherLogin[@"loginType"] integerValue] == 2) {
        [self.otherLogin setObject:[@"123456" md5Digest] forKey:@"password"];
    }
    else{
        [self.otherLogin setObject:[_password.text md5Digest] forKey:@"password"];
    }
    [self.otherLogin setObject:_code.text forKey:@"code"];
    if (!IsNullString(_intive.text)) {
        [self.otherLogin setObject:_code.text forKey:@"inviteCode"];
    }
    else{
        [self.otherLogin setObject:@"" forKey:@"inviteCode"];
    }
    
//    if ([self.otherLogin[@"loginType"] integerValue] == 2) {
//        [self otherLoginBindPhone:self.otherLogin[@"phone"] code:self.otherLogin[@"code"] openType:self.otherLogin[@"openType"] inviteCode:self.otherLogin[@"inviteCode"] success:^(id  _Nonnull result) {
//            [self loginSuccesWith:result[@"data"]];
//        } failed:^(NSString * _Nonnull reson) {
//            [QMUITips showError:reson];
//        }];
//    }
//    else{
//        [self userRegisWith:self.otherLogin success:^(id  _Nonnull result) {
//            [QMUITips showSucceed:@"注册成功" inView:KINGWIDWOWN hideAfterDelay:1.0];
//            [self.navigationController popViewControllerAnimated:YES];
//        } failed:^(NSString * _Nonnull reson) {
//            [QMUITips showError:reson inView:KINGWIDWOWN hideAfterDelay:1.0];
//        }];
//    }
    
    if ([self.otherLogin[@"loginType"] integerValue] == 2) {
        [self.otherLogin removeObjectForKey:@"loginType"];
    }
    
    [self userRegisWith:self.otherLogin success:^(id  _Nonnull result) {
        [QMUITips showSucceed:@"注册成功" inView:KINGWIDWOWN hideAfterDelay:1.0];
        [self.navigationController popViewControllerAnimated:YES];
    } failed:^(NSString * _Nonnull reson) {
        [QMUITips showError:reson inView:KINGWIDWOWN hideAfterDelay:1.0];
    }];
}

- (void)loginSuccesWith:(id)result{
    [QMUITips showSucceed:@"登录成功" inView:KINGWIDWOWN hideAfterDelay:1.0];
    [[YYCacheManager shareYYCacheManager] saveDic:result forKey:LOGIN];
    if (self.navigationController.viewControllers.count > 1) {
        [BANetManager sharedBANetManager].httpHeaderFieldDictionary = @{@"uid":[[YYCacheManager shareYYCacheManager] uid],@"token":[[YYCacheManager shareYYCacheManager] token]};
        [[EMClient sharedClient] loginWithUsername:[NSString stringWithFormat:@"user%@",[[YYCacheManager shareYYCacheManager] getSaveInfo:LOGIN][@"id"]]
                                          password:[NSString stringWithFormat:@"user%@",[[YYCacheManager shareYYCacheManager] getSaveInfo:LOGIN][@"id"]]
                                        completion:^(NSString *aUsername, EMError *aError) {
                                            if (!aError) {
                                                NSLog(@"登录成功");
                                            } else {
                                                NSLog(@"登录失败");
                                            }
                                        }];
        [self.navigationController popViewControllerAnimated:YES];
    }
    else{
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [appDelegate changedRootController];
    }
}


@end
