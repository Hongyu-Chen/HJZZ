//
//  EMUserInfo.m
//  HJZSU
//
//  Created by pro1 on 2019/4/11.
//  Copyright © 2019 apple. All rights reserved.
//

#import "EMUserInfo.h"

@implementation EMUserInfo

/*!
 用户ID
 */
+ (NSString *)current_id_user {
    return [NSString stringWithFormat:@"user%@",[[YYCacheManager shareYYCacheManager] getSaveInfo:LOGIN][@"id"]];
}

/*!
 用户头像的URL
 */
+ (NSString *)current_heading_user {
    return [[YYCacheManager shareYYCacheManager] getSaveInfo:LOGIN][@"head"];
}
/*!
 用户昵称
 */
+ (NSString *)current_name_user {
    return [[YYCacheManager shareYYCacheManager] getSaveInfo:LOGIN][@"name"];
}
// 在APP登陆或者获取用户信息的时候，需要保存相关信息
+ (NSDictionary *)currentUserInfo {
    return @{@"from_id_user":[NSString stringWithFormat:@"user%@",[[YYCacheManager shareYYCacheManager] getSaveInfo:LOGIN][@"id"]],
             @"from_name_user":[NSString stringWithFormat:@"%@",[[YYCacheManager shareYYCacheManager] getSaveInfo:LOGIN][@"name"]],
             @"from_heading_user":[NSString stringWithFormat:@"%@",[[YYCacheManager shareYYCacheManager] getSaveInfo:LOGIN][@"head"]]
             };
}

+ (void)saveToUserInfo:(NSString *)userId name:(NSString *)userName avatarURLPath:(NSString *)avatarURLPath {
    NSString *filePatch = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingPathComponent:@"messageList.plist"];
    NSMutableArray *array =[[NSMutableArray alloc] initWithContentsOfFile:filePatch];
    if (!array) {
        array = [NSMutableArray array];
    }
    NSDictionary *toDict = @{@"from_id_user":IsNullString(userId) ? @"" : userId,
                             @"from_name_user":IsNullString(userName) ? @"" : userName,
                             @"from_heading_user":IsNullString(avatarURLPath) ? @"" : avatarURLPath,
                             };
    if (![array containsObject:toDict]) {
        [array addObject:toDict];
        [array writeToFile:filePatch atomically:true];
    }
}

+ (NSDictionary *)findUserInfoByUserId:(NSString *)userId {
    NSString *filePatch = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingPathComponent:@"messageList.plist"];
    NSMutableArray *array =[[NSMutableArray alloc] initWithContentsOfFile:filePatch];
    NSDictionary *tempDict;
    for (NSDictionary *dict in array) {
        if ([dict[@"from_id_user"] isEqualToString:userId]) {
            tempDict = dict;
            break;
        }
    }
    return tempDict;
}


@end
