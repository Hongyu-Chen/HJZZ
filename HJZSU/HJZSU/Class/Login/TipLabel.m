//
//  TipLabel.m
//  HJZSS
//
//  Created by apple on 2019/3/5.
//  Copyright © 2019 apple. All rights reserved.
//

#import "TipLabel.h"

@interface TipLabel ()

@property (strong,nonatomic) UIView *lineL;
@property (strong,nonatomic) UIView *lineR;

@end

@implementation TipLabel

- (void)setText:(NSString *)text{
    [super setText:text];
}

- (instancetype)init{
    self = [super init];
    if (self) {
        self.font = [UIFont systemFontOfSize:15];
        self.textColor = UIColorMake(73, 73, 73);
        self.textAlignment = NSTextAlignmentCenter;
        
        self.lineL = [self creatLineView];
        self.lineR = [self creatLineView];
        
        [self addSubview:self.lineL];
        [self addSubview:self.lineR];
        
        [_lineL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(self.font.lineHeight/2 - 0.5);
            make.left.equalTo(self).offset(0);
            make.width.offset(120);
            make.height.offset(1.0);
        }];
        
        [_lineR mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(self.font.lineHeight/2 - 0.5);
            make.right.equalTo(self).offset(0);
            make.width.offset(120);
            make.height.offset(1.0);
        }];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat width = [self.text sizeWithAttributes:@{NSFontAttributeName: self.font}].width;
    [_lineL mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.offset((self.frame.size.width - (width + 15))/2);
    }];
    [_lineR mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.offset((self.frame.size.width - (width + 15))/2);
    }];
}

- (UIView *)creatLineView{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = UIColorMake(239, 239, 239);
    return view;
}

@end
