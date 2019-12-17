//
//  SCPhotoCell.m
//  CareView
//
//  Created by pro1 on 2019/3/16.
//  Copyright © 2019 pro1. All rights reserved.
//

#import "SCPhotoCell.h"
#import <Masonry/Masonry.h>
#import "UIImageView+WebCache.h"

@interface SCPhotoCell ()

@property (strong,nonatomic) UIButton *deleteBtn;
@property (strong,nonatomic) UIImageView *imageView;

@end

@implementation SCPhotoCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 5;
        self.clipsToBounds = YES;
        self.layer.borderColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0].CGColor;
        self.layer.borderWidth = 1.0;
        [self addSubview:self.imageView];
        [self addSubview:self.deleteBtn];
        
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.bottom.equalTo(self).offset(0);
        }];
        [_deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.equalTo(self).offset(0);
            make.width.height.offset(40);
        }];
    }
    return self;
}

- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _imageView;
}

- (UIButton *)deleteBtn{
    if (!_deleteBtn) {
        _deleteBtn = [[UIButton alloc] init];
        _deleteBtn.imageEdgeInsets = UIEdgeInsetsMake(5, 15, 15, 5);
        _deleteBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [_deleteBtn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteBtn;
}

- (void)setModel:(SCPhotoModel *)model{
    _model = model;
    if (_model) {
        if ([_model.imageContent isKindOfClass:[NSString class]]) {
            _imageView.image = [UIImage imageNamed:_model.imageContent];
        }
        else if ([_model.imageContent isKindOfClass:[UIImage class]]){
            _imageView.image = _model.imageContent;
        }
        else if ([_model.imageContent isKindOfClass:[NSURL class]]){
            [_imageView sd_setImageWithURL:_model.imageContent placeholderImage:PLACEHOLDERIMAGE];
        }
        else if ([_model.imageContent isKindOfClass:[PHAsset class]]){
            _imageView.image = nil;
            __weak typeof(self) weakself = self;
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                [SCPhotoCell fetchImageWithAsset:weakself.model.imageContent imageBlock:^(UIImage *iamge) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        weakself.imageView.image = iamge;
                    });
                }];
            });
        }
        
        switch (_model.style) {
            case SCPhtoCellStyleShow:
            {
                _deleteBtn.hidden = YES;
            }
                break;
            case SCPhtoCellStyleShowAddDelete:
            {
                _deleteBtn.hidden = NO;
                [_deleteBtn setImage:[UIImage imageNamed:_model.deleteContent] forState:UIControlStateNormal];
            }
                break;
            case SCPhtoCellStyleAdd:
            {
                _deleteBtn.hidden = YES;
            }
                break;
                
            default:
                break;
        }
    }
}

- (void)buttonPressed:(UIButton *)sender{
    [self cellDeleteButtonPressed:self.model];
}

- (void)cellDeleteButtonPressed:(SCPhotoModel *)model{
    if (_delegate) {
        [_delegate cellDeleteButtonPressed:model];
    }
}

/**
 通过资源获取图片的数据
 
 @param mAsset 资源文件
 @param imageBlock 图片数据回传
 */
+ (void)fetchImageWithAsset:(PHAsset*)mAsset imageBlock:(void(^)(UIImage *iamge))imageBlock {
    PHImageRequestOptions *phImageRequestOptions = [[PHImageRequestOptions alloc] init];
    phImageRequestOptions.synchronous = YES;
    [[PHImageManager defaultManager] requestImageForAsset:mAsset targetSize:CGSizeMake(300, 300) contentMode:PHImageContentModeDefault options:phImageRequestOptions resultHandler:^(UIImage *resultImage, NSDictionary *info) {
        if ([[info valueForKey:@"PHImageResultIsDegradedKey"]integerValue] == 0){
            if (imageBlock) {
                NSLog(@"%@",resultImage);
                imageBlock(resultImage);
            }
        }
    }];
}

@end
