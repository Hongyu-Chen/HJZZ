//
//  WeChatTool.m
//  HiFansPub
//
//  Created by toplay on 2017/5/25.
//  Copyright © 2017年 toplay. All rights reserved.
//

#import "WeChatTool.h"

#define WX_BASE_URL @"https://api.weixin.qq.com/sns"

@implementation WeChatTool

/*! 微信回调，不管是登录还是分享成功与否，都是走这个方法 @brief 发送一个sendReq后，收到微信的回应
 *
 * 收到一个来自微信的处理结果。调用一次sendReq后会收到onResp。
 * 可能收到的处理结果有SendMessageToWXResp、SendAuthResp等。
 * @param resp 具体的回应内容，是自动释放的
 */
-(void) onResp:(BaseResp*)resp{
    NSLog(@"resp %d",resp.errCode);
    
    /*
     enum  WXErrCode {
     WXSuccess           = 0,    成功
     WXErrCodeCommon     = -1,  普通错误类型
     WXErrCodeUserCancel = -2,    用户点击取消并返回
     WXErrCodeSentFail   = -3,   发送失败
     WXErrCodeAuthDeny   = -4,    授权失败
     WXErrCodeUnsupport  = -5,   微信不支持
     };
     */
    if ([resp isKindOfClass:[SendAuthResp class]]) {   //授权登录的类。
        if (resp.errCode == 0) {  //成功。
            SendAuthResp *resp2 = (SendAuthResp *)resp;
            
            NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
            AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:configuration];
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            
            NSString *accessUrlStr = [NSString stringWithFormat:@"%@/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code", WX_BASE_URL,WECHATAPPID, WECHATSECRTY, resp2.code];

            [manager GET:accessUrlStr parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
                ;
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
                if ([dic[@"errcode"] integerValue] != 0) {
                    [QMUITips showError:dic[@"errmsg"]];
                    return;
                }

#pragma mark - <不获取用户信息>
//                NSNotification *notification =[NSNotification notificationWithName:WX_NOTICE_NAME object:nil userInfo:@{@"returnData":dic}];
//                [[NSNotificationCenter defaultCenter] postNotification:notification];
#pragma mark - <获取用户信息>
                [WeChatTool wechatLoginByRequestForUserInfo:dic];

            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"获取access_token时出错 = %@", error);
                
            }];
        }else{ //失败
            NSLog(@"error %@",resp.errStr);
            [QMUITips showError:[NSString stringWithFormat:@"登录失败 reason : %@",resp.errStr]];
        }
    }
    else if ([resp isKindOfClass:[SendMessageToWXResp class]]){
        if (resp.errCode == 0) {
            [QMUITips showSucceed:@"分享成功"];
        }
        else if (resp.errCode == -2){
            [QMUITips showError:@"您已取消分享"];
        }
        else{
            [QMUITips showError:@"分享失败"];
        }
    }
    else if ([resp isKindOfClass:[PayResp class]]){
        //支付返回结果，实际支付结果需要去微信服务器端查询
        NSString *payResoult;
        switch (resp.errCode) {
            case 0:
            {
                payResoult = @"支付结果成功";
                //创建通知
                NSNotification *notification =[NSNotification notificationWithName:WX_PAY_STATE object:nil userInfo:nil];
                //通过通知中心发送通知
                [[NSNotificationCenter defaultCenter] postNotification:notification];
            }
                break;
            case -1:
                payResoult = @"支付结果：失败！";
                [QMUITips showError:payResoult];
                break;
            case -2:
                payResoult = @"用户已经退出支付！";
                [QMUITips showError:payResoult];
                break;
            default:
                payResoult = [NSString stringWithFormat:@"支付结果：失败！retcode = %d, retstr = %@", resp.errCode,resp.errStr];
                [QMUITips showError:payResoult];
                break;
        }
        
        
        NSLog(@"%@",payResoult);
    }
    else{
        NSLog(@"%@",NSStringFromClass([resp class]));
    }
}


+ (void)wechatLoginByRequestForUserInfo:(NSDictionary *)acceccInfo{
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:configuration];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];

    __block NSString *accessToken = [acceccInfo objectForKey:@"access_token"];
    __block NSString *openID = [acceccInfo objectForKey:@"openid"];
    NSString *userUrlStr = [NSString stringWithFormat:@"%@/userinfo?access_token=%@&openid=%@", WX_BASE_URL, accessToken, openID];
    // 请求用户数据
    [manager GET:userUrlStr parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        ;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSMutableDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
        [dic setObject:openID forKey:@"openid"];
        //创建通知
        NSNotification *notification =[NSNotification notificationWithName:WX_NOTICE_NAME object:nil userInfo:@{@"returnData":dic}];
        //通过通知中心发送通知
        [[NSNotificationCenter defaultCenter] postNotification:notification];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"获取access_token时出错 = %@", error);
    }];
}

+ (void) loginWeChat{
    if ([WXApi isWXAppInstalled]) {
        SendAuthReq *req = [[SendAuthReq alloc] init];
        req.scope = @"snsapi_userinfo";
        req.state = @"YouyijiaApp";
        [WXApi sendReq:req];
    }
    else {
        [QMUITips showError:@"请移步App Store下载微信客户端"];
    }
}

