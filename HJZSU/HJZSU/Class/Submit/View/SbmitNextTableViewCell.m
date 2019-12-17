//
//  SbmitNextTableViewCell.m
//  HJZSU
//
//  Created by apple on 2019/3/11.
//  Copyright © 2019 apple. All rights reserved.
//

#import "SbmitNextTableViewCell.h"

@interface SbmitNextTableViewCell ()

@property (strong,nonatomic) UILabel *next;

@end



@implementation SbmitNextTableViewCell

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
        self.backgroundColor = UIColorMake(239, 239, 239);
        
        
        self.tipLabel = [LabelCreat creatLabelWith:@"套餐仅为基础任务部分，低于第三方差旅及超额部分的佣金，有双方自动协商" font:[UIFont systemFontOfSize:14] color:UIColorMake(250, 80, 0) textAlignment:NSTextAlignmentLeft];
        _tipLabel.numberOfLines = 0;
        [self addSubview:_tipLabel];
        
        
        
        self.next = [LabelCreat creatLabelWith:@"" font:[UIFont systemFontOfSize:18] color:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter];
        _next.clipsToBounds = YES;
        _next.backgroundColor = UIColorMake(255, 80, 0);
        _next.layer.cornerRadius = 5;
        [self addSubview:self.next];
        [_next mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(55);
            make.left.equalTo(self).offset(13);
            make.right.equalTo(self).offset(-13);
            make.bottom.equalTo(self).offset(-50);
            make.height.offset(45);
        }];
        
        [_tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.next.mas_top).offset(-10);
            make.left.equalTo(self).offset(13);
            make.right.equalTo(self).offset(-13);
        }];
    }
    return self;
}

- (void)setValue:(NSString *)value{
    _value = value;
    if (_value) {
        _next.text = _value;
    }
}

@end
