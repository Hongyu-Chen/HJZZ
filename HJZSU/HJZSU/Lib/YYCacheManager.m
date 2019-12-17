//
//  YYCacheManager.m
//  HJZSU
//
//  Created by apple on 2019/3/19.
//  Copyright © 2019 apple. All rights reserved.
//

#import "YYCacheManager.h"

@interface YYCacheManager ()

@property (strong,nonatomic) YYCache *yycache;

@end

@implementation YYCacheManager

static YYCacheManager *manager = nil;
+ (instancetype)shareYYCacheManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[YYCacheManager alloc] init];
    });
    return manager;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
        NSString *docDir = [paths objectAtIndex:0];
        NSLog(@"%@",docDir);
        self.yycache = [[YYCache alloc] initWithPath:docDir];
    }
    return self;
}
- (BOOL)isLogin{
    return [self.yycache containsObjectForKey:LOGIN];
}

- (void)saveDic:(NSDictionary *)info forKey:(NSString *)key{
    [self.yycache setObject:info forKey:key withBlock:^{
        NSLog(@"success");
    } ];
}

- (NSString *)uid{
    if ([self isLogin]) {
        NSDictionary *isLogin = (NSDictionary *)[self.yycache objectForKey:LOGIN];
        NSString *idstr = [NSString stringWithFormat:@"%@",isLogin[@"id"]];
        return IsNullString(idstr) ? @"" : idstr;
    }
    else{
        return @"";
    }
}

- (NSDictionary *)userINfo{
    return (NSDictionary *)[self.yycache objectForKey:LOGIN];
}

- (NSString *)token{
    if ([self isLogin]) {
        NSDictionary *isLogin = (NSDictionary *)[self.yycache objectForKey:LOGIN];
        return IsNullString(isLogin[@"token"]) ? @"" : isLogin[@"token"];
    }
    else{
        return @"";
    }
}

- (void)removeCacheWithKey:(NSString *)key{
    [self.yycache removeObjectForKey:key];
}

- (NSDictionary *)getSaveInfo:(NSString *)key{
    return (NSDictionary *)[self.yycache objectForKey:key];
}

- (BOOL)isAuth{
    NSDictionary *isLogin = (NSDictionary *)[self.yycache objectForKey:LOGIN];
    return [isLogin[@"auth"] integerValue] == 2 ? YES : NO;
}

- (void)uploadUserInfoWith:(NSDictionary *)info{
    NSMutableDictionary *isLogin = [[NSMutableDictionary alloc] initWithDictionary:(NSDictionary *)[self.yycache objectForKey:LOGIN]];
    for (NSString *key in [info allKeys]) {
        [isLogin setObject:info[key] forKey:key];
    }
    [self saveDic:isLogin forKey:LOGIN];
}

- (CGFloat)saleFloat{
    NSDictionary *info = (NSDictionary *)[self.yycache objectForKey:SYSTEMCONFIG];
    if (info) {
        return IsNullString(info[@"point"]) ? 0.0 : [info[@"point"] floatValue]/100;
    }
    else{
        return 0.0;
    }
}

- (CGFloat)pingpaiPrice{
    NSDictionary *info = (NSDictionary *)[self.yycache objectForKey:SYSTEMCONFIG];
    if (info) {
        return IsNullString(info[@"brand_price"]) ? 0.0 : [info[@"brand_price"] floatValue]/100;
    }
    else{
        return 0.0;
    }
}

- (NSInteger)arciveNumer{
    NSDictionary *info = (NSDictionary *)[self.yycache objectForKey:SYSTEMCONFIG];
    if (info) {
        return IsNullString(info[@"brand_num"]) ? 0 : [info[@"brand_num"] integerValue];
    }
    else{
        return 0;
    }
}

- (CGFloat)buesnissNumber{
    NSDictionary *info = (NSDictionary *)[self.yycache objectForKey:SYSTEMCONFIG];
    if (info) {
        return IsNullString(info[@"chain_shop_money"]) ? 0.0 : [info[@"chain_shop_money"] floatValue]/100;
    }
    else{
        return 0.0;
    }
}

- (NSInteger)taskNumer{
    NSDictionary *info = (NSDictionary *)[self.yycache objectForKey:SYSTEMCONFIG];
    if (info) {
        return IsNullString(info[@"chain_shop_task"]) ? 0 : [info[@"chain_shop_task"] integerValue];
    }
    else{
        return 0;
    }
}

- (BOOL)getVoiceStyle{
    NSDictionary *isLogin = (NSDictionary *)[self.yycache objectForKey:VOICETYPE];
    if (isLogin) {
        return [isLogin[@"voice"] integerValue] == 1 ? YES : NO;
    }
    else{
        return NO;
    }
}

@end
