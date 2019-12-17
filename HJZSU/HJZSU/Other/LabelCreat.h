//
//  LabelCreat.h
//  HJZSS
//
//  Created by apple on 2019/2/26.
//  Copyright © 2019 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LabelCreat : NSObject

+ (UILabel *)creatLabelWith:(NSString *)text font:(UIFont *)font color:(UIColor *)color textAlignment:(NSTextAlignment)textAlignment;

@end

NS_ASSUME_NONNULL_END
