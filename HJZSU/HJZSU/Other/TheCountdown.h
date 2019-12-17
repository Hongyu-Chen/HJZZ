//
//  TheCountdown.h
//  ModelPage
//
//  Created by pro1 on 2018/10/25.
//  Copyright © 2018 pro1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry.h>

typedef enum{
    TheCountdownLoading = 0,            //网络请求中
    TheCountdownFaild = 1,              //网络请求失败
    TheCountdownSuccess = 2,            //网络请求成功
}TheCountdownState;

typedef enum{
    VitedCodeTypeRegist = 1,            //获取注册验证码
    VitedCodeTypeFoundPassword = 2,     //获取忘记密码验证码
    VitedCodeTypeChangePassword = 3,    //获取修改密码验证码
    VitedCodeTypeBindPhone = 4,         //获取绑定手机验证码
    VitedCodeTypeLogin = 5,             //登录验证码
    VitedCodeTypeWithDrawal = 6,
}VitedCodeType;

typedef NS_ENUM(NSInteger,TheCountdownStyle) {
    TheCountdownStyleLeftRight = 0, //倒计时在左边
    TheCountdownStyleRightLeft,     //倒计时在右边
    TheCountdownStyleOnlyTime,      //只显示倒计时
};

NS_ASSUME_NONNULL_BEGIN

/**
 验证码获取
 */
@interface TheCountdown : UIButton

/**
 开启定时器
 */
- (void)startTheCountDown;

/**
 关闭定时器
 */
- (void)stopTheCountDown;

/**
 从服务器获取验证码
 */
- (void)requestToServiceGetCodeWith:(NSString *)phone codeType:(NSInteger)type;

/**
 用户点击按钮回调
 */
@property (copy,nonatomic) void(^userClickedBtn)(BOOL state);

/**
 当前按钮状态
 */
@property (assign,nonatomic) TheCountdownState btnState;

/**
 获取验证码类型
 */
@property (assign,nonatomic) VitedCodeType codeType;

/**
 按钮当前状态是否会响应点击事件
 */
@property (assign,nonatomic) BOOL btnClicked;

/**
 显示风格
 */
@property (assign,nonatomic) TheCountdownStyle style;

/**
 倒计时字体颜色
 */
@property (strong,nonatomic) UIColor *timeLabColor;

/**
 状态字体颜色
 */
@property (strong,nonatomic) UIColor *stateLabColor;

/**
 菊花颜色
 */
@property (strong,nonatomic) UIColor *loadColor;

/**
 状态字体大小
 */
@property (strong,nonatomic) UIFont *stateFont;

/**
 倒计时字体大小
 */
@property (strong,nonatomic) UIFont *timeFont;


@end

NS_ASSUME_NONNULL_END
