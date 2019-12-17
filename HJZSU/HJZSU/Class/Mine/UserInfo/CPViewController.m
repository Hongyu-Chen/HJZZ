//
//  CPViewController.m
//  HJZSS
//
//  Created by apple on 2019/3/1.
//  Copyright © 2019 apple. All rights reserved.
//

#import "CPViewController.h"

@interface CPViewController ()

@property (strong,nonatomic) CHYTextField *phone;
@property (strong,nonatomic) CHYTextField *password;
@property (strong,nonatomic) TheCountdown *countDown;
@property (strong,nonatomic) UIButton *sure;

@end

@implementation CPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleLab.text = @"修改手机号";
    self.phone = [self creatWith:@"手机号" placeholder:@"请输入新手机号" tag:0];
    self.password = [self creatWith:@"验证码" placeholder:@"请输入验证码" tag:1];
    
    [self.view addSubview:_phone];
    [self.view addSubview:_password];
    [self.view addSubview:self.sure];
    
    [_phone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(NavigationContentTopConstant + 13);
        make.left.right.equalTo(self.view).offset(0);
        make.height.offset(50);
    }];
    [_password mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.phone.mas_bottom).offset(0);
        make.left.right.equalTo(self.view).offset(0);
        make.height.offset(50);
    }];
    
    [_sure mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.password.mas_bottom).offset(75);
        make.left.equalTo(self.view).offset(10);
        make.right.equalTo(self.view).offset(-10);
        make.height.offset(50);
    }];
}

- (CHYTextField *)creatWith:(NSString *)tipStr placeholder:(NSString *)placeholder tag:(NSInteger)tag{
    CHYTextField *textFiled = [[CHYTextField alloc] init];
    textFiled.backgroundColor = [UIColor whiteColor];
    textFiled.placeholder = placeholder;
    
    UILabel *label = [LabelCreat creatLabelWith:tipStr font:[UIFont boldSystemFontOfSize:15] color:UIColorMake(51, 51, 51) textAlignment:NSTextAlignmentCenter];
    label.frame = CGRectMake(0, 0, 80, 50);
    textFiled.leftView = label;
    textFiled.leftViewMode = UITextFieldViewModeAlways;
    if (tag == 0) {
        textFiled.rightView = self.countDown;
        textFiled.rightViewMode = UITextFieldViewModeAlways;
    }
    
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
        [_sure setTitle:@"确定" forState:UIControlStateNormal];
        _sure.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        [_sure setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _sure.backgroundColor = UIColorMake(255, 80, 0);
        _sure.layer.cornerRadius = 5;
        [_sure addTarget:self action:@selector(sureCPButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sure;
}

- (void)sureCPButtonPressed{
    if (![self.phone.text authenicationIsPhone]) {
        return;
    }
    if (![self.password.text authenicationMessageCode]) {
        return;
    }
    [self changedPhone:_phone.text code:_password.text success:^(id  _Nonnull result) {
        [QMUITips showSucceed:@"手机更改成功"];
    } failed:^(NSString * _Nonnull reson) {
        [QMUITips showError:reson];
    }];
}

@end
