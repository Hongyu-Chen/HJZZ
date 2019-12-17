//
//  AppDelegate.m
//  HJZSU
//
//  Created by apple on 2019/2/25.
//  Copyright © 2019 apple. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+Config.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [BANetManager sharedBANetManager].isOpenLog = YES;
    [AMapServices sharedServices].apiKey = @"f2842ff82a1e90123bed96cde1b525b1";
    EMOptions *options = [EMOptions optionsWithAppkey:@"1122190301222075#hjzs"];
    options.apnsCertName = @"istore_dev";
    [[EMClient sharedClient] initializeSDKWithOptions:options];
    [self changedRootController];
    [WXApi registerApp:WECHATAPPID];
    [self getSystemConfigsuccess:^(id  _Nonnull result) {
        [[YYCacheManager shareYYCacheManager] saveDic:result forKey:SYSTEMCONFIG];//invite_user
    } failed:^(NSString * _Nonnull reson) {
        
    }];
    return YES;
}

- (void)changedRootController{
    if ([[YYCacheManager shareYYCacheManager] isLogin]) {
        self.rootTabbar = [[BaseTabbarVC alloc] init];
        self.window.rootViewController = self.rootTabbar;
        NSLog(@"%@",[[YYCacheManager shareYYCacheManager] getSaveInfo:LOGIN]);
        [BANetManager sharedBANetManager].httpHeaderFieldDictionary = @{@"uid":[[YYCacheManager shareYYCacheManager] uid],@"token":[[YYCacheManager shareYYCacheManager] token]};
        [[EMClient sharedClient] loginWithUsername:[NSString stringWithFormat:@"user%@",[[YYCacheManager shareYYCacheManager] getSaveInfo:LOGIN][@"id"]]
                                          password:[NSString stringWithFormat:@"user%@",[[YYCacheManager shareYYCacheManager] getSaveInfo:LOGIN][@"id"]]
                                        completion:^(NSString *aUsername, EMError *aError) {
                                            if (!aError) {
                                                NSLog(@"登录成功");
                                                [ProjectTool uploadUserMessageCount];
                                            } else {
                                                NSLog(@"登录失败");
                                            }
                                        }];
    }
    else{
        self.window.rootViewController = [[BaseNavigationVC alloc] initWithRootViewController:[[LoginViewController alloc] init]];
//        UIViewController *viewcontroller = [[UIViewController alloc] init];
//        viewcontroller.view.backgroundColor = [UIColor redColor];
//        self.window.rootViewController = viewcontroller;
        NSMutableDictionary *info = [[NSMutableDictionary alloc] init];
        [info setObject:@"1" forKey:@"voice"];
        [[YYCacheManager shareYYCacheManager] saveDic:info forKey:VOICETYPE];
    }
}

// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
//    if ([url.host isEqualToString:@"safepay"]) {
//        //跳转支付宝钱包进行支付，处理支付结果
//        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
//            NSLog(@"result = %@",resultDic);
//        }];
//    }
//    else if ([[[url.description componentsSeparatedByString:@":"] firstObject] isEqualToString:@"tencent101452920"]){
//
//        QQTool * qq = [[QQTool alloc]init];
//        [TencentOAuth HandleOpenURL:url];
//        return [QQApiInterface handleOpenURL:url delegate:qq];
//    }
//    else if ([[[url.description componentsSeparatedByString:@":"] firstObject] isEqualToString:@"wx5f8ad1c20381302d"]){
//        WeChatTool *wx = [[WeChatTool alloc]init];
//        return [WXApi handleOpenURL:url delegate:wx];
//    }
    return [AppDelegate application:app openURL:url options:options];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    [[EMClient sharedClient] applicationDidEnterBackground:application];
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    [[EMClient sharedClient] applicationWillEnterForeground:application];
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
