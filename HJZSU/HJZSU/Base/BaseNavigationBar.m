//
//  BaseNavigationBar.m
//  HJZSU
//
//  Created by apple on 2019/12/3.
//  Copyright © 2019 apple. All rights reserved.
//

#import "BaseNavigationBar.h"

@implementation BaseNavigationBar

//- (void)layoutSubviews {
//    [super layoutSubviews];
//
//    for (UIView *subview in self.subviews) {
//        if ([NSStringFromClass([subview class]) containsString:@"_UINavigationBarContentView"]) {
//            if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
//                UIEdgeInsets margins = subview.layoutMargins;
//                subview.frame = CGRectMake(-margins.left, -margins.top, margins.left + margins.right + subview.frame.size.width, margins.top + margins.bottom + subview.frame.size.height);
//            } else {
//                subview.layoutMargins = UIEdgeInsetsZero;
//            }
//            break;
//        }
//    }
//}

@end
