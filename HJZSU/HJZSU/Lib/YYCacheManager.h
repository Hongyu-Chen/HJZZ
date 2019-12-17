//
//  YYCacheManager.h
//  HJZSU
//
//  Created by apple on 2019/3/19.
//  Copyright © 2019 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YYCacheManager : NSObject

+ (instancetype)shareYYCacheManager;

- (BOOL)isLogin;

- (void)saveDic:(NSDictionary *)info forKey:(NSString *)key;

- (NSString *)uid;

- (NSString *)token;

- (void)removeCacheWithKey:(NSString *)key;

- (NSDictionary *)getSaveInfo:(NSString *)key;

- (BOOL)isAuth;

- (void)uploadUserInfoWith:(NSDictionary *)info;

- (CGFloat)saleFloat;

- (CGFloat)pingpaiPrice;

- (NSInteger)arciveNumer;

- (CGFloat)buesnissNumber;

- (NSInteger)taskNumer;

- (BOOL)getVoiceStyle;

- (NSDictionary *)userINfo;


@end

NS_ASSUME_NONNULL_END
