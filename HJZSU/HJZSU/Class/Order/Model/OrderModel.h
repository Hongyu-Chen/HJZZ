//
//  OrderModel.h
//  HJZSU
//
//  Created by apple on 2019/3/28.
//  Copyright © 2019 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserOderCommModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface OrderModel : NSObject

@property (strong,nonatomic) NSString *address;
@property (strong,nonatomic) NSString *create_time;
@property (strong,nonatomic) NSString *images;
@property (strong,nonatomic) NSString *id;
@property (strong,nonatomic) NSString *name;
@property (strong,nonatomic) NSString *typeName;
@property (strong,nonatomic) NSString *order_no;
@property (assign,nonatomic) CGFloat score;
@property (assign,nonatomic) NSInteger status;
@property (strong,nonatomic) NSString *teamId;


@end

@interface OrderModelInfo : NSObject
/*
 activityType = 1;
 address = "\U60a8\U4f60\U54e6";
 "branch_num" = 12;
 comment = "\U7d27\U5bc6\U578b\U54e6";
 "contact_name" = "\U6210\U529f\U871c\U8bed";
 "contact_phone" = 13688346838;
 "create_time" = 1554990059000;
 "down_time" = 1554940800000;
 "end_time" = 1554940800000;
 images = "https://hjzsmy.oss-cn-shanghai.aliyuncs.com/activity/1554990057709335232019-04-1113%3A40%3A57%2B000067%2Cjpg.jpg;";
 "is_success" = 1;
 iscomment = 1;
 money = 100;
 "order_no" = 20190411949864251;
 packageId = 10;
 packageName = "\U5957\U99102";
 "start_time" = 1554940800000;
 status = 4;
 task = 1;
 "task_money" = 100;
 teamHead = "https://hjzsmy.oss-cn-shanghai.aliyuncs.com/user/1554989488702307382019-04-1113%3A31%3A26%2B0000469%2Cjpg.jpg";
 teamId = 26;
 teamName = "\U6211\U7684\U65b0\U53f7";
 teamPhone = 13688346838;
 */

@property (strong,nonatomic) NSString *activityType;
@property (strong,nonatomic) NSString *address;
@property (strong,nonatomic) NSString *comment;
@property (strong,nonatomic) NSString *contact_name;
@property (strong,nonatomic) NSString *contact_phone;
@property (strong,nonatomic) NSString *create_time;
@property (strong,nonatomic) NSString *down_time;
@property (strong,nonatomic) NSString *end_time;
@property (strong,nonatomic) NSString *images;
@property (assign,nonatomic) BOOL is_success;
@property (assign,nonatomic) CGFloat money;
@property (strong,nonatomic) NSString *order_no;
@property (strong,nonatomic) NSString *start_time;
@property (assign,nonatomic) NSInteger status;
@property (assign,nonatomic) NSInteger iscomment;
@property (strong,nonatomic) NSString *packageId;
@property (strong,nonatomic) NSString *packageName;
@property (assign,nonatomic) NSInteger branch_num;
@property (strong,nonatomic) NSString *task;
@property (assign,nonatomic) CGFloat task_money;
@property (strong,nonatomic) NSString *teamId;
@property (strong,nonatomic) NSString *teamLogo;
@property (strong,nonatomic) NSString *teamHead;
@property (strong,nonatomic) NSString *teamName;
@property (strong,nonatomic) NSString *teamPhone;
@property (assign,nonatomic) CGFloat weightsBackMoney;
@property (assign,nonatomic) CGFloat weightsBuyMoney;
@property (strong,nonatomic) NSString *weightsId;
@property (strong,nonatomic) NSString *weightsName;
@property (assign,nonatomic) NSInteger finishData;
@property (strong,nonatomic) UserOderCommModel *serverComment;
@property (assign,nonatomic) CGFloat couponMoney;
@property (assign,nonatomic) NSInteger couponId;



@end

NS_ASSUME_NONNULL_END
