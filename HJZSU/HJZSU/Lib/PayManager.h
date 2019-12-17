//
//  PayManager.h
//  HJZSU
//
//  Created by apple on 2019/3/31.
//  Copyright © 2019 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PayManager : NSObject

//生成支付宝单例类
+(id)sharePayManager;


//支付宝支付
//aParam 后端返回支付信息
-(void)handleOrderPayWithParams:(NSDictionary *)aParam;

@end

NS_ASSUME_NONNULL_END
