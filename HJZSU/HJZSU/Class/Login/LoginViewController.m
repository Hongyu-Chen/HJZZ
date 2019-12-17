//
//  LoginViewController.m
//  HJZSS
//
//  Created by apple on 2019/3/5.
//  Copyright © 2019 apple. All rights reserved.
//

#import "LoginViewController.h"
#import "TipLabel.h"
#import "RegisViewController.h"
#import "ForgetViewController.h"
#import "InvitePhoneViewController.h"
#import "InputInfoViewController.h"

@interface LoginViewController ()

@property (strong,nonatomic) UIImageView *headerImage;
@property (strong,nonatomic) CHYTextField *account;
@property (strong,nonatomic) CHYTextField *password;
@property (strong,nonatomic) TheCountdown *countDown;
@property (strong,nonatomic) UIButton *forgetPs;
@property (strong,nonatomic) UIButton *login;
@property (strong,nonatomic) UIButton *regist;
@property (strong,nonatomic) UIButton *wechat;
@property (strong,nonatomic) UIButton *qq;


@end

@implementation LoginViewController

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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userLoginSuccessWithWechat:) name:WX_NOTICE_NAME object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userLoginSuccessWithQQ:) name:QQ_NOTICE_NAME object:nil];
    self.navigationView.hidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    self.account = [self creatTextFieldWith:@"请输入手机号" image:[UIImage imageNamed:@"手机"] tag:100];
    self.password = [self creatTextFieldWith:@"请输入密码" image:[UIImage imageNamed:@"密码"] tag:101];
    TipLabel *tip = [[TipLabel alloc] init];
    tip.text = @"其他登录方式";
    
    [self.view addSubview:self.headerImage];
    [self.view addSubview:self.account];
    [self.view addSubview:self.password];
    [self.view addSubview:self.forgetPs];
    [self.view addSubview:self.login];
    [self.view addSubview:self.regist];
    [self.view addSubview:tip];
    [self.view addSubview:self.wechat];
    [self.view addSubview:self.qq];
    
    [_headerImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(65);
        make.left.right.equalTo(self.view).offset(0);
        make.height.offset(98);
    }];
    
    [_account mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerImage.mas_bottom).offset(39);
        make.left.equalTo(self.view).offset(25);
        make.right.equalTo(self.view).offset(-25);
        make.height.offset(40);
    }];
    
    [_password mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.account.mas_bottom).offset(13);
        make.left.equalTo(self.view).offset(25);
        make.right.equalTo(self.view).offset(-25);
        make.height.offset(40);
    }];
    
    [_forgetPs mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.password.mas_bottom).offset(40);
        make.right.equalTo(self.view).offset(-25);
    }];
    
    [_login mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.password.mas_bottom).offset(95);
        make.left.equalTo(self.view).offset(25);
        make.right.equalTo(self.view).offset(-25);
        make.height.offset(50);
    }];
    
    [_regist mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.login.mas_bottom).offset(36);
        make.left.equalTo(self.view).offset(25);
        make.right.equalTo(self.view).offset(-25);
    }];
    
    [tip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.wechat.mas_top).offset(-30);
        make.left.equalTo(self.view).offset(25);
        make.right.equalTo(self.view).offset(-25);
    }];
    
    [_wechat mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-SafeAreaInsetsConstantForDeviceWithNotch.bottom - 40);
        make.width.height.offset(40);
        make.left.equalTo(self.view).offset((SCREEN_WIDTH - 120)/2);
    }];
    
    [_qq mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-SafeAreaInsetsConstantForDeviceWithNotch.bottom - 40);
        make.width.height.offset(40);
        make.right.equalTo(self.view).offset(-(SCREEN_WIDTH - 120)/2);
    }];
    
    _qq.hidden = ![TencentOAuth iphoneQQInstalled];
    _wechat.hidden = ![WXApi isWXAppInstalled];
    tip.hidden = ![WXApi isWXAppInstalled];
    
    self.account.text = @"17608034342";
    self.password.text = @"123456";
}

- (UIImageView *)headerImage{
    if (!_headerImage) {
        _headerImage = [[UIImageView alloc] init];
        _headerImage.contentMode = UIViewContentModeScaleAspectFit;
        _headerImage.image = [UIImage imageNamed:@"Logo"];
    }
    return _headerImage;
}

- (CHYTextField *)creatTextFieldWith:(NSString *)placeholder image:(UIImage *)image tag:(NSInteger)tag{
    CHYTextField *textField = [[CHYTextField alloc] init];
    textField.placeholder = placeholder;
    
    UIImageView *left = [[UIImageView alloc] initWithFrame:CGRectMake(0, 12.5, 38, 15)];
    left.contentMode = UIViewContentModeScaleAspectFit;
    left.image = image;
    textField.leftView = left;
    if (tag == 101) {
        textField.secureTextEntry = YES;
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
            if (![weakself.account.text authenicationIsPhone]) {
                return;
            }
            [weakself.countDown requestToServiceGetCodeWith:weakself.account.text codeType:1];
        };
    }
    return _countDown;
}

- (UIButton *)forgetPs{
    if (!_forgetPs) {
        _forgetPs = [[UIButton alloc] init];
        [_forgetPs setTitle:@"忘记密码?" forState:UIControlStateNormal];
        [_forgetPs setTitleColor:UIColorMake(51, 51, 51) forState:UIControlStateNormal];
        _forgetPs.titleLabel.font = [UIFont systemFontOfSize:15];
        [_forgetPs addTarget:self action:@selector(forgetpassword) forControlEvents:UIControlEventTouchUpInside];
    }
    return _forgetPs;
}

