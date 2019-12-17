//
//  SceneDelegate.h
//  SS_Video
//
//  Created by mac on 2019/10/18.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Base/BaseTabbarVC.h"

@interface SceneDelegate : UIResponder <UIWindowSceneDelegate>

@property (strong, nonatomic) UIWindow * window;

@property (strong, nonatomic) BaseTabbarVC *rootTabbar;

@end

