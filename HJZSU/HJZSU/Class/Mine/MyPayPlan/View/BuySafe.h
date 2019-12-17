//
//  BuySafe.h
//  HJZSU
//
//  Created by apple on 2019/3/31.
//  Copyright © 2019 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BuySafe : NSObject

@property (strong,nonatomic) NSString *address;
@property (strong,nonatomic) NSString *name;
@property (assign,nonatomic) CGFloat back_money;
@property (assign,nonatomic) CGFloat buy_money;
@property (strong,nonatomic) NSString *create_time;
@property (strong,nonatomic) NSString *id;
@property (strong,nonatomic) NSString *images;
@property (strong,nonatomic) NSString *order_no;
@property (assign,nonatomic) NSInteger status;

@end

NS_ASSUME_NONNULL_END
