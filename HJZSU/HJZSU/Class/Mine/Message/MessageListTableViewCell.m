//
//  MessageListTableViewCell.m
//  HJZSS
//
//  Created by apple on 2019/3/4.
//  Copyright © 2019 apple. All rights reserved.
//

#import "MessageListTableViewCell.h"

@interface MessageListTableViewCell ()

@property (strong,nonatomic) UIImageView *headerImage;
@property (strong,nonatomic) UILabel *name;
@property (strong,nonatomic) UILabel *time;

@end

@implementation MessageListTableViewCell

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
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        self.name = [LabelCreat creatLabelWith:@"系统消息" font:[UIFont boldSystemFontOfSize:15] color:UIColorMake(51, 51, 51) textAlignment:NSTextAlignmentLeft];
        self.time = [LabelCreat creatLabelWith:@"09-12 23:22" font:[UIFont systemFontOfSize:11] color:UIColorMake(137, 137, 137) textAlignment:NSTextAlignmentLeft];
        
        [self addSubview:self.headerImage];
        [self addSubview:self.name];
        [self addSubview:self.time];
        
        [_headerImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(15);
            make.left.equalTo(self).offset(13);
            make.bottom.equalTo(self).offset(-15);
            make.width.height.offset(30);
        }];
        
        [_name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self).offset(0);
            make.left.equalTo(self.headerImage.mas_right).offset(13);
        }];
        
        [_time mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self).offset(0);
            make.right.equalTo(self).offset(-13);
        }];
        
        
        UIView *lien = [[UIView alloc] init];
        lien.backgroundColor = UIColorMake(239, 239, 239);
        [self addSubview:lien];
        [lien mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(0);
            make.right.equalTo(self).offset(0);
            make.bottom.equalTo(self).offset(0);
            make.height.offset(1);
        }];
        
    }
    return self;
}

- (UIImageView *)headerImage{
    if (!_headerImage) {
        _headerImage = [[UIImageView alloc] init];
        _headerImage.clipsToBounds = YES;
        _headerImage.contentMode = UIViewContentModeScaleAspectFit;
        _headerImage.layer.cornerRadius = 15;
        _headerImage.image = UIImageMake(@"系统消息");
    }
    return _headerImage;
}

- (void)setModel:(MessageModel *)model{
    _model = model;
    if (_model) {
        _name.text = _model.title;
        _time.text = [NSString hoursTimeWith:_model.create_time];
    }
}

@end
