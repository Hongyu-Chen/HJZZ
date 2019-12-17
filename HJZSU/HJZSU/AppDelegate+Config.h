//
//  AppDelegate+Config.h
//  HJZSU
//
//  Created by apple on 2019/4/9.
//  Copyright © 2019 apple. All rights reserved.
//

#import "AppDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface AppDelegate (Config)
    
+ (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options;

@end

NS_ASSUME_NONNULL_END
