//
//  OrderSpaceTableViewCell.m
//  HJZSU
//
//  Created by apple on 2019/3/13.
//  Copyright © 2019 apple. All rights reserved.
//

#import "OrderSpaceTableViewCell.h"

@interface OrderSpaceTableViewCell ()

@property (strong,nonatomic) UILabel *titleLab;
@property (strong,nonatomic) QMUITextView *textView;

@end

@implementation OrderSpaceTableViewCell

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
        
        self.titleLab = [LabelCreat creatLabelWith:@"取消原因" font:[UIFont systemFontOfSize:14] color:UIColorMake(51, 51, 51) textAlignment:NSTextAlignmentLeft];
        [self addSubview:self.titleLab];
        [self addSubview:self.textView];
        
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(0);
            make.left.equalTo(self).offset(13);
            make.height.offset(50);
        }];
        
        [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLab.mas_bottom).offset(0);
            make.left.equalTo(self).offset(13);
            make.right.bottom.equalTo(self).offset(-13);
            make.height.offset(100);
        }];
        
        UIView *lien = [[UIView alloc] init];
        lien.backgroundColor = UIColorMake(239, 239, 239);
        [self addSubview:lien];
        [lien mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-13);
            make.bottom.equalTo(self).offset(0);
            make.left.equalTo(self).offset(13);
            make.height.offset(1);
        }];
        
    }
    return self;
}

-(QMUITextView *)textView{
    if (!_textView) {
        _textView = [[QMUITextView alloc] init];
        _textView.backgroundColor = UIColorMake(220, 220, 220);
        _textView.textColor = UIColorMake(51, 51, 51);
        _textView.font = [UIFont systemFontOfSize:14];
        _textView.userInteractionEnabled = NO;

    }
    return _textView;
}

- (void)setModel:(OrderModelInfo *)model{
    _model = model;
    if (_model) {
        _textView.text = _model.comment;
    }
}


@end
