//
//  TeameBaseInfoView.m
//  HJZSU
//
//  Created by apple on 2019/3/13.
//  Copyright © 2019 apple. All rights reserved.
//

#import "TeameBaseInfoView.h"

@interface TeameBaseInfoView ()

@property (strong,nonatomic) UILabel *yeaer;
@property (strong,nonatomic) UILabel *phone;
@property (strong,nonatomic) UILabel *location;
@property (strong,nonatomic) UILabel *goodFor;
@property (strong,nonatomic) UILabel *tip;
@property (strong,nonatomic) UIButton *canel;

@end

@implementation TeameBaseInfoView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentFrame = CGRectMake(13, (self.frame.size.height - 350)/2, self.frame.size.width - 26, 350);
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.contentView.layer.cornerRadius = 10;
        self.contentView.clipsToBounds = YES;
        self.type = BasePopupMenuAnimationTypeAlert;
        
        UILabel *title = [LabelCreat creatLabelWith:@"基本资料" font:[UIFont boldSystemFontOfSize:18] color:UIColorMake(255, 80, 0) textAlignment:NSTextAlignmentCenter];
        UILabel *yeaerTip = [LabelCreat creatLabelWith:@"从业年限" font:[UIFont boldSystemFontOfSize:15] color:UIColorMake(51, 51, 51) textAlignment:NSTextAlignmentLeft];
        UILabel *phoneTip = [LabelCreat creatLabelWith:@"电话" font:[UIFont boldSystemFontOfSize:15] color:UIColorMake(51, 51, 51) textAlignment:NSTextAlignmentLeft];
        UILabel *locationTip = [LabelCreat creatLabelWith:@"地址" font:[UIFont boldSystemFontOfSize:15] color:UIColorMake(51, 51, 51) textAlignment:NSTextAlignmentLeft];
        UILabel *goodForTip = [LabelCreat creatLabelWith:@"擅长领域" font:[UIFont boldSystemFontOfSize:15] color:UIColorMake(51, 51, 51) textAlignment:NSTextAlignmentLeft];
        UILabel *tipTip = [LabelCreat creatLabelWith:@"格言" font:[UIFont boldSystemFontOfSize:15] color:UIColorMake(51, 51, 51) textAlignment:NSTextAlignmentLeft];
        
        self.yeaer = [LabelCreat creatLabelWith:@"从业年限" font:[UIFont systemFontOfSize:15] color:UIColorMake(137, 137, 137) textAlignment:NSTextAlignmentRight];
        self.phone = [LabelCreat creatLabelWith:@"电话" font:[UIFont systemFontOfSize:15] color:UIColorMake(137, 137, 137) textAlignment:NSTextAlignmentRight];
        self.location = [LabelCreat creatLabelWith:@"地址" font:[UIFont systemFontOfSize:15] color:UIColorMake(137, 137, 137) textAlignment:NSTextAlignmentRight];
        self.goodFor = [LabelCreat creatLabelWith:@"擅长领域" font:[UIFont systemFontOfSize:15] color:UIColorMake(137, 137, 137) textAlignment:NSTextAlignmentRight];
        self.tip = [LabelCreat creatLabelWith:@"格言" font:[UIFont systemFontOfSize:15] color:UIColorMake(137, 137, 137) textAlignment:NSTextAlignmentRight];
        
        [self.contentView addSubview:title];
        [self.contentView addSubview:yeaerTip];
        [self.contentView addSubview:phoneTip];
        [self.contentView addSubview:locationTip];
        [self.contentView addSubview:goodForTip];
        [self.contentView addSubview:tipTip];
        [self.contentView addSubview:self.yeaer];
        [self.contentView addSubview:self.phone];
        [self.contentView addSubview:self.location];
        [self.contentView addSubview:self.goodFor];
        [self.contentView addSubview:self.tip];
        [self.contentView addSubview:self.canel];
        
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).offset(0);
            make.left.right.equalTo(self.contentView).offset(0);
            make.height.offset(50);
        }];
        
        [yeaerTip mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(title.mas_bottom).offset(0);
            make.left.equalTo(self.contentView).offset(13);
            make.height.offset(42);
        }];
        [_yeaer mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(title.mas_bottom).offset(0);
            make.left.equalTo(yeaerTip.mas_right).offset(13);
            make.right.equalTo(self.contentView).offset(-13);
            make.height.equalTo(yeaerTip);
        }];
        
        [phoneTip mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(yeaerTip.mas_bottom).offset(0);
            make.left.equalTo(self.contentView).offset(13);
            make.height.offset(42);
        }];
        [_phone mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(yeaerTip.mas_bottom).offset(0);
            make.left.equalTo(phoneTip.mas_right).offset(13);
            make.right.equalTo(self.contentView).offset(-13);
            make.height.equalTo(phoneTip);
        }];
        
        [locationTip mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(phoneTip.mas_bottom).offset(0);
            make.left.equalTo(self.contentView).offset(13);
            make.height.offset(42);
        }];
        [_location mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(phoneTip.mas_bottom).offset(0);
            make.left.equalTo(locationTip.mas_right).offset(13);
            make.right.equalTo(self.contentView).offset(-13);
            make.height.equalTo(locationTip);
        }];
        
        [goodForTip mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(locationTip.mas_bottom).offset(0);
            make.left.equalTo(self.contentView).offset(13);
            make.height.offset(42);
        }];
        [_goodFor mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(locationTip.mas_bottom).offset(0);
            make.left.equalTo(goodForTip.mas_right).offset(13);
            make.right.equalTo(self.contentView).offset(-13);
            make.height.equalTo(goodForTip);
        }];
        
        [tipTip mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(goodForTip.mas_bottom).offset(0);
            make.left.equalTo(self.contentView).offset(13);
            make.height.offset(42);
        }];
        [_tip mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(goodForTip.mas_bottom).offset(0);
            make.left.equalTo(tipTip.mas_right).offset(13);
            make.right.equalTo(self.contentView).offset(-13);
            make.height.equalTo(tipTip);
        }];
        
        [_canel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(tipTip.mas_bottom).offset(23);
            make.left.equalTo(self.contentView).offset((self.frame.size.width - 26 - 140)/2);
            make.width.offset(140);
            make.height.offset(40);
        }];
        
    }
    return self;
}

- (UIButton *)canel{
    if (!_canel) {
        _canel = [[UIButton alloc] init];
        [_canel setTitle:@"取消" forState:UIControlStateNormal];
        [_canel setTitleColor:UIColorMake(51, 51, 51) forState:UIControlStateNormal];
        _canel.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        _canel.layer.cornerRadius = 5;
        _canel.layer.borderColor = UIColorMake(239, 239, 239).CGColor;
        _canel.layer.borderWidth = 1.0;
        _canel.tag = 100;
        [_canel addTarget:self action:@selector(typeViewButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _canel;
}

- (void)setInfo:(NSDictionary *)info{
    _info = info;
    if (_info) {
        
    }
}

@end
