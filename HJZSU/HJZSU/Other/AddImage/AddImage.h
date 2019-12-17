//
//  AddImage.h
//  HJZSU
//
//  Created by apple on 2019/3/9.
//  Copyright © 2019 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol AddImageDelegate <NSObject>

@optional

- (void)userDeleteIndex:(NSInteger)index;

- (void)userTapImage:(NSInteger)index;

@end


@interface AddImage : UIView


/**
 最多展示的图片
 */
@property (assign,nonatomic) NSInteger maxImage;

/**
 展示区域宽
 */
@property (assign,nonatomic) CGFloat showWidth;

/**
 展示图片大小
 */
@property (assign,nonatomic) CGSize itemSize;

/**
 图片横向间距
 */
@property (assign,nonatomic) CGFloat marginH;

/**
 图片纵向间距
 */
@property (assign,nonatomic) CGFloat marginV;

/**
 是否显示添加按钮 默认YES
 */
@property (assign,nonatomic) BOOL showAddItem;

/**
 添加按钮显示在开始还是结尾 默认NO （开始）
 */
@property (assign,nonatomic) BOOL addItemIndex;

/**
 展示图片数组
 */
@property (assign,nonatomic) NSArray *valueArray;

@property (assign,nonatomic) id<AddImageDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
