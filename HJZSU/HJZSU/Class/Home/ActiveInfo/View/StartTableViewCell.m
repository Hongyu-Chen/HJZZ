//
//  StartTableViewCell.m
//  HJZSS
//
//  Created by apple on 2019/2/27.
//  Copyright © 2019 apple. All rights reserved.
//

#import "StartTableViewCell.h"

@interface StartTableViewCell ()

@property (strong,nonatomic) UIImageView *iconImage;
@property (strong,nonatomic) UILabel *tip;
@property (strong,nonatomic) UILabel *valueLabel;


@end

@implementation StartTableViewCell

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
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        self.tip = [LabelCreat creatLabelWith:@"用户星评" font:[UIFont systemFontOfSize:15] color:UIColorMake(34, 34, 34) textAlignment:NSTextAlignmentLeft];
        self.valueLabel = [LabelCreat creatLabelWith:@"5.0" font:[UIFont systemFontOfSize:15] color:UIColorMake(137, 137, 137) textAlignment:NSTextAlignmentLeft];
        
        [self addSubview:self.iconImage];
        [self addSubview:self.tip];
        [self addSubview:self.valueLabel];
        
        [_iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(0);
            make.left.equalTo(self).offset(13);
            make.height.offset(50);
            make.width.offset(7.5);
        }];
        
        [_tip mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(0);
            make.left.equalTo(self.iconImage.mas_right).offset(10);
            make.right.equalTo(self).offset(-13);
            make.height.offset(50);
            make.bottom.equalTo(self).offset(-13);
        }];
        
        [_valueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self).offset(-13);
            make.right.equalTo(self).offset(-13);
            make.top.equalTo(self).offset(0);
            make.height.offset(50);
        }];
        
        UIView *line  = [[UIView alloc] init];
        line.backgroundColor = UIColorMake(239, 239, 239);
        [self addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.equalTo(self).offset(0);
            make.height.offset(13);
        }];
        [self addStart];
        
    }
    return self;
}

- (UIImageView *)iconImage{
    if (!_iconImage) {
        _iconImage = [[UIImageView alloc] init];
        _iconImage.contentMode = UIViewContentModeScaleAspectFit;
        _iconImage.image = [UIImage imageNamed:@"装饰"];
    }
    return _iconImage;
}

- (void)addStart{
    for (int i = 0; i < 5; i++) {
        UIImageView *start = [[UIImageView alloc] init];
        start.image = [UIImage imageNamed:@"星-大-未选中"];
        start.contentMode = UIViewContentModeScaleAspectFit;
        start.tag = 200 + i;
        [self addSubview:start];
        
        [start mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(0);
            make.right.equalTo(self.valueLabel.mas_left).offset(-(25 * (5 - i)));
            make.width.offset(20);
            make.height.offset(50);
        }];
    }
}

- (void)setActiviteInfo:(NSDictionary *)activiteInfo{
    _activiteInfo = activiteInfo;
    if (_activiteInfo) {
        NSInteger score = [_activiteInfo[@"score"] integerValue];
        score = score - 1;
        for (int i = 0; i < 5; i++) {
            UIImageView *tmp = [self viewWithTag:200 + i];
            if (i <= score) {
                tmp.image = [UIImage imageNamed:@"星-大-选中"];
            }
            else{
                tmp.image = [UIImage imageNamed:@"星-大-未选中"];
            }
        }
    }
}


@end
