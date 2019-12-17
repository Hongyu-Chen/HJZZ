//
//  BankModel.h
//  HJZSU
//
//  Created by apple on 2019/3/31.
//  Copyright © 2019 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BankModel : NSObject
/*"id": 1,//主键ID
 "bankName": "招商银行",//银行 名称
 "bankNo": "gzlSOpzW1uoXc1dRqQOVjGrVKIs4pWSi"//银行卡号*/

@property (assign,nonatomic) NSInteger id;
@property (strong,nonatomic) NSString *bankName;
@property (strong,nonatomic) NSString *bankNo;
@end

NS_ASSUME_NONNULL_END
