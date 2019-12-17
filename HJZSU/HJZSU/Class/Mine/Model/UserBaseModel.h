//
//  UserBaseModel.h
//  HJZSU
//
//  Created by apple on 2019/3/31.
//  Copyright © 2019 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserBaseModel : NSObject


@property (assign,nonatomic) NSInteger auth;
@property (strong,nonatomic) NSString *head;
@property (strong,nonatomic) NSString *name;
@property (strong,nonatomic) NSString *phone;
@property (assign,nonatomic) CGFloat money;
@property (strong,nonatomic) NSString *openid_wx;

@end

NS_ASSUME_NONNULL_END
