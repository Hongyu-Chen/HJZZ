//
//  UIImage+QRCode.h
//  HJZSS
//
//  Created by apple on 2019/4/22.
//  Copyright © 2019 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreImage/CoreImage.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (QRCode)

+ (UIImage *)createQRCodeWithData:(NSString *)dataString logoImage:(UIImage *)logoImage imageSize:(CGFloat)size;

@end

NS_ASSUME_NONNULL_END