- (UIButton *)login{
    if (!_login) {
        _login = [[UIButton alloc] init];
        _login.layer.cornerRadius = 5;
        _login.backgroundColor = UIColorMake(255, 80, 0);
        [_login setTitle:@"登录" forState:UIControlStateNormal];
        [_login setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _login.titleLabel.font = [UIFont systemFontOfSize:18];
        [_login addTarget:self action:@selector(loginButonPressed) forControlEvents:UIControlEventTouchUpInside];
    }
    return _login;
}

- (UIButton *)regist{
    if (!_regist) {
        _regist = [[UIButton alloc] init];
        [_regist setTitleColor:UIColorMake(255, 80, 0) forState:UIControlStateNormal];
        [_regist setTitle:@"注册新账号" forState:UIControlStateNormal];
        _regist.titleLabel.font = [UIFont systemFontOfSize:15];
        [_regist addTarget:self action:@selector(reistButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    }
    return _regist;
}

- (UIButton *)wechat{
    if (!_wechat) {
        _wechat = [[UIButton alloc] init];
        [_wechat setImage:[UIImage imageNamed:@"微信"] forState:UIControlStateNormal];
        _wechat.imageView.contentMode = UIViewContentModeScaleAspectFit;
        _wechat.tag = 900;
        [_wechat addTarget:self action:@selector(invitePhone:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _wechat;
}

- (UIButton *)qq{
    if (!_qq) {
        _qq = [[UIButton alloc] init];
        [_qq setImage:[UIImage imageNamed:@"QQ"] forState:UIControlStateNormal];
        _qq.imageView.contentMode = UIViewContentModeScaleAspectFit;
        _qq.tag = 901;
        [_qq addTarget:self action:@selector(invitePhone:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _qq;
}

- (void)reistButtonPressed{
    [self.navigationController pushViewController:[[RegisViewController alloc]init] animated:YES];
}

- (void)forgetpassword{
    [self.navigationController pushViewController:[[ForgetViewController alloc]init] animated:YES];
}

- (void)invitePhone:(UIButton *)sender{
    if (sender.tag == 901) {
        [[QQTool shareQQTool] loginWithQQ];
    }
    else if(sender.tag == 900){
        [WeChatTool loginWeChat];
    }
}

- (void)loginButonPressed{
    HIDDENKEYBORD;
    if (![_account.text authenicationIsPhone]) {
        return;
    }
    if (![_password.text authenicationPassword]) {
        return;
    }
    [self userLogin:@{@"phone":_account.text,@"password":[_password.text md5Digest],@"loginType":@"1"} success:^(id  _Nonnull result) {
        [self loginSuccesWith:result];
    } failed:^(NSString * _Nonnull reson) {
        [QMUITips showError:reson inView:KINGWIDWOWN hideAfterDelay:1.0];
    }];
}
    
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:WX_NOTICE_NAME object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:WB_NOTICE_NAME object:nil];
}
    
    //微信授权成功
- (void)userLoginSuccessWithWechat:(NSNotification *)center{
    __block NSMutableDictionary *temp = [center.userInfo objectForKey:@"returnData"];
    [self loginWithTherePlaceWith:@"wx" loginType:@"2" openId:temp[@"openid"] header:temp[@"headimgurl"] name:temp[@"nickname"] success:^(id  _Nonnull result) {
        [self loginSuccesWith:result];
    } failed:^(NSString * _Nonnull reson) {
        if ([reson isEqualToString:@"账号不存在"]) {
            RegisViewController *regist = [[RegisViewController alloc]init];
            NSMutableDictionary *input = [NSMutableDictionary dictionary];
            [input setValue:@"wx" forKey:@"openType"];
            [input setValue:@"2" forKey:@"loginType"];
            [input setValue:temp[@"openid"] forKey:@"openId"];
            [input setValue:temp[@"headimgurl"] forKey:@"head"];
            [input setValue:temp[@"nickname"] forKey:@"name"];
            regist.otherLogin = input;
            [self.navigationController pushViewController:regist animated:YES];
        }
        else{
            [QMUITips showError:reson inView:KINGWIDWOWN hideAfterDelay:1.0];
        }
        
    }];
}
    //微博授权成功
- (void)userLoginSuccessWithQQ:(NSNotification *)nitifi{
    NSMutableDictionary *temp = [nitifi.userInfo objectForKey:@"returnData"];
    [self loginWithTherePlaceWith:@"qq" loginType:@"2" openId:temp[@"openId"] header:temp[@"figureurl_2"] name:temp[@"nickname"] success:^(id  _Nonnull result) {
        [self loginSuccesWith:result];
    } failed:^(NSString * _Nonnull reson) {
        if ([reson isEqualToString:@"账号不存在"]) {
            RegisViewController *regist = [[RegisViewController alloc]init];
            NSMutableDictionary *input = [NSMutableDictionary dictionary];
            [input setValue:@"qq" forKey:@"openType"];
            [input setValue:@"2" forKey:@"loginType"];
            [input setValue:temp[@"openId"] forKey:@"openId"];
            [input setValue:temp[@"figureurl_2"] forKey:@"head"];
            [input setValue:temp[@"nickname"] forKey:@"name"];
            regist.otherLogin = input;
            [self.navigationController pushViewController:regist animated:YES];
        }
        else{
            [QMUITips showError:reson inView:KINGWIDWOWN hideAfterDelay:1.0];
        }
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
