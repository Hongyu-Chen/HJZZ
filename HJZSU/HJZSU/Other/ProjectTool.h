//
//  ProjectTool.h
//  HJZSS
//
//  Created by apple on 2019/2/26.
//  Copyright © 2019 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProjectTool : NSObject

+ (UIViewController *)getCurrentViewController;

+(NSString *)dateConversionTimeStamp:(NSString *)date;

+ (NSString *)dateTimerConversionWithTimeStamp:(NSString *)timeStampString;
+ (NSString *)dateTimerConversionWithTimeStampNew:(NSString *)timeStampString;
+ (void)fetchImageWithAsset:(PHAsset*)mAsset imageBlock:(void(^)(UIImage *iamge))imageBlock;
+ (void)uploadUserMessageCount;

@end

NS_ASSUME_NONNULL_END
