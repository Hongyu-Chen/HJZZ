//
//  WithdrawalViewController.m
//  HJZSS
//
//  Created by apple on 2019/3/4.
//  Copyright © 2019 apple. All rights reserved.
//

#import "WithdrawalViewController.h"
#import "ALipayViewController.h"
#import "SuccessViewController.h"

@interface WithdrawalViewController ()

@property (strong,nonatomic) UIView *topBg;
@property (strong,nonatomic) UILabel *moneny;
@property (strong,nonatomic) UILabel *tip;
@property (strong,nonatomic) UITextField *input;
@property (strong,nonatomic) UILabel *bottomTip;
@property (strong,nonatomic) UIButton *wechat;
@property (strong,nonatomic) UIButton *alipay;
@property (strong,nonatomic) UIButton *nextBtn;

@end

@implementation WithdrawalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleLab.text = @"提现";
    
    self.wechat = [self payButtonWith:[UIImage imageNamed:@"微信支付-提现"] andTitle:@"微信" and:100];
    self.alipay = [self payButtonWith:[UIImage imageNamed:@"支付宝-提现"] andTitle:@"支付宝" and:101];
    UILabel *psTip = [LabelCreat creatLabelWith:@"备注说明：每周二提现" font:[UIFont systemFontOfSize:15] color:UIColorMake(51, 51, 51) textAlignment:NSTextAlignmentLeft];
    [self.view addSubview:self.topBg];
    [self.view addSubview:self.input];
    [self.view addSubview:self.bottomTip];
    [self.view addSubview:self.wechat];
    [self.view addSubview:self.alipay];
    [self.view addSubview:psTip];
    [self.view addSubview:self.nextBtn];
    
    [_input mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topBg.mas_bottom).offset(13);
        make.left.equalTo(self.view).offset(13);
        make.right.equalTo(self.view).offset(-13);
        make.height.offset(50);
    }];
    
    [_bottomTip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.input.mas_bottom).offset(13);
        make.left.equalTo(self.view).offset(13);
        make.right.equalTo(self.view).offset(-13);
        make.height.offset(50);
    }];
    
    [_wechat mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bottomTip.mas_bottom).offset(1);
        make.left.equalTo(self.view).offset(13);
        make.right.equalTo(self.view).offset(-13);
        make.height.offset(50);
    }];
    
    [_alipay mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.wechat.mas_bottom).offset(0);
        make.left.equalTo(self.view).offset(13);
        make.right.equalTo(self.view).offset(-13);
        make.height.offset(50);
    }];
    
    [psTip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.alipay.mas_bottom).offset(13);
        make.left.equalTo(self.view).offset(26);
        make.right.equalTo(self.view).offset(-26);
    }];
    

    [_nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(psTip.mas_bottom).offset(100);
        make.left.equalTo(self.view).offset(40);
        make.right.equalTo(self.view).offset(-40);
        make.height.offset(50);
    }];
    
    [self withButtonPressed:self.wechat];
    
    self.moneny.text = [NSString stringWithFormat:@"%.2f元",self.model.money/100];
    
}

- (UIView *)topBg{
    if (!_topBg) {
        _topBg = [[UIView alloc] initWithFrame:CGRectMake(0, NavigationContentTopConstant, SCREEN_WIDTH, 100)];
        _topBg.backgroundColor = UIColorMake(255, 80, 0);
        self.moneny = [LabelCreat creatLabelWith:@"0.00元" font:[UIFont boldSystemFontOfSize:24] color:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter];
        self.tip = [LabelCreat creatLabelWith:@"可提现余额" font:[UIFont boldSystemFontOfSize:12] color:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter];
        
        [_topBg addSubview:self.moneny];
        [_topBg addSubview:self.tip];
        
        [_moneny mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.topBg).offset(20);
            make.left.right.equalTo(self.topBg).offset(0);
        }];
        
        [_tip mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.moneny.mas_bottom).offset(0);
            make.bottom.equalTo(self.topBg).offset(-20);
            make.left.right.equalTo(self.topBg).offset(0);
        }];
    }
    return _topBg;
}

-(UITextField *)input{
    if (!_input) {
        _input = [[UITextField alloc] init];
        UILabel *label = [LabelCreat creatLabelWith:@"       提现金额" font:[UIFont boldSystemFontOfSize:15] color:UIColorMake(51, 51, 51) textAlignment:NSTextAlignmentLeft];
        label.frame = CGRectMake(0, 0, SCREEN_WIDTH * 384.0/750.0, 50);
        _input.leftView = label;
        _input.leftViewMode = UITextFieldViewModeAlways;
        UILabel *tip = [LabelCreat creatLabelWith:@"元 " font:[UIFont boldSystemFontOfSize:15] color:UIColorMake(51, 51, 51) textAlignment:NSTextAlignmentLeft];
        tip.frame = CGRectMake(0, 0, 30, 50);
        _input.rightView = tip;
        _input.rightViewMode = UITextFieldViewModeAlways;
        _input.placeholder = @"请输入提现金额";
        _input.font = [UIFont boldSystemFontOfSize:15];
        _input.backgroundColor = [UIColor whiteColor];
        _input.layer.cornerRadius = 5.0;
        _input.keyboardType = UIKeyboardTypeNumberPad;
        _input.textAlignment = NSTextAlignmentRight;
    }
    return _input;
}

