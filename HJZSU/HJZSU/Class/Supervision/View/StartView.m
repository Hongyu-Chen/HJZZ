//
//  StartView.m
//  HJZSS
//
//  Created by apple on 2019/2/28.
//  Copyright © 2019 apple. All rights reserved.
//

#import "StartView.h"


@interface StartView ()

@property (strong,nonatomic) UILabel *numberLab;

@end

@implementation StartView

- (instancetype)init{
    self = [super init];
    if (self) {
        self.margin = 5.0;
        self.widthS = 20.0;
        [self addStart];
        self.numberLab = [LabelCreat creatLabelWith:@"0.0" font:[UIFont systemFontOfSize:14] color:UIColorMake(137, 137, 137) textAlignment:NSTextAlignmentLeft];
        [self addSubview:self.numberLab];
        [_numberLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self).offset(0);
            make.right.equalTo(self).offset(0);
            make.left.equalTo(self).offset((self.widthS + self.margin) * 5 + 10);
        }];
        
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.numberLab mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset((self.widthS + self.margin) * 5 + 10);
    }];
}

- (void)setMargin:(CGFloat)margin{
    _margin = margin;
    
    if (_margin) {
        for (int i = 0; i < 5; i++) {
            UIImageView *start = [self viewWithTag:i + 100];
            [start mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self).offset((self.widthS + self.margin) * i);
            }];
        }
    }
}

- (void)setWidthS:(CGFloat)widthS{
    _widthS = widthS;
    if (_widthS) {
        for (int i = 0; i < 5; i++) {
            UIImageView *start = [self viewWithTag:i + 100];
            [start mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.height.offset(self.widthS);
                make.left.equalTo(self).offset((self.widthS + self.margin) * i);
            }];
        }
    }
}

- (void)addStart{
    for (int i = 0; i < 5; i++) {
        UIImageView *start = [[UIImageView alloc] init];
        start.image = [UIImage imageNamed:@"星-大-未选中"];
        start.contentMode = UIViewContentModeScaleAspectFit;
        start.tag = 100 + i;
        [self addSubview:start];
        [start mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(0);
            make.bottom.equalTo(self).offset(0);
            make.left.equalTo(self).offset((self.widthS + self.margin) * i);
        }];
    }
}

- (void)setNumber:(CGFloat)number{
    _number = number;
    for (int i = 0; i < 5; i++) {
        UIImageView *tmp = [self viewWithTag:100 + i];
        if (i < _number) {
            tmp.image = [UIImage imageNamed:@"星-大-选中"];
        }
        else{
            tmp.image = [UIImage imageNamed:@"星-大-未选中"];
        }
    }

    _numberLab.text = [NSString stringWithFormat:@"%.1f",_number];
}

- (void)setColor:(UIColor *)color{
    _color = color;
    if (_color) {
        _numberLab.textColor = _color;
    }
}

@end
