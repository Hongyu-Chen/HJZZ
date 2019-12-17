//
//  RankImage.m
//  HJZSU
//
//  Created by apple on 2019/3/7.
//  Copyright © 2019 apple. All rights reserved.
//

#import "RankImage.h"

@interface RankImage ()



@end

@implementation RankImage

- (instancetype)init{
    self = [super init];
    if (self) {
        [self addSubview:self.headerTip];
        [self addSubview:self.header];
        
        [_headerTip mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.left.right.equalTo(self).offset(0);
        }];
        
        [_header mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(7);
            make.left.equalTo(self).offset(5);
            make.bottom.equalTo(self).offset(-3);
            make.right.equalTo(self).offset(-5);
        }];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.headerTip.layer.cornerRadius = self.frame.size.width/2;
    self.header.layer.cornerRadius = (self.frame.size.width - 10)/2;
}

- (UIImageView *)headerTip{
    if (!_headerTip) {
        _headerTip = [[UIImageView alloc] init];
        _headerTip.contentMode = UIViewContentModeScaleAspectFit;
        _headerTip.backgroundColor = [UIColor whiteColor];
        _headerTip.clipsToBounds = YES;
    }
    return _headerTip;
}

- (UIImageView *)header{
    if (!_header) {
        _header = [[UIImageView alloc] init];
        _header.contentMode = UIViewContentModeScaleAspectFill;
        _header.backgroundColor = [UIColor redColor];
        _header.clipsToBounds = YES;
    }
    return _header;
}

@end
