//
//  CertificationLocationCell.m
//  HJZSU
//
//  Created by apple on 2019/3/15.
//  Copyright © 2019 apple. All rights reserved.
//

#import "CertificationLocationCell.h"

@interface CertificationLocationCell ()

@property (strong,nonatomic) UILabel *value;
//@property ()

@end

@implementation CertificationLocationCell

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
    if (self) {
        self.backgroundColor = UIColorMakeWithRGBA(239, 239, 239, 1.0);
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIView *bgView = [[UIView alloc] init];
        bgView.backgroundColor = [UIColor whiteColor];
        [self addSubview:bgView];
        bgView.layer.cornerRadius = 5.0;
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(13);
            make.left.equalTo(self).offset(13);
            make.right.equalTo(self).offset(-13);
            make.bottom.equalTo(self).offset(0);
        }];
        
        UILabel *tip1 = [LabelCreat creatLabelWith:@"城市" font:[UIFont boldSystemFontOfSize:15] color:UIColorMake(51, 51, 51) textAlignment:NSTextAlignmentLeft];
        self.value = [LabelCreat creatLabelWith:@"成都市" font:[UIFont boldSystemFontOfSize:15] color:UIColorMake(137, 137, 137) textAlignment:NSTextAlignmentLeft];
        UIImageView *icon = [[UIImageView alloc] init];
        icon.contentMode = UIViewContentModeScaleAspectFit;
        icon.image = [UIImage imageNamed:@"箭头-向右"];
        
        
        [bgView addSubview:tip1];
        [bgView addSubview:icon];
        [bgView addSubview:self.value];
        
        [tip1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(bgView).offset(0);
            make.left.equalTo(bgView).offset(10);
            make.height.offset(50);
        }];
        
        [icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(bgView).offset(0);
            make.right.equalTo(bgView).offset(-13);
            make.width.offset(7.5);
        }];
        
        [_value mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(bgView).offset(0);
            make.right.equalTo(icon.mas_left).offset(-13);
        }];
        
        
    }
    return self;
}

- (void)setModel:(AuthModel *)model{
    _model = model;
    if (_model) {
        _value.text = _model.city;
    }
}

@end
