//
//  SuccessViewController.m
//  HJZSS
//
//  Created by apple on 2019/3/4.
//  Copyright © 2019 apple. All rights reserved.
//

#import "SuccessViewController.h"

@interface SuccessViewController ()

@property (strong,nonatomic) UIImageView *tipImage;
@property (strong,nonatomic) UILabel *statusLabel;
@property (strong,nonatomic) UILabel *psTip;
@property (strong,nonatomic) UIButton *sureBtn;

@end

@implementation SuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)reloadUI{
    self.statusLabel = [LabelCreat creatLabelWith:@"" font:[UIFont boldSystemFontOfSize:18] color:UIColorMake(0, 0, 0) textAlignment:NSTextAlignmentCenter];
    self.psTip = [LabelCreat creatLabelWith:@"提现审核将在73小时内完成，请耐心等候" font:[UIFont systemFontOfSize:12] color:UIColorMake(137, 137, 137) textAlignment:NSTextAlignmentCenter];
    [self.view addSubview:self.tipImage];
    [self.view addSubview:self.statusLabel];
    [self.view addSubview:self.psTip];
    [self.view addSubview:self.sureBtn];
    
    [_tipImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(NavigationContentTopConstant + 110);
        make.left.right.equalTo(self.view).offset(0);
        make.height.offset(115);
    }];
    
    [_statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tipImage.mas_bottom).offset(18);
        make.left.right.equalTo(self.view).offset(0);
    }];
    
    [_psTip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.statusLabel.mas_bottom).offset(36);
        make.left.right.equalTo(self.view).offset(0);
    }];
    
    [_sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.statusLabel.mas_bottom).offset(135);
        make.left.equalTo(self.view).offset(100);
        make.right.equalTo(self.view).offset(-100);
        make.height.offset(38);
    }];
}

- (void)setType:(SuccessType)type{
    _type = type;
    [self reloadUI];
    switch (_type) {
        case SuccessTypeTupUp:
        {
            self.titleLab.text = @"充值详情";
            self.psTip.hidden = YES;
            self.statusLabel.text = @"支付成功";
            [self.sureBtn setTitle:@"返回" forState:UIControlStateNormal];
        }
            break;
            
        case SuccessTypeWithdrawal:
        {
            self.titleLab.text = @"提现详情";
            self.psTip.hidden = NO;
            self.statusLabel.text = @"提现申请已提交";
            [self.sureBtn setTitle:@"返回钱包" forState:UIControlStateNormal];
        }
            break;
            
        default:
            break;
    }
}

- (UIImageView *)tipImage{
    if (!_tipImage) {
        _tipImage = [[UIImageView alloc] init];
        _tipImage.contentMode = UIViewContentModeScaleAspectFit;
        _tipImage.image = [UIImage imageNamed:@"成功"];
    }
    return _tipImage;
}

- (UIButton *)sureBtn{
    if (!_sureBtn) {
        _sureBtn = [[UIButton alloc] init];
        [_sureBtn setTitleColor:UIColorMake(122, 122, 122) forState:UIControlStateNormal];
        _sureBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        _sureBtn.layer.cornerRadius = 5;
        _sureBtn.layer.borderWidth = 1.0;
        _sureBtn.layer.borderColor = UIColorMake(122, 122, 122).CGColor;
        [_sureBtn addTarget:self action:@selector(surepayBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureBtn;
}

- (void)surepayBtnPressed:(UIButton *)sender{
    switch (_type) {
        case SuccessTypeTupUp:
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
            break;
            
        case SuccessTypeWithdrawal:
        {
            UIViewController *tmp = self.navigationController.viewControllers[1];
            [self.navigationController popToViewController:tmp animated:YES];
        }
            break;
            
        default:
            break;
    }
}

@end
