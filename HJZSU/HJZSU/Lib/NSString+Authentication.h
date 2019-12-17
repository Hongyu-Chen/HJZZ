//
//  NSString+Authentication.h
//  YiLinMuYan
//
//  Created by apple on 2017/12/8.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Authentication)

/**
 验证手机号码

 @return BOOL
 */
- (BOOL)authenicationIsPhone;

/**
 验证密码

 @return BOOL
 */
- (BOOL)authenicationPassword;

/**
 短息验证码

 @return BOOL
 */
- (BOOL)authenicationMessageCode;


/**
 再次输入密码验证

 @return BOOL
 */
- (BOOL)authenicationAgreenPassword;

/**
 验证纯数字

 @return BOOL
 */
- (BOOL)authenicationOnlyNumber;

/**
 验证身份证

 @return BOOL
 */
- (BOOL)authenicationIdCare;
//判断表情符号
- (BOOL)stringContainsEmoji;
@end
