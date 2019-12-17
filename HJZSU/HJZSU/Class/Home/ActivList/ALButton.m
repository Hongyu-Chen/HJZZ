//
//  ALButton.m
//  HJZSS
//
//  Created by apple on 2019/2/27.
//  Copyright © 2019 apple. All rights reserved.
//

#import "ALButton.h"

@interface ALButton ()

@property (strong,nonatomic) UIImageView *iconImageView;
@property (strong,nonatomic) UILabel *valueLabl;


@end

@implementation ALButton

- (instancetype)init{
    self = [super init];
    if (self) {
        self.style = 0;
        self.backgroundColor = UIColorMake(51, 51, 51);
        [self addSubview:self.iconImageView];
        [self addSubview:self.valueLabl];
        
        [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self).offset(0);
            make.left.equalTo(self).offset(0);
            make.width.offset(15);
        }];
        [_valueLabl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self).offset(0);
            make.left.equalTo(self.iconImageView.mas_right).offset(5);
        }];
        [self addTarget:self action:@selector(buttonPressedWithALBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (UIImageView *)iconImageView{
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.contentMode = UIViewContentModeScaleAspectFit;
        _iconImageView.clipsToBounds = YES;
    }
    return _iconImageView;
}

- (UILabel *)valueLabl{
    if (!_valueLabl) {
        _valueLabl = [LabelCreat creatLabelWith:@"" font:[UIFont systemFontOfSize:13] color:[UIColor whiteColor] textAlignment:NSTextAlignmentLeft];
    }
    return _valueLabl;
}

- (void)layoutSubviews{
    CGFloat width = [self.valueStr sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13.0]}].width;
    [_iconImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset((self.frame.size.width - width - 20 )/2);
    }];
}

- (void)setIconImage:(UIImage *)iconImage{
    _iconImage = iconImage;
    if (_iconImage) {
        _iconImageView.image = _iconImage;
    }
}

- (void)setValueStr:(NSString *)valueStr{
    _valueStr = valueStr;
    if (_valueStr) {
        _valueLabl.text = _valueStr;
    }
}

- (void)buttonPressedWithALBtn:(UIButton *)sender{
    if (self.buttonPressedBlock) {
        self.style++;
        self.buttonPressedBlock(self.style%3);
    }
}

@end
