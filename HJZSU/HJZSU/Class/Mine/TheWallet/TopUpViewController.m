//
//  TopUpViewController.m
//  HJZSS
//
//  Created by apple on 2019/3/4.
//  Copyright © 2019 apple. All rights reserved.
//

#import "TopUpViewController.h"
#import "PayTypeView.h"
#import "SuccessViewController.h"

@interface TopUpViewController ()
@property (strong,nonatomic) UITextField *input;
@property (strong,nonatomic) UIButton *sure;

@end

@implementation TopUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleLab.text = @"充值";
    [self.view addSubview:self.input];
    [self.view addSubview:self.sure];
    
    [_input mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(NavigationContentTopConstant + 13);
        make.left.equalTo(self.view).offset(13);
        make.right.equalTo(self.view).offset(-13);
        make.height.offset(50);
    }];
    
    [_sure mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.input.mas_bottom).offset(50);
        make.left.equalTo(self.view).offset(13);
        make.right.equalTo(self.view).offset(-13);
        make.height.offset(50);
    }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userPaySuccessWithWechat:) name:WX_PAY_STATE object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userPaySuccessWithAL:) name:AL_IPAY_STATE object:nil];
}

-(UITextField *)input{
    if (!_input) {
        _input = [[UITextField alloc] init];
        UILabel *label = [LabelCreat creatLabelWith:@"       金额" font:[UIFont boldSystemFontOfSize:15] color:UIColorMake(51, 51, 51) textAlignment:NSTextAlignmentLeft];
        label.frame = CGRectMake(0, 0, SCREEN_WIDTH * 384.0/750.0, 50);
        _input.leftView = label;
        _input.leftViewMode = UITextFieldViewModeAlways;
        UILabel *tip = [LabelCreat creatLabelWith:@"元 " font:[UIFont boldSystemFontOfSize:15] color:UIColorMake(51, 51, 51) textAlignment:NSTextAlignmentLeft];
        tip.frame = CGRectMake(0, 0, 30, 50);
        _input.rightView = tip;
        _input.rightViewMode = UITextFieldViewModeAlways;
        _input.placeholder = @"请输入充值金额";
        _input.font = [UIFont boldSystemFontOfSize:15];
        _input.backgroundColor = [UIColor whiteColor];
        _input.layer.cornerRadius = 5.0;
        _input.keyboardType = UIKeyboardTypeNumberPad;
    }
    return _input;
}

- (UIButton *)sure{
    if (!_sure) {
        _sure = [[UIButton alloc] init];
        [_sure setTitle:@"充值" forState:UIControlStateNormal];
        _sure.titleLabel.font = [UIFont systemFontOfSize:15];
        [_sure setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _sure.layer.cornerRadius = 5;
        _sure.backgroundColor = UIColorMake(255, 80, 0);
        [_sure addTarget:self action:@selector(bottomTopupBottonPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sure;
}

- (void)bottomTopupBottonPressed:(UIButton *)sender{
    [_input resignFirstResponder];
    if (![_input.text integerValue]) {
        [QMUITips showError:@"请输入金额"];
        return;
    }
    OrderModelInfo *model = [[OrderModelInfo alloc] init];
    model.money = [_input.text floatValue] * 100;
    __weak typeof(self)weakself = self;
    [PayTypeView showTopUPView:@"PayTypeView" info:model userBlock:^(NSInteger index, id  _Nonnull value) {
        if (index == 1) {
            if ([value integerValue] == 1) {
                [weakself topupMoneny:[NSString stringWithFormat:@"%.0f",[weakself.input.text floatValue] * 100] type:@"1" success:^(id  _Nonnull result) {
                    [WeChatTool wxPayWithOrderData:result];
                } failed:^(NSString * _Nonnull reson) {
                    [QMUITips showError:reson];
                }];
            }
            else if ([value integerValue] == 2){
                [weakself topupMoneny:[NSString stringWithFormat:@"%.0f",[weakself.input.text floatValue] * 100] type:@"2" success:^(id  _Nonnull result) {
                    [[PayManager sharePayManager] handleOrderPayWithParams:@{@"payInfo":result}];
                } failed:^(NSString * _Nonnull reson) {
                    [QMUITips showError:reson];
                }];
            }
        }
    }];
}

- (void)userPaySuccessWithWechat:(NSNotification *)center{
    SuccessViewController *success = [[SuccessViewController alloc] init];
    success.type = SuccessTypeTupUp;
    [self.navigationController pushViewController:success animated:YES];
}

- (void)userPaySuccessWithAL:(NSNotification *)center{
    SuccessViewController *success = [[SuccessViewController alloc] init];
    success.type = SuccessTypeTupUp;
    [self.navigationController pushViewController:success animated:YES];
}

@end
