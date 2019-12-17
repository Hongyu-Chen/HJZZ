//
//  RankView.m
//  HJZSU
//
//  Created by apple on 2019/3/7.
//  Copyright © 2019 apple. All rights reserved.
//

#import "RankView.h"

@interface RankView ()

@property (strong,nonatomic) UIImageView *rankImage;
@property (strong,nonatomic) UILabel *rankLab;

@end

@implementation RankView

- (instancetype)init{
    self = [super init];
    if (self) {
        [self addSubview:self.rankImage];
        [self addSubview:self.rankLab];
        
        [_rankImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(15);
            make.left.right.equalTo(self).offset(0);
            make.bottom.equalTo(self).offset(-15);
        }];
        
        [_rankLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.left.right.equalTo(self).offset(0);
        }];
    }
    return self;
}

- (UIImageView *)rankImage{
    if (!_rankImage) {
        _rankImage = [[UIImageView alloc] init];
        _rankImage.contentMode = UIViewContentModeScaleAspectFit;
        _rankImage.backgroundColor = [UIColor clearColor];
    }
    return _rankImage;
}

- (UILabel *)rankLab{
    if (!_rankLab) {
        _rankLab = [LabelCreat creatLabelWith:@"" font:[UIFont boldSystemFontOfSize:15] color:UIColorMake(51, 51, 51) textAlignment:NSTextAlignmentCenter];
    }
    return _rankLab;
}

- (void)setRank:(NSInteger)rank{
    _rank = rank;
    _rankLab.text = [NSString stringWithFormat:@"%ld",_rank];
    if (_rank < 4) {
        _rankImage.image = [UIImage imageNamed:@[@"第一名奖杯",@"第二名奖杯",@"第三名奖杯"][_rank - 1]];
        _rankImage.hidden = NO;
        _rankLab.hidden = YES;
    }
    else{
        _rankImage.hidden = YES;
        _rankLab.hidden = NO;
    }
}

@end
