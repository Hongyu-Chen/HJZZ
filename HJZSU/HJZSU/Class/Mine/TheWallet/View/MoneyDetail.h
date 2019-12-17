//
//  MoneyDetail.h
//  HJZSU
//
//  Created by apple on 2019/3/31.
//  Copyright © 2019 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MoneyDetail : NSObject

/*create_time": 1551146934000, //时间
 "money": 100,//金额 单位分
 "type": 1// 0-充值  1-提现 2-提成  3-发布活动 4-购买砝码  5-退款 */

@property (strong,nonatomic) NSString *create_time;
@property (assign,nonatomic) CGFloat money;
@property (assign,nonatomic) NSInteger type;

@end

NS_ASSUME_NONNULL_END
