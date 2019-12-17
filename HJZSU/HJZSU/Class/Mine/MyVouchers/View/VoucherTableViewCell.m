//
//  VoucherTableViewCell.m
//  HJZSU
//
//  Created by apple on 2019/3/14.
//  Copyright © 2019 apple. All rights reserved.
//

#import "VoucherTableViewCell.h"

@interface VoucherTableViewCell ()

@property (strong,nonatomic) UIImageView *bgImage;
@property (strong,nonatomic) UILabel *number;
@property (strong,nonatomic) UILabel *tip;
@property (strong,nonatomic) UILabel *time;
@property (strong,nonatomic) UILabel *des;
@property (strong,nonatomic) UILabel *statusLabel;

@property (strong,nonatomic) UIView *maskView;
@property (strong,nonatomic) UIImageView *selectedImage;


@end

@implementation VoucherTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        
        self.backgroundColor = UIColorMake(239, 239, 239);
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        UIView *bgView = [[UIView alloc] init];
        bgView.layer.cornerRadius = 5;
        bgView.backgroundColor = [UIColor whiteColor];
        [self addSubview:bgView];
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(self).offset(13);
            make.right.bottom.equalTo(self).offset(-13);
            make.height.offset((SCREEN_WIDTH - 52) * 200.0/640.0 + 26);
        }];
        
        self.number = [LabelCreat creatLabelWith:@"1900" font:[UIFont boldSystemFontOfSize:24] color:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter];
        UILabel *danwei = [LabelCreat creatLabelWith:@"元" font:[UIFont systemFontOfSize:15] color:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter];
        self.tip = [LabelCreat creatLabelWith:@"有限期到" font:[UIFont systemFontOfSize:15] color:[UIColor whiteColor] textAlignment:NSTextAlignmentLeft];
        self.time = [LabelCreat creatLabelWith:@"2019-03-12" font:[UIFont systemFontOfSize:15] color:[UIColor whiteColor] textAlignment:NSTextAlignmentLeft];
        self.des = [LabelCreat creatLabelWith:@"使用说明描述..." font:[UIFont systemFontOfSize:15] color:[UIColor whiteColor] textAlignment:NSTextAlignmentLeft];
        self.statusLabel = [LabelCreat creatLabelWith:@"" font:[UIFont systemFontOfSize:15] color:[UIColor whiteColor] textAlignment:NSTextAlignmentLeft];
        self.des.numberOfLines = 0;
        
        [bgView addSubview:self.bgImage];
        [self.bgImage addSubview:self.number];
        [self.bgImage addSubview:danwei];
        [self.bgImage addSubview:self.tip];
        [self.bgImage addSubview:self.time];
        [self.bgImage addSubview:self.des];
        [self.bgImage addSubview:self.statusLabel];
        [self.bgImage addSubview:self.maskView];
        
        [_bgImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(bgView).offset(13);
            make.right.bottom.equalTo(bgView).offset(-13);
        }];
        
        [_number mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.bgImage).offset(((SCREEN_WIDTH - 52) * 200.0/640.0 - 49)/2);
            make.left.equalTo(self.bgImage).offset(0);
            make.width.offset(184.0/600 * (SCREEN_WIDTH - 52));
        }];
        
        [danwei mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.number.mas_bottom).offset(0);
            make.bottom.equalTo(self.bgImage).offset(-((SCREEN_WIDTH - 52) * 200.0/640.0 - 49)/2);
            make.width.height.equalTo(self.number);
        }];
        
        [_tip mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.number.mas_right).offset(20);
            make.top.equalTo(self.bgImage).offset(13);
        }];
        
        [_time mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.bgImage).offset(13);
            make.right.equalTo(self.bgImage).offset(-13);
        }];
        
        [_des mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.tip.mas_bottom).offset(13);
            make.left.equalTo(self.number.mas_right).offset(20);
            make.right.equalTo(self.bgImage).offset(-13);
        }];
        
        [_statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.bgImage).offset(-13);
            make.right.equalTo(self.bgImage).offset(-13);
        }];
        
        [_maskView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self.bgImage).offset(0);
            make.bottom.equalTo(self.bgImage).offset(0);
        }];
        
    }
    return self;
}

- (UIImageView *)bgImage{
    if (!_bgImage) {
        _bgImage = [[UIImageView alloc] init];
        _bgImage.contentMode = UIViewContentModeScaleAspectFit;
        _bgImage.image = [UIImage imageNamed:@"优惠券"];
    }
    return _bgImage;
}

- (UIView *)maskView{
    if (!_maskView) {
        _maskView = [[UIView alloc] init];
        _maskView.backgroundColor = UIColorMakeWithRGBA(255, 80, 0, 0.2);
        [_maskView addSubview:self.selectedImage];
        [_selectedImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.maskView).offset(13);
            make.right.equalTo(self.maskView).offset(-13);
        }];
    }
    return _maskView;
}

- (UIImageView *)selectedImage{
    if (!_selectedImage) {
        _selectedImage = [[UIImageView alloc] init];
        _selectedImage.contentMode = UIViewContentModeScaleAspectFit;
        _selectedImage.image = [UIImage imageNamed:@"勾选-选中-圆圈"];
    }
    return _selectedImage;
}


- (void)setModel:(VocherModel *)model{
    _model = model;
    if (_model) {
        self.des.text = _model.brief;
        self.time.text = [ProjectTool dateTimerConversionWithTimeStamp:_model.end_time];
        self.number.text = [NSString stringWithFormat:@"%.0f",_model.worth_money/100];
        
        if (_model.status == 0) {
            _bgImage.image = [UIImage imageNamed:@"优惠券"];
            
            self.statusLabel.text = @"";
        }
        else{
            _bgImage.image = [[UIImage imageNamed:@"优惠券"] qmui_imageWithTintColor:[UIColor grayColor]];
            self.statusLabel.text = _model.status == 1 ? @"已使用" : @"已过期";
        }
        self.maskView.hidden = !_model.chooseStatus;
    }
}


@end
