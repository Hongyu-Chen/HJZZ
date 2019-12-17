//
//  BaseNavigationVC.m
//  呼叫战神
//
//  Created by apple on 2019/2/25.
//  Copyright © 2019 apple. All rights reserved.
//

#import "BaseNavigationVC.h"
#import "BaseNavigationBar.h"

@interface BaseNavigationVC ()

@end

@implementation BaseNavigationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.navigationBar = [[BaseNavigationBar alloc] init];
}
- (instancetype)initWithRootViewController:(UIViewController *)rootViewController{
    if (self = [super initWithRootViewController:rootViewController]) {
        self.navigationBar.hidden = YES;
    }
    return self;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}



//- (void)layoutSubviews {
//    [super layoutSubviews];
//
//    for (UIView *subview in self.subviews) {
//        if ([NSStringFromClass([subview class]) containsString:@"_UINavigationBarContentView"]) {
//            subview.layoutMargins = UIEdgeInsetsZero;
//            break;
//        }
//    }
//}

- (void)layoutSubviews {
    
//    [super layoutSubviews];
//    for (UIView *subview in self.navigationBar.subviews) {
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
}

@end
