//
//  SCPhotoCell.h
//  CareView
//
//  Created by pro1 on 2019/3/16.
//  Copyright © 2019 pro1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCPhotoModel.h"
#import <Photos/Photos.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SCPhotoCellDelegate <NSObject>

@optional
- (void)cellDeleteButtonPressed:(SCPhotoModel *)model;

@end

@interface SCPhotoCell : UICollectionViewCell

@property (strong,nonatomic) SCPhotoModel *model;
@property (assign,nonatomic) id<SCPhotoCellDelegate>delegate;

+ (void)fetchImageWithAsset:(PHAsset*)mAsset imageBlock:(void(^)(UIImage *iamge))imageBlock;

@end

NS_ASSUME_NONNULL_END
