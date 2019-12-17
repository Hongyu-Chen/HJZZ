//
//  ProjectTool.m
//  HJZSS
//
//  Created by apple on 2019/2/26.
//  Copyright © 2019 apple. All rights reserved.
//

#import "ProjectTool.h"

@implementation ProjectTool

+ (UIViewController *)getCurrentViewController{
    
    UIViewController* currentViewController = [ProjectTool getRootViewController];
    BOOL runLoopFind = YES;
    while (runLoopFind) {
        if (currentViewController.presentedViewController) {
            
            currentViewController = currentViewController.presentedViewController;
        } else if ([currentViewController isKindOfClass:[UINavigationController class]]) {
            
            UINavigationController* navigationController = (UINavigationController* )currentViewController;
            currentViewController = [navigationController.childViewControllers lastObject];
            
        } else if ([currentViewController isKindOfClass:[UITabBarController class]]) {
            
            UITabBarController* tabBarController = (UITabBarController* )currentViewController;
            currentViewController = tabBarController.selectedViewController;
        } else {
            
            NSUInteger childViewControllerCount = currentViewController.childViewControllers.count;
            if (childViewControllerCount > 0) {
                
                currentViewController = currentViewController.childViewControllers.lastObject;
                
                return currentViewController;
            } else {
                
                return currentViewController;
            }
        }
        
    }
    return currentViewController;
}

+ (UIViewController *)getRootViewController{
    
    UIWindow* window = [[[UIApplication sharedApplication] delegate] window];
    NSAssert(window, @"The window is empty");
    return window.rootViewController;
}

+(NSString *)dateConversionTimeStamp:(NSString *)date
{
    NSString *birthdayStr=[NSString stringWithFormat:@"%@",date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy/MM/dd HH:mm"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8]];//解决8小时时间差问题
    NSDate *birthdayDate = [dateFormatter dateFromString:birthdayStr];
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[birthdayDate timeIntervalSince1970]*1000];
    return timeSp;
}

+ (NSString *)dateTimerConversionWithTimeStamp:(NSString *)timeStampString{
    // iOS 生成的时间戳是10位
    NSTimeInterval interval    =[timeStampString doubleValue] / 1000.0;
    NSDate *date               = [NSDate dateWithTimeIntervalSince1970:interval];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy/MM/dd"];
    NSString *dateString       = [formatter stringFromDate: date];
    return dateString;
}

+ (NSString *)dateTimerConversionWithTimeStampNew:(NSString *)timeStampString{
    // iOS 生成的时间戳是10位
    NSTimeInterval interval    =[timeStampString doubleValue] / 1000.0;
    NSDate *date               = [NSDate dateWithTimeIntervalSince1970:interval];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy/MM/dd HH:mm"];
    NSString *dateString       = [formatter stringFromDate: date];
    return dateString;
}

+ (void)fetchImageWithAsset:(PHAsset*)mAsset imageBlock:(void(^)(UIImage *iamge))imageBlock {
    PHImageRequestOptions *phImageRequestOptions = [[PHImageRequestOptions alloc] init];
    phImageRequestOptions.synchronous = YES;
    [[PHImageManager defaultManager] requestImageForAsset:mAsset targetSize:CGSizeMake(300, 300) contentMode:PHImageContentModeDefault options:phImageRequestOptions resultHandler:^(UIImage *resultImage, NSDictionary *info) {
        if ([[info valueForKey:@"PHImageResultIsDegradedKey"]integerValue] == 0){
            if (imageBlock) {
                imageBlock(resultImage);
            }
        }
    }];
}

+ (void)uploadUserMessageCount{
    NSArray *conversations = [[EMClient sharedClient].chatManager getAllConversations];
    NSInteger totalUnreadCount = 0;
    for (EMConversation *conversation in conversations) {
        totalUnreadCount += conversation.unreadMessagesCount;
    }
    AppDelegate *appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    if (appdelegate.rootTabbar) {
        UINavigationController *homeNavi = appdelegate.rootTabbar.childViewControllers[0];
        BaseViewController *home = homeNavi.viewControllers.firstObject;
        UINavigationController *acNavi = appdelegate.rootTabbar.childViewControllers[2];
        BaseViewController *ac = acNavi.viewControllers.firstObject;
        if (totalUnreadCount > 0) {
            [home addReadPoint:totalUnreadCount];
            [ac addReadPoint:totalUnreadCount];
        }
        else{
            [home removeReadPoint];
            [ac removeReadPoint];
        }
    }
}


@end
