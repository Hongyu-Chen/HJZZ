//
//  PayTypeView.m
//  HJZSU
//
//  Created by apple on 2019/3/14.
//  Copyright © 2019 apple. All rights reserved.
//

#import "PayTypeView.h"

@interface PayTypeView ()

@property (strong,nonatomic) FormatLabel *money;
@property (strong,nonatomic) UIButton *chooseCard;
@property (strong,nonatomic) UILabel *mymoney;
@property (strong,nonatomic) UIButton *payButton;
@property (strong,nonatomic) UIButton *colseBtn;
@property (strong,nonatomic) UIButton *moneyPay;
@property (strong,nonatomic) UIButton *wechatPay;
@property (strong,nonatomic) UIButton *carePay;
@property (strong,nonatomic) UILabel *chooseType;


@end

@implementation PayTypeView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.type = BasePopupMenuAnimationTypeNormal;
        self.contentView.frame = CGRectMake(0, self.frame.size.height, self.frame.size.width, 390 + SafeAreaInsetsConstantForDeviceWithNotch.bottom);
//        self.userInteractionEnabled = NO;
        
        UILabel *title = [LabelCreat creatLabelWith:@"支付" font:[UIFont boldSystemFontOfSize:23] color:UIColorMake(34, 34, 34) textAlignment:NSTextAlignmentCenter];
        title.frame = CGRectMake(0, 0, self.frame.size.width, 50);
        
        self.chooseType = [LabelCreat creatLabelWith:@"已选择优惠券" font:[UIFont systemFontOfSize:12] color:UIColorMake(255, 80, 0) textAlignment:NSTextAlignmentLeft];
        self.chooseType.hidden = YES;
        
        [self.contentView addSubview:title];
        [self.contentView addSubview:self.colseBtn];
        [self.contentView addSubview:self.money];
        [self.contentView addSubview:self.chooseCard];
        _chooseCard.clipsToBounds = YES;
        [_chooseCard mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.money.mas_bottom).offset(0);
            make.left.right.equalTo(self).offset(0);
            make.height.offset(0);
        }];
        
        
        for (int i = 0; i < 3; i++) {
            UIView *view = [[UIView alloc] init];
            view.clipsToBounds = YES;
            view.tag = 900 + i;
            UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(13, 0, 20, 50)];
            icon.contentMode = UIViewContentModeScaleAspectFit;
            icon.image = [UIImage imageNamed:@[@"钱包-支付",@"微信支付",@"支付宝支付"][i]];
            [view addSubview:icon];
            UILabel *tip = [LabelCreat creatLabelWith:@[@"钱包支付",@"微信支付",@"支付宝支付"][i] font:[UIFont systemFontOfSize:12] color:UIColorMake(34, 34, 34) textAlignment:NSTextAlignmentLeft];
            tip.frame = CGRectMake(43, 0, 100, 50);
            [view addSubview:tip];
            if (i == 0) {
                self.mymoney = [LabelCreat creatLabelWith:@"余额：" font:[UIFont systemFontOfSize:12] color:UIColorMake(137, 137, 137) textAlignment:NSTextAlignmentCenter];
                self.mymoney.frame = CGRectMake(0, 0, self.frame.size.width, 50);
                [view addSubview:self.mymoney];
                [view addSubview:self.moneyPay];
            }
            else if ( i == 1){
                [view addSubview:self.wechatPay];
            }
            else{
                [view addSubview:self.carePay];
            }
            [self.contentView addSubview:view];
            
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.chooseCard.mas_bottom).offset(i * 50);
                make.left.right.equalTo(self.contentView).offset(0);
                make.height.offset(50);
            }];
        }
        [self.contentView addSubview:self.payButton];
        
        [_payButton mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.contentView).offset(-SafeAreaInsetsConstantForDeviceWithNotch.bottom);
            make.left.equalTo(self.contentView).offset(40);
            make.right.equalTo(self.contentView).offset(-40);
            make.height.offset(40);
        }];
        
        [self showChooseButton:NO];
        
        [self resonButtonPressed:self.carePay];
    }
    return self;
}

- (FormatLabel *)money{
    if (!_money) {
        _money = [[FormatLabel alloc] initWithFrame:CGRectMake(0, 50, self.frame.size.width, 120)];
        _money.backgroundColor = UIColorMake(239, 239, 239);
        _money.textAlignment = NSTextAlignmentCenter;
        _money.font = [UIFont systemFontOfSize:15];
        _money.textColor = UIColorMake(34, 34, 34);
        _money.text = @"50,000元";
        [_money setHeightLightWords:@[@"50,000"] heightLightColors:nil htightLightFont:@[[UIFont boldSystemFontOfSize:23]]];
    }
    return _money;
}

