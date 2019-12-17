//
//  AppDelegate+Config.m
//  HJZSU
//
//  Created by apple on 2019/4/9.
//  Copyright © 2019 apple. All rights reserved.
//

#import "AppDelegate+Config.h"

@implementation AppDelegate (Config)
    
+ (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options{
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
        }];
    }
    else if ([[[url.description componentsSeparatedByString:@":"] firstObject] isEqualToString:@"tencent101569534"]){
        [TencentOAuth HandleOpenURL:url];
        return [QQApiInterface handleOpenURL:url delegate:[QQTool shareQQTool]];
    }
    else if ([[[url.description componentsSeparatedByString:@":"] firstObject] isEqualToString:@"wx1adaf129c58fdce9"]){
        WeChatTool *wx = [[WeChatTool alloc]init];
        return [WXApi handleOpenURL:url delegate:wx];
    }
    return YES;
}

@end
