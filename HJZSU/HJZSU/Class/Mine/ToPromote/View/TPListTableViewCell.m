//
//  TPListTableViewCell.m
//  HJZSU
//
//  Created by apple on 2019/3/15.
//  Copyright © 2019 apple. All rights reserved.
//

#import "TPListTableViewCell.h"

@interface TPListTableViewCell ()

@property (strong,nonatomic) UIImageView *header;
@property (strong,nonatomic) UILabel *name;

@end

@implementation TPListTableViewCell

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
        self.name = [LabelCreat creatLabelWith:@"姓名" font:[UIFont boldSystemFontOfSize:15] color:UIColorMake(34, 34, 34) textAlignment:NSTextAlignmentLeft];
        [self addSubview:self.header];
        [self addSubview:self.name];
        
        [_header mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.equalTo(self).offset(13);
            make.bottom.equalTo(self).offset(-13);
            make.width.height.offset(30);
        }];
        
        [_name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.top.equalTo(self).offset(0);
            make.left.equalTo(self.header.mas_right).offset(13);
            make.right.equalTo(self).offset(-13);
        }];
        
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = UIColorMake(239, 239, 239);
        [self addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self).offset(0);
            make.left.equalTo(self).offset(13);
            make.right.equalTo(self).offset(0);
            make.height.offset(1);
        }];
    }
    return self;
}

- (UIImageView *)header{
    if (!_header) {
        _header = [[UIImageView alloc] init];
        _header.clipsToBounds = YES;
        _header.backgroundColor = [UIColor whiteColor];
        _header.image = PLACEHOLDERIMAGE;
        _header.layer.cornerRadius = 15;
    }
    return _header;
}

- (void)setModel:(TopPromoteModel *)model{
    _model = model;
    if (_model) {
        [_header sd_setImageWithURL:[NSURL URLWithString:_model.head] placeholderImage:PLACEHOLDERIMAGE];
        _name.text = _model.name;
    }
}

@end
