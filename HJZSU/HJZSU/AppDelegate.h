//
//  AppDelegate.h
//  HJZSU
//
//  Created by apple on 2019/2/25.
//  Copyright © 2019 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Base/BaseTabbarVC.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong,nonatomic) BaseTabbarVC *rootTabbar;

- (void)changedRootController;


@end

