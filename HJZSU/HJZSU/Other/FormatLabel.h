//
//  FormatLabel.h
//  VideoData
//
//  Created by pro1 on 2019/3/1.
//  Copyright © 2019 pro1. All rights reserved.
//

#import <UIKit/UIKit.h>

//NS_ASSUME_NONNULL_BEGIN

@interface FormatLabel : UILabel

@property (assign,nonatomic) CGFloat lineSpcae;//行间距
@property (assign,nonatomic) CGFloat wordSpace;//字间距
@property (assign,nonatomic) CGFloat firstLineHeadIndent;//首行缩进

/**
 设置高亮

 @param words NSArray
 @param colors NSArray
 @param fonts NSArray
 */
- (void)setHeightLightWords:(NSArray *)words heightLightColors:(NSArray *)colors htightLightFont:(NSArray *)fonts;

/**
 插入图片

 @param image image
 @param index 位置
 @param frame frame
 */
- (void)setImage:(UIImage *)image toIndex:(NSInteger)index imageFrame:(CGRect)frame;

@end

//NS_ASSUME_NONNULL_END