- (UILabel *)bottomTip{
    if (!_bottomTip) {
        _bottomTip = [LabelCreat creatLabelWith:@"       提现方式" font:[UIFont boldSystemFontOfSize:15] color:UIColorMake(51, 51, 51) textAlignment:NSTextAlignmentLeft];
        _bottomTip.backgroundColor = [UIColor whiteColor];
    }
    return _bottomTip;
}

- (UIButton *)payButtonWith:(UIImage *)image andTitle:(NSString *)title and:(NSInteger)tag{
    UIButton *button = [[UIButton alloc] init];
    button.tag = tag;
    UIImageView *icon = [[UIImageView alloc] init];
    icon.contentMode = UIViewContentModeScaleAspectFit;
    icon.image = image;
    UILabel *tip = [LabelCreat creatLabelWith:title font:[UIFont boldSystemFontOfSize:15] color:UIColorMake(51, 51, 51) textAlignment:NSTextAlignmentLeft];
    
    [button addSubview:icon];
    [button addSubview:tip];
    
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(button).offset(0);
        make.left.equalTo(button).offset(13);
        make.width.offset(20);
    }];
    
    [tip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.top.equalTo(button).offset(0);
        make.left.equalTo(icon.mas_right).offset(13);
    }];
    
    UIImageView *selectedImage = [[UIImageView alloc] init];
    selectedImage.contentMode = UIViewContentModeScaleAspectFit;
    selectedImage.tag = 200;
    selectedImage.image = [UIImage imageNamed:@"勾选-未选中"];
    [button addSubview:selectedImage];
    [selectedImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(button).offset(0);
        make.right.equalTo(button).offset(-13);
        make.width.offset(20);
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
    button.backgroundColor = [UIColor whiteColor];
    [button addTarget:self action:@selector(withButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

- (UIButton *)nextBtn{
    if (!_nextBtn) {
        _nextBtn = [[UIButton alloc] init];
        [_nextBtn setTitle:@"提现" forState:UIControlStateNormal];
        [_nextBtn setTitle:@"下一步" forState:UIControlStateSelected];
        _nextBtn.titleLabel.font = [UIFont systemFontOfSize:18];
        [_nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _nextBtn.layer.cornerRadius = 5;
        _nextBtn.backgroundColor = UIColorMake(255, 80, 0);
        [_nextBtn addTarget:self action:@selector(bottomBottonPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextBtn;
}


- (void)withButtonPressed:(UIButton *)sender{
    sender.selected = !sender.selected;
    UIImageView *tmp1 = [self.wechat viewWithTag:200];
    UIImageView *temp2 = [self.alipay viewWithTag:200];
    if (sender.tag == 100) {
        if (sender.selected) {
            tmp1.image = [UIImage imageNamed:@"勾选"];
            temp2.image = [UIImage imageNamed:@"勾选-未选中"];
            self.alipay.selected = NO;
            self.nextBtn.selected = NO;
        }
    }
    else{
        if (sender.selected) {
            tmp1.image = [UIImage imageNamed:@"勾选-未选中"];
            temp2.image = [UIImage imageNamed:@"勾选"];
            self.wechat.selected = NO;
            self.nextBtn.selected = YES;
        }
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userLoginSuccessWithWechat:) name:WX_NOTICE_NAME object:nil];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:WX_NOTICE_NAME object:nil];
}

- (void)bottomBottonPressed:(UIButton *)sender{
    
    if ([_input.text floatValue] > self.model.money) {
        [QMUITips showError:@"超出可提现金额"];
        return;
    }
    
    if ([_input.text floatValue] == 0) {
        [QMUITips showError:@"请输入提现金额"];
        return;
    }
    
    NSDictionary *isLogin = [[YYCacheManager shareYYCacheManager] userINfo];
    if (isLogin) {
        if (IsNullString(isLogin[@"openid_wx"])) {
            [WeChatTool loginWeChat];
            return;
        }
    }
    
    NSMutableDictionary *input = [[NSMutableDictionary alloc] init];
    [input setObject:_wechat.selected ? @"1" : @"2" forKey:@"type"];
    [input setObject:[NSString stringWithFormat:@"%.0f",[_input.text floatValue] * 100] forKey:@"money"];
    [input setObject:@"" forKey:@"account"];
    [input setObject:@"" forKey:@"name"];
    [input setObject:@"" forKey:@"code"];
    
    if (sender.selected) {
        ALipayViewController *viewController = [[ALipayViewController alloc] init];
        viewController.input = input;
        [self.navigationController pushViewController:viewController animated:YES];
    }
    else{
        __weak typeof(self) weakself = self;
        [self withdrawalWith:input success:^(id  _Nonnull result) {
            SuccessViewController *success = [[SuccessViewController alloc] init];
            success.type = SuccessTypeWithdrawal;
            [weakself.navigationController pushViewController:success animated:YES];
        } failed:^(NSString * _Nonnull reson) {
            [QMUITips showError:reson];
        }];
    }
}

- (void)userLoginSuccessWithWechat:(NSNotification *)center{
    __block NSMutableDictionary *temp = [center.userInfo objectForKey:@"returnData"];
    [self bindWxWith:temp[@"openid"] success:^(id  _Nonnull result) {
        NSMutableDictionary *isLogin = [[NSMutableDictionary alloc] initWithDictionary:[[YYCacheManager shareYYCacheManager] userINfo]];
        [isLogin setObject:temp[@"openid"] forKey:@"openid_wx"];
        [[YYCacheManager shareYYCacheManager] uploadUserInfoWith:isLogin];
        [QMUITips showWithText:@"微信绑定成功"];
    } failed:^(NSString * _Nonnull reson) {
        [QMUITips showWithText:reson];
    }];
}

@end