- (UIButton *)payButton{
    if (!_payButton) {
        _payButton = [[UIButton alloc] initWithFrame:CGRectMake(40, 340, self.frame.size.width - 80, 40)];
        [_payButton setTitle:@"确认支付" forState:UIControlStateNormal];
        [_payButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _payButton.titleLabel.font = [UIFont systemFontOfSize:15];
        _payButton.backgroundColor = UIColorMake(255, 80, 0);
        _payButton.layer.cornerRadius = 5;
        _payButton.tag = 101;
        [_payButton addTarget:self action:@selector(typeViewButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _payButton;
}

- (UIButton *)moneyPay{
    if (!_moneyPay) {
        _moneyPay = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width - 60, 0, 40, 40)];
        [_moneyPay setImage:[UIImage imageNamed:@"勾选-未选中"] forState:UIControlStateNormal];
        [_moneyPay setImage:[UIImage imageNamed:@"勾选"] forState:UIControlStateSelected];
        _moneyPay.contentMode = UIViewContentModeScaleAspectFit;
        _moneyPay.tag = 200;
        [_moneyPay addTarget:self action:@selector(resonButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _moneyPay;
}

- (UIButton *)wechatPay{
    if (!_wechatPay) {
        _wechatPay = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width - 60, 0, 40, 40)];
        [_wechatPay setImage:[UIImage imageNamed:@"勾选-未选中"] forState:UIControlStateNormal];
        [_wechatPay setImage:[UIImage imageNamed:@"勾选"] forState:UIControlStateSelected];
        _wechatPay.contentMode = UIViewContentModeScaleAspectFit;
        _wechatPay.tag = 201;
        [_wechatPay addTarget:self action:@selector(resonButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _wechatPay;
}

- (UIButton *)carePay{
    if (!_carePay) {
        _carePay = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width - 60, 0, 40, 40)];
        [_carePay setImage:[UIImage imageNamed:@"勾选-未选中"] forState:UIControlStateNormal];
        [_carePay setImage:[UIImage imageNamed:@"勾选"] forState:UIControlStateSelected];
        _carePay.contentMode = UIViewContentModeScaleAspectFit;
        _carePay.tag = 202;
        [_carePay addTarget:self action:@selector(resonButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _carePay;
}

- (UIButton *)colseBtn{
    if (!_colseBtn) {
        _colseBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width - 60, 0, 40, 50)];
        [_colseBtn setImage:[UIImage imageNamed:@"关闭弹框"] forState:UIControlStateNormal];
        _colseBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
        _colseBtn.tag = 100;
        [_colseBtn addTarget:self action:@selector(typeViewButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _colseBtn;
}

- (void)typeViewButtonPressed:(UIButton *)sender{
    if (self.moneyPay.selected || self.wechatPay.selected || self.carePay) {
        if (self.viewButtonPressedBlock) {
            self.viewButtonPressedBlock(sender.tag - 100,self.moneyPay.selected ? @(0) : self.wechatPay.selected ? @(1) : @(2));
        }
    }
    else{
        [QMUITips showError:@"请选择支付方式"];
    }
}

- (UIButton *)chooseCard{
    if (!_chooseCard) {
        _chooseCard = [[UIButton alloc] init];
        _chooseCard.tag = 102;
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:12];
        label.textColor = UIColorMake(34, 34, 34);
        label.text = @"选择优惠券";
        [_chooseCard addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.chooseCard).offset(0);
            make.left.equalTo(self.chooseCard).offset(13);
        }];
        
        UIImageView *image = [[UIImageView alloc] init];
        image.contentMode = UIViewContentModeScaleAspectFit;
        image.image = [UIImage imageNamed:@"箭头-向右"];
        [_chooseCard addSubview:image];
        [image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.chooseCard).offset(-30);
            make.top.bottom.equalTo(self.chooseCard).offset(0);
            make.width.offset(7.5);
        }];
        
        [_chooseCard addSubview:self.chooseType];
        [_chooseType mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.chooseCard).offset(0);
            make.right.equalTo(image.mas_left).offset(-10);
        }];
        
        [_chooseCard addTarget:self action:@selector(typeViewButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _chooseCard;
}

- (void)resonButtonPressed:(UIButton *)sender{
    for (int i = 0; i < 3; i++) {
        UIButton *tmp = [self viewWithTag:200 + i];
        if (sender.tag == (i + 200)) {
            tmp.selected = YES;
        }
        else{
            tmp.selected = NO;
        }
    }
}



- (void)setModel:(OrderModelInfo *)model{
    _model = model;
    if (_model) {
        
        if (self.hiddenPage) {
            _money.text = [NSString stringWithFormat:@"%.2f元",_model.money/100];
            [_money setHeightLightWords:@[[NSString stringWithFormat:@"%.2f",_model.money/100]] heightLightColors:nil htightLightFont:@[[UIFont boldSystemFontOfSize:23]]];
            [_payButton setTitle:[NSString stringWithFormat:@"确认支付%.2f",_model.money/100] forState:UIControlStateNormal];
            return;
        }
        
        CGFloat pay = (_model.money - _model.weightsBuyMoney + _model.couponMoney) * (1 + [YYCacheManager shareYYCacheManager].saleFloat);
        pay += (_model.weightsBuyMoney -_model.couponMoney);
        pay = pay/100;
        
        _money.text = [NSString stringWithFormat:@"%.2f元",pay];
        [_money setHeightLightWords:@[[NSString stringWithFormat:@"%.2f元",pay]] heightLightColors:nil htightLightFont:@[[UIFont boldSystemFontOfSize:23]]];
        [_money setHeightLightWords:@[[NSString stringWithFormat:@"%.2f",pay]] heightLightColors:nil htightLightFont:@[[UIFont boldSystemFontOfSize:23]]];
        [_payButton setTitle:[NSString stringWithFormat:@"确认支付%.2f",pay] forState:UIControlStateNormal];
        
        __weak typeof(self) weakself = self;
        [self getUserInfoSuccess:^(id  _Nonnull result) {
            UserBaseModel *model = result;
            weakself.mymoney.text = [NSString stringWithFormat:@"余额：%.0f",model.money/100];
        } failed:^(NSString * _Nonnull reson) {
            [QMUITips showError:reson];
        }];
    }
}

+ (void)showView:(NSString *)className info:(OrderModelInfo *)info showView:(UIView *)view userBlock:(void(^)(NSInteger index,id value))userPressedBlock{
    
    id obj = [[NSClassFromString(className) alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    PayTypeView *View = (PayTypeView *)obj;
    View.model = info;
    View.tag = 10010;
    [View showChooseButton:YES];
//    if ([info.activityType integerValue] == 5) {
//        [View showChooseButton:YES];
//    }
//    else{
////        if (!IsNullString(info.weightsId)) {
////            [View showChooseButton:YES];
////        }
////        else{
////            [View showChooseButton:NO];
////        }
//        [View showChooseButton:YES];
//    }
    
    __weak typeof(View) weakself = View;
    View.viewButtonPressedBlock = ^(NSInteger index,id value) {
        if (index != 2) {
            [weakself hiddenView];
        }
        userPressedBlock(index,value);
    };
    [view addSubview:View];
    [View showView];
}

+ (void)showTopUPView:(NSString *)className info:(OrderModelInfo *)info userBlock:(void(^)(NSInteger index,id value))userPressedBlock{
    id obj = [[NSClassFromString(className) alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    PayTypeView *View = (PayTypeView *)obj;
    View.hiddenPage = YES;
    [View showChooseButton:NO];
    View.model = info;
    __weak typeof(View) weakself = View;
    View.viewButtonPressedBlock = ^(NSInteger index,id value) {
        [weakself hiddenView];
        userPressedBlock(index,value);
    };
    View.tag = 10010;
    [[UIApplication sharedApplication].keyWindow addSubview:View];
    [View showView];
}

- (void)setHiddenPage:(BOOL)hiddenPage{
    _hiddenPage = hiddenPage;
    if (_hiddenPage) {
        QMUIButton *tmp = [self.contentView viewWithTag:200 ];
        tmp.hidden = YES;
        self.mymoney.hidden = YES;
        for (int i = 0; i < 3; i++) {
            UIView *view = [self.contentView viewWithTag:900 + i];
            if (i == 0) {
                view.hidden = YES;
            }
            else{
                [view mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(self.chooseCard.mas_bottom).offset((i - 1) * 50);
                    make.left.right.equalTo(self.contentView).offset(0);
                    make.height.offset(50);
                }];
            }
        }
    }
}

- (void)showChooseButton:(BOOL)status{
    if (status) {
        self.contentView.bounds = CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height + 50);
        [_chooseCard mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.offset(50);
        }];
    }
    else{
        [_chooseCard mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.offset(0);
        }];
    }
}

- (void)showChooseType:(BOOL)status{
    self.chooseType.hidden = !status;
}

- (void)reloadDataWith:(VocherModel *)vochModel{
    
    CGFloat pay = (_model.money - _model.weightsBuyMoney + _model.couponMoney - (vochModel ? vochModel.worth_money : 0)) * (1 + [YYCacheManager shareYYCacheManager].saleFloat);
    pay += (_model.weightsBuyMoney -_model.couponMoney);
    pay = pay/100;
    
    _money.text = [NSString stringWithFormat:@"%.2f元",pay];
    [_money setHeightLightWords:@[[NSString stringWithFormat:@"%.2f元",pay]] heightLightColors:nil htightLightFont:@[[UIFont boldSystemFontOfSize:23]]];
    [_money setHeightLightWords:@[[NSString stringWithFormat:@"%.2f",pay]] heightLightColors:nil htightLightFont:@[[UIFont boldSystemFontOfSize:23]]];
    [_payButton setTitle:[NSString stringWithFormat:@"确认支付%.2f",pay] forState:UIControlStateNormal];
}

+ (void)showPayMonenyWith:(UIView *)view{
//    10010
    PayTypeView *typeView = [view viewWithTag:10010];
    if (typeView) {
        typeView.model = typeView.model;
    }
}



@end
