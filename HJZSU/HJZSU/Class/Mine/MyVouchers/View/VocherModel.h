//
//  VocherModel.h
//  HJZSU
//
//  Created by apple on 2019/3/31.
//  Copyright © 2019 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface VocherModel : NSObject

@property (strong,nonatomic) NSString *brief;
@property (strong,nonatomic) NSString *end_time;
@property (assign,nonatomic) NSInteger id;
@property (assign,nonatomic) CGFloat worth_money;
@property (assign,nonatomic) NSInteger status;
@property (assign,nonatomic) NSInteger type;
@property (assign,nonatomic) BOOL chooseStatus;

@end

NS_ASSUME_NONNULL_END
