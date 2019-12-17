//
//  WeChatTool.h
//  HiFansPub
//
//  Created by toplay on 2017/5/25.
//  Copyright © 2017年 toplay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WXApi.h>
#import <WXApiObject.h>

typedef void (^loginWechatSuccess)(id returnData);
typedef void (^loginWechatFailed)(id returnData);

@interface WeChatTool : NSObject<WXApiDelegate>

typedef NS_ENUM(NSInteger, WXSceneType) {
    
    WXSceneTypeSession  = 0,        /**< 聊天界面    */
    
    WXSceneTypeTimeline = 1,        /**< 朋友圈      */
    
    WXSceneTypeFavorite = 2,        /**< 收藏      */
    
};

/**
 微信分享

 @param imageUrl 分享图片
 @param scene 分享到哪里
 */
+ (void) sendImageContent:(NSString *)imageUrl  scene:(WXSceneType)scene;


/**
 分享到微信

 @param title 标题
 @param description 描述
 @param imgUrl 图片地址
 @param webPage 跳转地址
 @param scene 分享类型
 */
+ (void) shareToWechatWith:(NSString *)title description:(NSString *)description thumImageUrl:(NSString *)imgUrl webPageUrl:(NSString *)webPage scene:(WXSceneType)scene;
/**
 微信三方授权
 */
+ (void) loginWeChat;



/**
 微信支付

 @param order_id 订单号
 */
+ (void)WXPayWithOrder:(NSString *)order_id userCouponId:(NSInteger)couponID;
+ (void)wxPayWithOrderData:(NSDictionary *)orderinfo;

@end
