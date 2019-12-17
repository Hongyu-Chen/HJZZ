//
//  PayManager.m
//  HJZSU
//
//  Created by apple on 2019/3/31.
//  Copyright © 2019 apple. All rights reserved.
//

#import "PayManager.h"

@implementation PayManager

+(id)sharePayManager
{
    static PayManager *asAlixPay = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        asAlixPay = [[PayManager alloc] init];
    });
    return asAlixPay;
}
/**
 *  支付宝支付
 */
-(void)handleOrderPayWithParams:(NSDictionary *)aParam
{
    NSLog(@"aParm = %@",aParam);
    NSString *appScheme = @"HJZSU";
    NSString *orderString = aParam[@"payInfo"];
    // NOTE: 调用支付结果开始支付
    [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
        NSLog(@"reslut = %@",resultDic);
        int statusCode = [resultDic[@"resultStatus"]  intValue];
        if (statusCode == 10000)
        {
            //订单支付
            [QMUITips showSucceed:@"支付成功"];
            [[NSNotificationCenter defaultCenter] postNotificationName:AL_IPAY_STATE object:nil];
        }
        else
        {
            //交易失败
            // [[NSNotificationCenter defaultCenter] postNotificationName:@"PAY_STATUS" object:@"0"];
            [QMUITips showError:@"支付异常"];
        }
    }];
}

@end
