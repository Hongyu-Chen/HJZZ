//
//  AddBankViewController.m
//  HJZSU
//
//  Created by apple on 2019/3/15.
//  Copyright © 2019 apple. All rights reserved.
//

#import "AddBankViewController.h"

@interface AddBankViewController ()

@property (strong,nonatomic) CHYTextField *name;
@property (strong,nonatomic) CHYTextField *careNumber;
@property (strong,nonatomic) CHYTextField *year;
@property (strong,nonatomic) CHYTextField *code;
@property (strong,nonatomic) UIButton *sure;

@end

@implementation AddBankViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleLab.text = @"添加银行卡";
    self.name = [self creatTitle:@"持卡人姓名" tag:100];
    self.careNumber = [self creatTitle:@"卡号" tag:101];
    self.year = [self creatTitle:@"期限" tag:102];
    self.code = [self creatTitle:@"验证码" tag:103];
    
    [self.view addSubview:self.name];
    [self.view addSubview:self.careNumber];
    [self.view addSubview:self.year];
    [self.view addSubview:self.code];
    [self.view addSubview:self.sure];
    
    [_sure mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-SafeAreaInsetsConstantForDeviceWithNotch.bottom - 40);
        make.left.equalTo(self.view).offset(13);
        make.right.equalTo(self.view).offset(-13);
        make.height.offset(50);
    }];
    
    
}

- (CHYTextField *)creatTitle:(NSString *)title tag:(NSInteger)tag{
    CHYTextField *textField = [[CHYTextField alloc] initWithFrame:CGRectMake(13, NavigationContentTopConstant + 13 + (63 * (tag - 100)), SCREEN_WIDTH - 26, 50)];
    textField.font = [UIFont systemFontOfSize:15];
    textField.textColor = UIColorMake(137, 137, 137);
    textField.placeholderColor = UIColorMake(137, 137, 137);
    textField.backgroundColor = [UIColor whiteColor];
    textField.placeholder = @[@"持卡人姓名",@"XXXX XXXX XXXX XXXX",@"MM/YY",@"CVC"][tag - 100];
    textField.layer.cornerRadius = 5;
    UIView *text = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 93, 50)];
    UILabel *tip = [LabelCreat creatLabelWith:title font:[UIFont boldSystemFontOfSize:14] color:UIColorMake(34, 34, 34) textAlignment:NSTextAlignmentLeft];
    tip.frame = CGRectMake(13, 0, 93, 50);
    [text addSubview:tip];
    textField.leftView = text;
    textField.leftViewMode = UITextFieldViewModeAlways;
    return textField;
}

- (UIButton *)sure{
    if (!_sure) {
        _sure = [[UIButton alloc] init];
        [_sure setTitle:@"确定" forState:UIControlStateNormal];
        [_sure setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _sure.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        _sure.layer.cornerRadius = 5;
        _sure.backgroundColor = UIColorMake(255, 80, 0);
    }
    return _sure;
}

@end
