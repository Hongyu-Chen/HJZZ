//
//  EMUserInfo.h
//  HJZSU
//
//  Created by pro1 on 2019/4/11.
//  Copyright © 2019 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface EMUserInfo : NSObject

/*!
 用户环信ID(环信账号)
 */
+ (NSString *)current_id_user;

/*!
 用户头像的URL
 */
+ (NSString *)current_heading_user;
/*!
 用户昵称
 */
+ (NSString *)current_name_user;
/**
 当前用户信息
 
 @return 用户信息字典
 */
+ (NSDictionary *)currentUserInfo;

/**
 本地保存对方聊天信息
 
 @param userId 环信账号
 @param userName 用户名
 @param avatarURLPath 头像
 */
+ (void)saveToUserInfo:(NSString *)userId name:(NSString *)userName avatarURLPath:(NSString *)avatarURLPath;


/**
 查找本地用户信息
 
 @param userId 环信账号
 @return 信息字典
 */
+ (NSDictionary *)findUserInfoByUserId:(NSString *)userId;

@end

NS_ASSUME_NONNULL_END
