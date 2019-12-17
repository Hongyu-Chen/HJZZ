//
//  NSString+MD5.m
//  VideoData
//
//  Created by pro1 on 2019/3/19.
//  Copyright © 2019 pro1. All rights reserved.
//

#import "NSString+MD5.h"
#import <CommonCrypto/CommonDigest.h>
#include <CommonCrypto/CommonHMAC.h>

@implementation NSString (MD5)

- (NSString *)md5Digest{
    const char *cStr = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++){
        [hash appendFormat:@"%02x", result[i]];
    }
    return hash;
}

- (NSDictionary *)dictionaryWithJsonString
{
    if (self == nil) {
        return nil;
    }
    NSData *jsonData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    if(error) {
        NSLog(@"json解析失败：%@",error);
        return nil;
    }
    return dic;
}

+ (NSString *)returnTimeWith:(NSString *)timeStampString{
    NSTimeInterval interval    =[timeStampString doubleValue] / 1000.0;
    NSDate *date               = [NSDate dateWithTimeIntervalSince1970:interval];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy/MM/dd"];
    NSString *dateString       = [formatter stringFromDate: date];
    return dateString;
}

+ (NSString *)hoursTimeWith:(NSString *)timeStampString{
    NSTimeInterval interval    =[timeStampString doubleValue] / 1000.0;
    NSDate *date               = [NSDate dateWithTimeIntervalSince1970:interval];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd hh:mm"];
    NSString *dateString       = [formatter stringFromDate: date];
    return dateString;
}

+ (NSString *)setTImeWithStartTime:(NSString *)startTIme endTime:(NSString *)endTime{
    NSString *startTimeStr = [NSString returnTimeWith:startTIme];
    NSString *endTimeStr = [NSString returnTimeWith:endTime];
    return [NSString stringWithFormat:@"%@-%@",startTimeStr,endTimeStr];
}

@end
