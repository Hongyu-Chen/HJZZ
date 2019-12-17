//
//  BaseTabbarVC.m
//  呼叫战神
//
//  Created by apple on 2019/2/25.
//  Copyright © 2019 apple. All rights reserved.
//

#import "BaseTabbarVC.h"
#import "MainTabbar.h"
#import "BaseNavigationVC.h"
#import "HomeViewController.h"
#import "MineViewController.h"
#import "OrderViewController.h"
#import "SubmitViewController.h"
#import "SupervisionVC.h"
#import "SubmitTipView.h"
#import "SubmitViewController.h"
#import "SubmitModel.h"


@interface BaseTabbarVC ()<EMChatManagerDelegate>

@property (strong,nonatomic) MainTabbar *mainTabBar;

@end

@implementation BaseTabbarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setUpAllChildViewController];
    self.mainTabBar = [[MainTabbar alloc] init];
    [self.mainTabBar.plusItem addTarget:self action:@selector(plusAction:) forControlEvents:UIControlEventTouchUpInside];
    [self setValue:self.mainTabBar forKey:@"tabBar"];
    self.tabBar.tintColor = UIColorMake(251, 56, 8);
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:UIColorMake(1, 1, 1)} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:UIColorMake(251, 56, 8)} forState:UIControlStateSelected];
    [[EMClient sharedClient].chatManager addDelegate:self delegateQueue:nil];
}

- (void)plusAction:(UIButton *)sender{
//    NSLog(@"sdfsd");
    [SubmitTipView showSubmitTypeViewUserBlock:^(NSInteger index) {
        if (index != 0) {
            SubmitViewController *submit = [[SubmitViewController alloc] init];
            SubmitModel *model = [[SubmitModel alloc] init];
            model.activityType = index;
            model.pin_num = 10;
            submit.model = model;
            [[ProjectTool getCurrentViewController].navigationController pushViewController:submit animated:YES];
        }
    }];
}

/**
 *  添加所有子控制器
 */
- (void)setUpAllChildViewController{
    // 1.添加第一个控制器
    HomeViewController *oneVC = [[HomeViewController alloc]init];
    [self setUpOneChildViewController:oneVC image:UIImageMake(@"首页-未选中") title:@"首页" selectedImage:UIImageMake(@"首页-选中")];
    
    // 2.添加第2个控制器
    
    SupervisionVC *threeVC = [[SupervisionVC alloc]init];
    [self setUpOneChildViewController:threeVC image:UIImageMake(@"督导-未选中") title:@"督导" selectedImage:UIImageMake(@"督导-选中")];
    
    
    // 3.添加第3个控制器
    OrderViewController *twoVC = [[OrderViewController alloc]init];
    [self setUpOneChildViewController:twoVC image:UIImageMake(@"订单-未选中") title:@"订单" selectedImage:UIImageMake(@"订单-选中")];
    
    // 4.添加第4个控制器
    MineViewController *fourVC = [[MineViewController alloc] init];
    
    [self setUpOneChildViewController:fourVC image:UIImageMake(@"我的-未选中") title:@"我的" selectedImage:UIImageMake(@"我的-选中")];
}
/**
 *  添加一个子控制器的方法
 */
- (void)setUpOneChildViewController:(UIViewController *)viewController image:(UIImage *)image title:(NSString *)title selectedImage:(UIImage *)selectedImage{
    
    BaseNavigationVC *navC = [[BaseNavigationVC alloc]initWithRootViewController:viewController];
    navC.title = title;
    navC.tabBarItem.image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    navC.tabBarItem.selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    [navC.navigationBar setBackgroundImage:[UIImage imageNamed:@"YLMYNAVBG"] forBarMetrics:UIBarMetricsDefault];//navgationBar 背景颜色
    viewController.title = title;
    [self addChildViewController:navC];
}

- (void)messagesDidReceive:(NSArray *)aMessages{
    id tmpVC = [ProjectTool getCurrentViewController];
    if ([tmpVC isKindOfClass:[MessageListViewController class]]) {
        MessageListViewController *message = (MessageListViewController *)tmpVC;
        [message tableViewDidTriggerHeaderRefresh];
    }
    else{
        UINavigationController *homeNavi = self.childViewControllers[0];
        HomeViewController *home = homeNavi.viewControllers.firstObject;
        [home addReadPoint:aMessages.count];
        
        UINavigationController *acNavi = self.childViewControllers[2];
        OrderViewController *ac = acNavi.viewControllers.firstObject;
        [ac addReadPoint:aMessages.count];
    }
    if (![tmpVC isKindOfClass:[ChatViewController class]]) {
        if ([[YYCacheManager shareYYCacheManager] getVoiceStyle]) {
            [self playsund];
        }
    }
}

- (void)cmdMessagesDidReceive:(NSArray *)aCmdMessages{
    if ([[YYCacheManager shareYYCacheManager] getVoiceStyle]) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"用户单播放" ofType:@"mp3"];
        //播放音效
        SystemSoundID soundID;
        NSURL *filePath = [NSURL fileURLWithPath:path isDirectory:NO];
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)filePath, &soundID);
        AudioServicesPlaySystemSound(soundID);
    }
}

- (void)playsund{
    //name是音频文件的名称
    SystemSoundID soundID = 1000;
    AudioServicesPlaySystemSound(soundID);
}


@end
