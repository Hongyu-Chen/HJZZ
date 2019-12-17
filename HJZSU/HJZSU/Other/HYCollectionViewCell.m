//
//  HYCollectionViewCell.m
//  youyijia
//
//  Created by apple on 2017/6/30.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "HYCollectionViewCell.h"

@interface HYCollectionViewCell ()

@property (strong,nonatomic) UIImageView *imageView;
@property (strong,nonatomic) UILabel *titleLabel;

@end

@implementation HYCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
//        self.backgroundColor = ARCCOLOR;
//        self.backgroundColor = N_BG_COLOR;
        self.imageView = [self imageView];
        [self.contentView addSubview:_imageView];
        
        [_imageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).offset(0);
            make.left.equalTo(self.contentView).offset(0);
            make.bottom.equalTo(self.contentView).offset(0);
            make.right.equalTo(self.contentView).offset(0);
        }];
        
        self.titleLabel = [self titleLabel];
        [self.contentView addSubview:_titleLabel];
        
        [_titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.offset(40);
            make.left.equalTo(self.contentView).offset(0);
            make.bottom.equalTo(self.contentView).offset(0);
            make.right.equalTo(self.contentView).offset(0);
        }];
        _titleLabel.hidden = NO;
        
    }
    return self;
}

- (UIImageView *)imageView{
    if (_imageView) {
        return _imageView;
    }
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
//    imageView.backgroundColor = N_BG_COLOR;
//    imageView.image = PLACRHOLDERIMAGE;
    return imageView;
}

- (UILabel *)titleLabel{
    if (_titleLabel) {
        return _titleLabel;
    }
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = UIColorMake(39, 39, 39);
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"客厅套餐";
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:12];
    
    return label;
}

- (void)setImageUrl:(NSString *)imageUrl{
    _imageUrl = imageUrl;
    if (_imageUrl) {
//        _imageView.contentMode = 
        if (_imageUrl.length > 0 && ([_imageUrl rangeOfString:@"null"].location == NSNotFound)) {
            [_imageView sd_setImageWithURL:[NSURL URLWithString:_imageUrl] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                [[SDWebImageManager sharedManager].imageCache clearMemory];
            }];
        }
        
    }
}

- (void)setLocationImageName:(NSString *)locationImageName{
    _locationImageName = locationImageName;
    if (_locationImageName) {
        _imageView.image = [UIImage imageNamed:_locationImageName];
    }
}
- (void)setShowImageTitle:(BOOL)showImageTitle{
    _showImageTitle = showImageTitle;
    
    _titleLabel.hidden = !_showImageTitle;
}

- (void)setTitleString:(NSString *)titleString{
    _titleString = titleString;
    if (_titleString) {
        _titleLabel.text = [NSString stringWithFormat:@"%@套餐",_titleString];
    }
}

@end
