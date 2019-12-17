//
//  QQTool.m
//  HiFansPub
//
//  Created by toplay on 2017/5/25.
//  Copyright © 2017年 toplay. All rights reserved.
//

#import "QQTool.h"

@interface QQTool ()
    
@property (strong,nonatomic) TencentOAuth *tencentOAuth;

@end

@implementation QQTool
+ (id)shareQQTool{
    static QQTool *tool = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tool = [[QQTool alloc] init];
    });
    return tool;
}
    
    
+ (void)shareToWeiboWithImage:(UIImage *)image title:(NSString *)title description:(NSString *)description{
    //未使用
}

/**
 处理来至QQ的响应
 */
- (void)onResp:(QQBaseResp *)resp{
    if ([resp isKindOfClass:[SendMessageToQQResp class]]) {
        if ([resp.result integerValue] == 0) {
            [QMUITips showSucceed:@"分享成功"];
        }
        else{
            if ([resp.errorDescription rangeOfString:@"the user give up the"].location != NSNotFound) {
                [QMUITips showError:@"您已取消分享"];
            }
            else{
                [QMUITips showError:@"分享失败"];
            }
        }
    }
}

/**
 处理来至QQ的请求
 */
- (void)onReq:(QQBaseReq *)req{
    NSLog(@"QQ 的请求%@",NSStringFromClass([req class]));
}

/**
 处理QQ在线状态的回调
 */
- (void)isOnlineResponse:(NSDictionary *)response{
    NSLog(@"QQ 在线状态回调%@",response);
}

/**
 QQ分享
 
 @param imageUrl 分享图片
 @param url 链接地址
 @param title 分享标题
 @param description 描述
 @param type 1QQ好友0qqzone
 */
- (void)shareToQQWithImage:(NSString *)imageUrl
                   webPage:(NSString *)url
                     title:(NSString *)title
               description:(NSString *)description
                  withType:(NSInteger)type{
    
    if (![TencentOAuth iphoneQQInstalled]) {
//        [QMUITips showError:@"请移步App Store下载腾讯QQ客户端"];
        [QMUITips showError:@"分享失败"];
    }else {
        _tencentOAuth = [[TencentOAuth alloc] initWithAppId:QQAPPID andDelegate:self];
        if (imageUrl.length > 0) {
            QQApiNewsObject *newsObj = [QQApiNewsObject objectWithURL:[NSURL URLWithString:url] title:title description:description previewImageURL:[NSURL URLWithString:imageUrl]];
            SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:newsObj];
            if (type == 1) {
                NSLog(@"QQ好友列表分享 - %d",[QQApiInterface sendReq:req]);
            }else if (type == 0){
                NSLog(@"QQ空间分享 - %d",[QQApiInterface SendReqToQZone:req]);
            }
        }
        else{
            NSData *data = [QQTool imageData:[UIImage imageNamed:@"Logo"]];
            QQApiNewsObject *newsObj = [QQApiNewsObject objectWithURL:[NSURL URLWithString:url] title:title description:description previewImageData:data];
            SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:newsObj];
            if (type == 1) {
                NSLog(@"QQ好友列表分享 - %d",[QQApiInterface sendReq:req]);
            }else if (type == 0){
                NSLog(@"QQ空间分享 - %d",[QQApiInterface SendReqToQZone:req]);
            }
        }
        
    }
}

+(NSData *)imageData:(UIImage *)myimage
{
    NSData *data=UIImageJPEGRepresentation(myimage, 1.0);
    
    if (data.length>1024 *1024) {
        if (data.length>10240*1024) {//10M以及以上
            data=UIImageJPEGRepresentation(myimage, 0.1);//压缩之后1M~
        }else if (data.length>5120*1024){//5M~10M
            data=UIImageJPEGRepresentation(myimage, 0.2);//压缩之后1M~2M
        }else if (data.length>2048*1024){//2M~5M
            data=UIImageJPEGRepresentation(myimage, 0.5);//压缩之后1M~2.5M
        }
        //1M~2M不压缩
    }
    return data;
}

- (void)loginWithQQ{
    if ([TencentOAuth iphoneQQInstalled]) {
        _tencentOAuth = [[TencentOAuth alloc] initWithAppId:QQAPPID andDelegate:self];
        NSArray *permissions = [NSArray arrayWithObjects:kOPEN_PERMISSION_GET_INFO, kOPEN_PERMISSION_GET_USER_INFO, kOPEN_PERMISSION_GET_SIMPLE_USER_INFO, nil];
        [_tencentOAuth authorize:permissions];
    }
    else{
        [QMUITips showError:@"请移步App Store下载QQ客户端"];
    }
}


//登录成功：
- (void)tencentDidLogin
{
    if (_tencentOAuth.accessToken.length > 0) {
        // 获取用户信息
        [_tencentOAuth getUserInfo];
    } else {
        [QMUITips showError:@"登录不成功 没有获取accesstoken"];
    }
}

//非网络错误导致登录失败：
- (void)tencentDidNotLogin:(BOOL)cancelled {
    if (cancelled) {
        [QMUITips showError:@"用户取消登录"];
    } else {
        [QMUITips showError:@"登录失败"];
    }
}

// 获取用户信息
- (void)getUserInfoResponse:(APIResponse *)response {
    if (response && response.retCode == URLREQUEST_SUCCEED) {
        NSDictionary *userInfo = [response jsonResponse];
        if ([userInfo[@"ret"] integerValue] != 0) {
            [QMUITips showError:@"用户信息获取失败"];
            return;
        }
        else{
            NSMutableDictionary *tmp = [userInfo mutableCopy];
            [tmp setValue:self.tencentOAuth.openId forKeyPath:@"openId"];
            //创建通知
            NSNotification *notification =[NSNotification notificationWithName:QQ_NOTICE_NAME object:nil userInfo:@{@"returnData":tmp}];
            //通过通知中心发送通知
            [[NSNotificationCenter defaultCenter] postNotification:notification];
        }
    } else {
        NSLog(@"QQ auth fail ,getUserInfoResponse:%d", response.detailRetCode);
    }
}
//没有网络
- (void)tencentDidNotNetWork{
    [QMUITips showError:@"没有网络，请设置网络!"];
}


- (void)requestWithQQSuccess{
    
}
@end