+ (void) sendImageContent:(NSString *)imageUrl  scene:(WXSceneType)scene{
    if ([WXApi isWXAppInstalled] && [WXApi isWXAppSupportApi]) {
        //message是多媒体分享(链接/网页/图片/音乐各种)
        //text是分享文本,两者只能选其一
        SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
        
        WXMediaMessage *message = [WXMediaMessage message];
        message.title = @"Hi 天气 - 这里是标题";
        message.description = @"不给糖就捣蛋,还不快去下载加好评!";
        [message setThumbImage:[UIImage imageNamed:@"这里是缩略图"]];
        req.message = message;
        
        WXAppExtendObject *ext = [WXAppExtendObject object];
        ext.url = @"https://itunes.apple.com/us/app/hi-tian-qi/id1146330042?mt=8";
        ext.extInfo = @"Hi 天气";
        message.mediaObject = ext;
        //默认是Session分享给朋友,Timeline是朋友圈,Favorite是收藏
        req.scene = scene;
        [WXApi sendReq:req];
    } else {
        [QMUITips showError:@"请移步App Store去下载微信客户端"];
    }
}

/**
 分享到微信
 
 @param title 标题
 @param description 描述
 @param imgUrl 图片地址
 @param webPage 跳转地址
 @param scene 分享类型
 */
+ (void) shareToWechatWith:(NSString *)title description:(NSString *)description thumImageUrl:(NSString *)imgUrl webPageUrl:(NSString *)webPage scene:(WXSceneType)scene{
    if ([WXApi isWXAppInstalled] && [WXApi isWXAppSupportApi]) {
        UIImage *cachedImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:[SETURLWITHUSERSTRING(imgUrl) absoluteString]];
        NSLog(@" share to weixin Image Url %@",imgUrl);
        //创建发送对象实例
        SendMessageToWXReq *sendReq = [[SendMessageToWXReq alloc] init];
        sendReq.bText = NO;//不使用文本信息
        sendReq.scene = scene;
        //创建分享内容对象
        WXMediaMessage *urlMessage = [WXMediaMessage message];
        urlMessage.title = title;//分享标题
        urlMessage.description = description;//分享描述
        [urlMessage setThumbImage:cachedImage ? cachedImage : [UIImage imageNamed:@"Logo"]];//分享图片,使用SDK的setThumbImage方法可压缩图片大小
        //创建多媒体对象
        WXWebpageObject *webObj = [WXWebpageObject object];
        webObj.webpageUrl = webPage;//分享链接
        //完成发送对象实例
        urlMessage.mediaObject = webObj;
        sendReq.message = urlMessage;
        //发送分享信息
        [WXApi sendReq:sendReq];
    }
    else{
//        [QMUITips showError:@"请移步App Store下载微信客户端"];
        [QMUITips showError:@"分享失败"];
    }
}

#pragma mark 微信支付方法
/**
 微信支付
 
 @param order_id 订单号
 */
+ (void)WXPayWithOrder:(NSString *)order_id userCouponId:(NSInteger)couponID {
    if ([WXApi isWXAppInstalled] && [WXApi isWXAppSupportApi]) {
        [self getPayWith:order_id payType:1 userCouponId:couponID success:^(id  _Nonnull result) {
            PayReq *req   = [[PayReq alloc] init];
            //由用户微信号和AppID组成的唯一标识，用于校验微信用户
            req.openID = result[@"appid"];
            // 商家id，在注册的时候给的
            req.partnerId = result[@"mch_id"];
            // 预支付订单这个是后台跟微信服务器交互后，微信服务器传给你们服务器的，你们服务器再传给你
            req.prepayId  = result[@"prepay_id"];
            // 根据财付通文档填写的数据和签名
            //这个比较特殊，是固定的，只能是即req.package = Sign=WXPay
            req.package = @"Sign=WXPay";
            // 随机编码，为了防止重复的，在后台生成
            req.nonceStr  = result[@"nonce_str"];
            // 这个是时间戳，也是在后台生成的，为了验证支付的
            NSString * stamp = result[@"timestamp"];
            req.timeStamp = stamp.intValue;
            // 这个签名也是后台做的
            req.sign = result[@"sign"];
            [WXApi sendReq:req];
        } failed:^(NSString * _Nonnull reson) {
            [QMUITips showWithText:reson];
        }];
    }
    else{
        [QMUITips showError:@"请移步App Store下载微信客户端"];
    }
}

+ (void)wxPayWithOrderData:(NSDictionary *)orderinfo{
    
    if ([WXApi isWXAppInstalled] && [WXApi isWXAppSupportApi]) {
        //需要创建这个支付对象
        PayReq *req   = [[PayReq alloc] init];
        //由用户微信号和AppID组成的唯一标识，用于校验微信用户
        req.openID = orderinfo[@"appid"];
        // 商家id，在注册的时候给的
        req.partnerId = orderinfo[@"mch_id"];
        // 预支付订单这个是后台跟微信服务器交互后，微信服务器传给你们服务器的，你们服务器再传给你
        req.prepayId  = orderinfo[@"prepay_id"];
        // 根据财付通文档填写的数据和签名
        //这个比较特殊，是固定的，只能是即req.package = Sign=WXPay
        req.package = @"Sign=WXPay";
        // 随机编码，为了防止重复的，在后台生成
        req.nonceStr  = orderinfo[@"nonce_str"];
        // 这个是时间戳，也是在后台生成的，为了验证支付的
        NSString * stamp = orderinfo[@"timestamp"];
        req.timeStamp = stamp.intValue;
        // 这个签名也是后台做的
        req.sign = orderinfo[@"sign"];
        [WXApi sendReq:req];
        //发送请求到微信，等待微信返回onResp
    }
    else{
        [QMUITips showError:@"请移步App Store下载微信客户端"];
    }
    
}

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err)
    {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

@end
