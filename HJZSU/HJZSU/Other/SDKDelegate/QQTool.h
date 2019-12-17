//
//  QQTool.h
//  HiFansPub
//
//  Created by toplay on 2017/5/25.
//  Copyright © 2017年 toplay. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface QQTool : NSObject<QQApiInterfaceDelegate,TencentSessionDelegate>
    
@property (strong,nonatomic,readonly) TencentOAuth *tencentOAuth;


///**
// 注册QQ
// */
//+ (void)registerQQClient;
/**
 QQ分享

 @param imageUrl 分享图片
 @param url 链接地址
 @param title 分享标题
 @param description 描述
 @param type 1 QQ好友 0 qqzone
 */
- (void)shareToQQWithImage:(NSString *)imageUrl
                   webPage:(NSString *)url
                     title:(NSString *)title
               description:(NSString *)description
                  withType:(NSInteger)type;

- (void)loginWithQQ;
    
+ (id)shareQQTool;

@end
