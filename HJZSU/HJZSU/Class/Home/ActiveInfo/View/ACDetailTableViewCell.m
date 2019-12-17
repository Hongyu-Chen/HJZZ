//
//  ACDetailTableViewCell.m
//  HJZSS
//
//  Created by apple on 2019/2/27.
//  Copyright © 2019 apple. All rights reserved.
//

#import "ACDetailTableViewCell.h"

@interface ACDetailTableViewCell ()

@property (strong,nonatomic) UIImageView *iconImage;
@property (strong,nonatomic) UILabel *tip;
@property (strong,nonatomic) UILabel *conentLab;

@end

@implementation ACDetailTableViewCell

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
        self.tip = [LabelCreat creatLabelWith:@"活动简介" font:[UIFont systemFontOfSize:15] color:UIColorMake(34, 34, 34) textAlignment:NSTextAlignmentLeft];
        self.conentLab = [LabelCreat creatLabelWith:@"文字描述xx...文字描述xx...文字描述xx...文字描述xx...文字描述xx...文字描述xx...文字描述xx...文字描述xx...文字描述xx...文字描述xx...文字描述xx...文字描述xx...文字描述xx...文字描述xx...文字描述xx..." font:[UIFont systemFontOfSize:15] color:UIColorMake(137, 137, 137) textAlignment:NSTextAlignmentLeft];
        self.conentLab.numberOfLines = 0;
        
        [self addSubview:self.iconImage];
        [self addSubview:self.tip];
        [self addSubview:self.conentLab];
        
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
        }];
        
        [_conentLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.tip.mas_bottom).offset(10);
            make.left.equalTo(self).offset(13);
            make.right.equalTo(self).offset(-13);
            make.bottom.equalTo(self).offset(-35);
        }];
        
        UIView *line  = [[UIView alloc] init];
        line.backgroundColor = UIColorMake(239, 239, 239);
        [self addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.equalTo(self).offset(0);
            make.height.offset(13);
        }];
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

- (void)setActiviteInfo:(NSDictionary *)activiteInfo{
    _activiteInfo = activiteInfo;
    if (_activiteInfo) {
        _conentLab.text = _activiteInfo[@"comment"];
    }
}


@end
