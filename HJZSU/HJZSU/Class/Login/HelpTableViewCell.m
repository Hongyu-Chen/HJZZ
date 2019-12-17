//
//  HelpTableViewCell.m
//  HJZSS
//
//  Created by apple on 2019/3/4.
//  Copyright © 2019 apple. All rights reserved.
//

#import "HelpTableViewCell.h"

@interface HelpTableViewCell ()

@property (strong,nonatomic) FormatLabel *contentLab;

@end

@implementation HelpTableViewCell

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
        
        [self addSubview:self.contentLab];
        [_contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.equalTo(self).offset(13);
            make.right.bottom.equalTo(self).offset(-13);
        }];
    }
    return self;
}

- (FormatLabel *)contentLab{
    if (!_contentLab) {
        _contentLab = [[FormatLabel alloc] init];
        _contentLab.numberOfLines = 0;
        _contentLab.lineSpcae = 5.0;
        _contentLab.wordSpace = 1.5;
        _contentLab.textColor = UIColorMake(137, 137, 137);
        _contentLab.font = [UIFont systemFontOfSize:13];
        _contentLab.text = @"文字描述...文字描述...文字描述...文字描述...文字描述...文字描述...文字描述...文字描述...文字描述...文字描述...文字描述...文字描述...文字描述...文字描述...文字描述...文字描述...文字描述...文字描述...文字描述...文字描述...文字描述...文字描述...文字描述...文字描述...文字描述...文字描述...文字描述...文字描述...文字描述...文字描述...文字描述...文字描述...文字描述...文字描述...文字描述...文字描述...文字描述...文字描述...文字描述...文字描述...文字描述...文字描述...文字描述...文字描述...文字描述...文字描述...文字描述...文字描述...文字描述...文字描述...文字描述...文字描述...文字描述...文字描述...文字描述...文字描述...文字描述...文字描述...文字描述...文字描述...文字描述...文字描述...文字描述...";
    }
    return _contentLab;
}

@end
