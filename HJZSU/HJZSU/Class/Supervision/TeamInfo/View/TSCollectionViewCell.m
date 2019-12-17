//
//  TSCollectionViewCell.m
//  HJZSU
//
//  Created by apple on 2019/3/13.
//  Copyright © 2019 apple. All rights reserved.
//

#import "TSCollectionViewCell.h"

@interface TSCollectionViewCell ()

@property (strong,nonatomic) UIImageView *imageView;

@end

@implementation TSCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.imageView];
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.bottom.equalTo(self).offset(0);
        }];
    }
    return self;
}

- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.clipsToBounds = YES;
    }
    return _imageView;
}

- (void)setIamgeURL:(NSString *)iamgeURL{
    _iamgeURL = iamgeURL;
    if (_iamgeURL) {
        [_imageView sd_setImageWithURL:[NSURL URLWithString:_iamgeURL] placeholderImage:PLACEHOLDERIMAGE];
    }
}

@end
