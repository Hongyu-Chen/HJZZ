//
//  SCPhotoView.h
//  CareView
//
//  Created by pro1 on 2019/3/16.
//  Copyright © 2019 pro1. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,SCPhotoViewStyle) {
    SCPhotoViewStyleShow = 0,
    SCPhotoViewStyleAddInFirst,
    SCPhotoViewStyleAddInLast,
};


@protocol SCPhotoViewDelegate <NSObject>

@optional
- (void)userPressedAddImage;
- (void)userDeleteItem:(NSInteger)index;

@end


NS_ASSUME_NONNULL_BEGIN

@interface SCPhotoView : UIView


/**
 初始化(建议使用该方法初始化)

 @param style SCPhotoViewStyle
 @return self
 */
- (instancetype)initWithSCPhotoViewStyle:(SCPhotoViewStyle)style;

/**
 item大小
 */
@property (assign,nonatomic) CGSize itemSize;

/**
 item 之间的间距 默认10
 */
@property (assign,nonatomic) CGFloat itemMargin;

/**
 展示风格
 */
@property (assign,nonatomic) SCPhotoViewStyle style;

/**
 整个内容展示宽 (用于计算整个试图的高度)
 */
@property (assign,nonatomic) CGFloat contentWidth;

/**
 数据源
 */
@property (strong,nonatomic) NSMutableArray *photos;

/**
 点击删除按钮代理
 */
@property (assign,nonatomic) id<SCPhotoViewDelegate>delegate;

/**
 点击item是否展示预览图
 */
@property (assign,nonatomic) BOOL showPreviewPicture;

/**
 是否显示删除按钮
 */
@property (assign,nonatomic) BOOL showDelete;

/**
 删除按钮图片
 */
@property (strong,nonatomic) id deleteBtnValue;

/**
 添加按钮图片
 */
@property (strong,nonatomic) id addItemValue;

@end

NS_ASSUME_NONNULL_END
