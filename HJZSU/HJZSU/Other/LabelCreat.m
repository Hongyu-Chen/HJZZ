//
//  LabelCreat.m
//  HJZSS
//
//  Created by apple on 2019/2/26.
//  Copyright © 2019 apple. All rights reserved.
//

#import "LabelCreat.h"

@implementation LabelCreat

+ (UILabel *)creatLabelWith:(NSString *)text font:(UIFont *)font color:(UIColor *)color textAlignment:(NSTextAlignment)textAlignment{
    UILabel *label = [[UILabel alloc] init];
    label.text = text;
    label.textAlignment = textAlignment;
    label.textColor = color;
    label.font = font;
    return label;
}

@end
