//
//  SubmitModel.h
//  HJZSU
//
//  Created by apple on 2019/3/11.
//  Copyright © 2019 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VocherModel.h"

@interface SafeModel : NSObject


- (void)uploadModelWith:(NSDictionary *)info;
@property (strong,nonatomic) NSString *name;//安全砝码名称
@property (assign,nonatomic) CGFloat buy_money;//安全砝码价格
@property (assign,nonatomic) CGFloat back_money;//赔偿价格
@property (assign,nonatomic) NSInteger id;//ID
@property (assign,nonatomic) BOOL selected;

@end

@interface PlanModel : NSObject

- (void)uploadModelWith:(NSDictionary *)info;

@property (strong,nonatomic) NSString *planName;//方案名称
@property (assign,nonatomic) NSInteger id;//方案ID
@property (strong,nonatomic) NSString *mission;//方案任务目标
@property (assign,nonatomic) CGFloat price_controller;//主控价格
@property (assign,nonatomic) CGFloat price_supervision;//督导价格
@property (assign,nonatomic) NSInteger supervision_number;//督导数量
@property (strong,nonatomic) NSString *task;
@property (assign,nonatomic) BOOL selected;


@end

@interface TeameModel : NSObject

- (instancetype)initWith:(NSDictionary *)info;

@property (strong,nonatomic) NSString *teameName;//团腿名称
@property (assign,nonatomic) CGFloat source;//团队评分
@property (strong,nonatomic) NSString *imageUrl;//团队封面图
@property (strong,nonatomic) NSString *teameLev;//团队等级
@property (assign,nonatomic) NSInteger teamCount;//团队人数
@property (assign,nonatomic) NSInteger missionCount;//团队执行任务数
@property (assign,nonatomic) NSInteger id;//团队ID


@end


@interface SubmitModel : NSObject

@property (assign,nonatomic) NSInteger activityType;//任务类型
@property (strong,nonatomic) NSString *headPeo;//项目负责人
@property (strong,nonatomic) NSString *phone;//联系方式
@property (strong,nonatomic) NSString *startTime;//启动时间
@property (strong,nonatomic) NSString *loadingTime;//施行时间
@property (strong,nonatomic) NSString *endTime;//完成时间
@property (strong,nonatomic) NSString *requirements;//特殊要求
@property (strong,nonatomic) NSString *location;//地址
@property (strong,nonatomic) TeameModel *team;//选中的团队
@property (strong,nonatomic) NSMutableArray *images;//上传的图片
@property (strong,nonatomic) PlanModel *plan;//需要执行的方案
@property (strong,nonatomic) SafeModel *safe;//安全砝码
@property (assign,nonatomic) CGFloat allMoneny;//所需费用
@property (assign,nonatomic) NSInteger pin_num;
@property (strong,nonatomic) VocherModel *vocherModel;//抵扣券ID


@end



