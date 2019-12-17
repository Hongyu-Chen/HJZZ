//
//  BankAddTableViewCell.m
//  HJZSU
//
//  Created by apple on 2019/3/15.
//  Copyright © 2019 apple. All rights reserved.
//

#import "BankAddTableViewCell.h"

@implementation BankAddTableViewCell

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
        
        UIView *view = [[UIView alloc] init];
        view.layer.cornerRadius = 5;
        view.layer.borderColor = UIColorMake(137, 137, 137).CGColor;
        view.layer.borderWidth = 1.0;
        
        [self addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.equalTo(self).offset(13);
            make.right.equalTo(self).offset(-13);
            make.bottom.equalTo(self).offset(0);
            make.height.offset(40);
        }];
    
        UILabel *add = [LabelCreat creatLabelWith:@"+" font:[UIFont boldSystemFontOfSize:14] color:UIColorMake(37, 40, 42) textAlignment:NSTextAlignmentLeft];
        UILabel *tip = [LabelCreat creatLabelWith:@"添加银行卡" font:[UIFont systemFontOfSize:14] color:UIColorMake(37, 40, 42) textAlignment:NSTextAlignmentLeft];
        UIImageView *icon = [[UIImageView alloc] init];
        icon.contentMode = UIViewContentModeScaleAspectFit;
        icon.image = [UIImage imageNamed:@"箭头-向右"];
        
        [view addSubview:add];
        [view addSubview:tip];
        [view addSubview:icon];
        
        [add mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(view).offset(0);
            make.left.equalTo(view).offset(13);
        }];
        
        [tip mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(view).offset(0);
            make.left.equalTo(add.mas_right).offset(13);
        }];
        
        [icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(view).offset(0);
            make.right.equalTo(view).offset(-13);
            make.width.offset(7.5);
        }];
        
    }
    return self;
}

@end
