//
//  BankTableViewCell.m
//  HJZSU
//
//  Created by apple on 2019/3/15.
//  Copyright © 2019 apple. All rights reserved.
//

#import "BankTableViewCell.h"

@interface BankTableViewCell ()

@property (strong,nonatomic) UIImageView *bgImageView;
@property (strong,nonatomic) UILabel *name;
@property (strong,nonatomic) UILabel *careNumber;
@property (strong,nonatomic) UILabel *type;

@end

@implementation BankTableViewCell

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
        self.backgroundColor = UIColorMake(239, 239, 239);
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addSubview:self.bgImageView];
        
        [_bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.equalTo(self).offset(13);
            make.right.equalTo(self).offset(-13);
            make.bottom.equalTo(self).offset(0);
            make.height.offset((SCREEN_WIDTH - 26) * 200.0/698.0);
        }];
        
        self.name = [LabelCreat creatLabelWith:@"邮政银行" font:[UIFont systemFontOfSize:18] color:[UIColor whiteColor] textAlignment:NSTextAlignmentLeft];
        self.careNumber = [LabelCreat creatLabelWith:@"**** **** **** 1530" font:[UIFont systemFontOfSize:15] color:[UIColor whiteColor] textAlignment:NSTextAlignmentLeft];
        self.type = [LabelCreat creatLabelWith:@"信用卡" font:[UIFont systemFontOfSize:12] color:[UIColor whiteColor] textAlignment:NSTextAlignmentLeft];
        
        [self.bgImageView addSubview:self.name];
        [self.bgImageView addSubview:self.careNumber];
        [self.bgImageView addSubview:self.type];
        
        [_name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.bgImageView).offset(13);
            make.left.equalTo(self.bgImageView).offset(13);
            make.right.equalTo(self.bgImageView).offset(-13);
        }];
        
        [_careNumber mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.name.mas_bottom).offset(0);
            make.left.equalTo(self.bgImageView).offset(13);
            make.right.equalTo(self.bgImageView).offset(-13);
            make.height.equalTo(self.name);
        }];
        
        [_type mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.careNumber.mas_bottom).offset(0);
            make.left.equalTo(self.bgImageView).offset(13);
            make.right.equalTo(self.bgImageView).offset(-13);
            make.height.equalTo(self.careNumber);
            make.bottom.equalTo(self.bgImageView).offset(-13);
        }];
        
        
    }
    return self;
}

- (UIImageView *)bgImageView{
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc] init];
        _bgImageView.contentMode = UIViewContentModeScaleAspectFit;
        _bgImageView.image = [UIImage imageNamed:@"银行卡底图"];
    }
    return _bgImageView;
}

@end
