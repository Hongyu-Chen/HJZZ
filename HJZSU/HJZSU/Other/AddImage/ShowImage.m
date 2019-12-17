//
//  ShowImage.m
//  HJZSU
//
//  Created by apple on 2019/3/9.
//  Copyright © 2019 apple. All rights reserved.
//

#import "ShowImage.h"

@interface ShowImage ()

@property (strong,nonatomic) UIButton *delete;

@end

@implementation ShowImage

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = YES;
        self.layer.cornerRadius = 5;
        [self addSubview:self.delete];
        [_delete mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.equalTo(self).offset(0);
            make.width.height.offset(35);
        }];
        
        self.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage:)];
        [self addGestureRecognizer:tap];
        
    }
    return self;
}

- (UIButton *)delete{
    if (!_delete) {
        _delete = [[UIButton alloc] init];
        [_delete setImage:[UIImage imageNamed:@"删除图片"] forState:UIControlStateNormal];
        _delete.imageView.contentMode = UIViewContentModeScaleAspectFit;
        _delete.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
        [_delete addTarget:self action:@selector(deleteBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _delete;
}

- (void)deleteBtnPressed:(UIButton *)sender{
    if (self.userWantDeleteImageBlock) {
        self.userWantDeleteImageBlock(self.tag,0);
    }
}

- (void)hiddenDeleteBtnWith:(BOOL)state{
    self.delete.hidden = state;
}

- (void)setImageContent:(id)imageContent{
    _imageContent = imageContent;
    if (_imageContent) {
        if ([_imageContent isKindOfClass:[UIImage class]]) {
            self.image = _imageContent;
        }
        else if ([_imageContent isKindOfClass:[NSString class]]){
            self.image = [UIImage imageNamed:_imageContent];
        }
        else if ([_imageContent isKindOfClass:[NSURL class]]){
            [_imageContent sd_setImageWithURL:_imageContent placeholderImage:PLACEHOLDERIMAGE];
        }
    }
}

- (void)tapImage:(UITapGestureRecognizer *)sender{
    if (self.userWantDeleteImageBlock) {
        self.userWantDeleteImageBlock(self.tag,1);
    }
}

@end
