//
//  NSString+MD5.h
//  VideoData
//
//  Created by pro1 on 2019/3/19.
//  Copyright © 2019 pro1. All rights reserved.
//



NS_ASSUME_NONNULL_BEGIN

@interface NSString (MD5)

/**
 *  md5加密的字符串
 */
- (NSString *)md5Digest;

- (NSDictionary *)dictionaryWithJsonString;

+ (NSString *)returnTimeWith:(NSString *)timeStampString;

+ (NSString *)hoursTimeWith:(NSString *)timeStampString;

+ (NSString *)setTImeWithStartTime:(NSString *)startTIme endTime:(NSString *)endTime;

@end

NS_ASSUME_NONNULL_END
