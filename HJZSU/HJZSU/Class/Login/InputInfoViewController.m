//
//  InputInfoViewController.m
//  HJZSS
//
//  Created by apple on 2019/3/5.
//  Copyright © 2019 apple. All rights reserved.
//

#import "InputInfoViewController.h"

@interface InputInfoViewController ()

@property (strong,nonatomic) CHYTextField *name;
@property (strong,nonatomic) UIButton *year;
@property (strong,nonatomic) UIButton *goodFor;
@property (strong,nonatomic) UIButton *word;
@property (strong,nonatomic) UIButton *location;
@property (strong,nonatomic) UIButton *sure;

@end

@implementation InputInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleLab.text = @"完善信息";
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel *tip = [LabelCreat creatLabelWith:@"欢迎来到呼叫战神！" font:[UIFont systemFontOfSize:24] color:UIColorMake(51, 51, 51) textAlignment:NSTextAlignmentCenter];
    UILabel *bootom = [LabelCreat creatLabelWith:@"请完善资料给您更好的服务" font:[UIFont systemFontOfSize:15] color:UIColorMake(255, 80, 0) textAlignment:NSTextAlignmentCenter];
    self.year = [self creatButtonWith:@"从业年限" value:@"一年" and:100];
    self.goodFor = [self creatButtonWith:@"擅长领域" value:@"商场促销 单点爆破" and:101];
    self.word = [self creatButtonWith:@"格言" value:@"文字描述xxxx" and:102];
    self.location = [self creatButtonWith:@"地址" value:@"四川省 成都市" and:103];
    
    [self.view addSubview:tip];
    [self.view addSubview:bootom];
    [self.view addSubview:self.name];
    [self.view addSubview:self.year];
    [self.view addSubview:self.goodFor];
    [self.view addSubview:self.word];
    [self.view addSubview:self.location];
    [self.view addSubview:self.sure];
    
    [tip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(NavigationContentTopConstant + 31);
        make.left.equalTo(self.view).offset(25);
        make.right.equalTo(self.view).offset(-25);
    }];
    
    [bootom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tip.mas_bottom).offset(15);
        make.left.equalTo(self.view).offset(25);
        make.right.equalTo(self.view).offset(-25);
    }];
    
    [_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bootom.mas_bottom).offset(15);
        make.left.equalTo(self.view).offset(25);
        make.right.equalTo(self.view).offset(-25);
        make.height.offset(50);
    }];
    
    [_year mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.name.mas_bottom).offset(0);
        make.left.equalTo(self.view).offset(25);
        make.right.equalTo(self.view).offset(-25);
        make.height.offset(50);
    }];
    
    [_goodFor mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.year.mas_bottom).offset(0);
        make.left.equalTo(self.view).offset(25);
        make.right.equalTo(self.view).offset(-25);
        make.height.offset(50);
    }];
    
    [_word mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.goodFor.mas_bottom).offset(0);
        make.left.equalTo(self.view).offset(25);
        make.right.equalTo(self.view).offset(-25);
        make.height.offset(50);
    }];
    
    [_location mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.word.mas_bottom).offset(0);
        make.left.equalTo(self.view).offset(25);
        make.right.equalTo(self.view).offset(-25);
        make.height.offset(50);
    }];
    
    [_sure mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-SafeAreaInsetsConstantForDeviceWithNotch.bottom - 40);
        make.left.equalTo(self.view).offset(25);
        make.right.equalTo(self.view).offset(-25);
        make.height.offset(50);
    }];
}

- (CHYTextField *)name{
    if (!_name) {
        _name = [[CHYTextField alloc] init];
        _name.placeholder = @"请输入团队名称";
        _name.font = [UIFont systemFontOfSize:15];
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = UIColorMake(239, 239, 239);
        [_name addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.left.right.equalTo(self.name).offset(0);
            make.height.offset(1);
        }];
    }
    return _name;
}

- (UIButton *)creatButtonWith:(NSString *)title value:(NSString *)value and:(NSInteger)tag{
    UIButton *button = [[UIButton alloc] init];
    button.tag = tag;
    
    UILabel *titleLab = [LabelCreat creatLabelWith:title font:[UIFont systemFontOfSize:15] color:UIColorMake(34, 34, 34) textAlignment:NSTextAlignmentLeft];
    UILabel *valueLab = [LabelCreat creatLabelWith:title font:[UIFont systemFontOfSize:15] color:UIColorMake(139, 139, 139) textAlignment:NSTextAlignmentLeft];
    valueLab.tag = 200;
    
    UIImageView *next = [[UIImageView alloc] init];
    next.contentMode = UIViewContentModeScaleAspectFit;
    next.image = [UIImage imageNamed:@"箭头-向右"];
    
    [button addSubview:titleLab];
    [button addSubview:next];
    [button addSubview:valueLab];
    
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.equalTo(button).offset(0);
    }];
    
    [next mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.top.right.equalTo(button).offset(0);
        make.width.offset(7.5);
    }];
    
    [valueLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(button).offset(0);
        make.right.equalTo(next.mas_left).offset(-10);
    }];
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = UIColorMake(239, 239, 239);
    [button addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(button).offset(0);
        make.height.offset(1);
    }];
    
    return button;
}

- (UIButton *)sure{
    if (!_sure) {
        _sure = [[UIButton alloc] init];
        _sure.layer.cornerRadius = 5;
        _sure.backgroundColor = UIColorMake(255, 80, 0);
        [_sure setTitle:@"确定" forState:UIControlStateNormal];
        [_sure setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _sure.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    }
    return _sure;
}



@end
