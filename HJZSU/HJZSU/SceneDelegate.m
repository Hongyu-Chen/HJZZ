#import "SceneDelegate.h"

@interface SceneDelegate ()

@end

@implementation SceneDelegate


- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions  API_AVAILABLE(ios(13.0)) API_AVAILABLE(ios(13.0)){
    // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
    // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
    // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
    
//    [[YYCacheManager shareYYCacheManager] firs]
    
    UIWindowScene *windowScene = (UIWindowScene *)scene;
    self.window = [[UIWindow alloc] initWithWindowScene:windowScene];
    [self changedRootController];
    [self.window makeKeyAndVisible];
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
//        self.window.rootViewController = [[LoginViewController alloc] init];
        NSMutableDictionary *info = [[NSMutableDictionary alloc] init];
        [info setObject:@"1" forKey:@"voice"];
        [[YYCacheManager shareYYCacheManager] saveDic:info forKey:VOICETYPE];
    }
}


- (void)sceneDidDisconnect:(UIScene *)scene  API_AVAILABLE(ios(13.0)){
    // Called as the scene is being released by the system.
    // This occurs shortly after the scene enters the background, or when its session is discarded.
    // Release any resources associated with this scene that can be re-created the next time the scene connects.
    // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
}


- (void)sceneDidBecomeActive:(UIScene *)scene  API_AVAILABLE(ios(13.0)){
    // Called when the scene has moved from an inactive state to an active state.
    // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
}


- (void)sceneWillResignActive:(UIScene *)scene  API_AVAILABLE(ios(13.0)){
    // Called when the scene will move from an active state to an inactive state.
    // This may occur due to temporary interruptions (ex. an incoming phone call).
}


- (void)sceneWillEnterForeground:(UIScene *)scene  API_AVAILABLE(ios(13.0)){
    // Called as the scene transitions from the background to the foreground.
    // Use this method to undo the changes made on entering the background.
}


- (void)sceneDidEnterBackground:(UIScene *)scene  API_AVAILABLE(ios(13.0)){
    // Called as the scene transitions from the foreground to the background.
    // Use this method to save data, release shared resources, and store enough scene-specific state information
    // to restore the scene back to its current state.
}


@end
