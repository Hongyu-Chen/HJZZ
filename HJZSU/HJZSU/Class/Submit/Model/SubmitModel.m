//
//  SubmitModel.m
//  HJZSU
//
//  Created by apple on 2019/3/11.
//  Copyright © 2019 apple. All rights reserved.
//

#import "SubmitModel.h"

@implementation SafeModel

- (void)uploadModelWith:(NSDictionary *)info{
    self.id = [info[@"id"] integerValue];
    self.back_money = [info[@"back_money"] floatValue]/100;
    self.buy_money = [info[@"buy_money"] floatValue]/100;
    self.name = info[@"name"];
}

@end

@implementation PlanModel

- (instancetype)init{
    self = [super init];
    if (self) {
        self.supervision_number = 1.0;
        self.price_supervision = 0.0;
        self.price_controller = 0.0;
    }
    return self;
}

- (void)uploadModelWith:(NSDictionary *)info{
    /*
     @property (strong,nonatomic) NSString *planName;//方案名称
     @property (assign,nonatomic) NSInteger id;//方案ID
     @property (strong,nonatomic) NSString *mission;//方案任务目标
     @property (assign,nonatomic) CGFloat price_controller;//主控价格
     @property (assign,nonatomic) CGFloat price_supervision;//督导价格
     @property (assign,nonatomic) NSInteger supervision_number;//督导数量
     
     "branch": 200,//督导价格 单位分
     "fail": 5000,//失败赔偿金额
     "master": 1000,//主控价格
     "name": "套餐A",//名称
     "task": "10000"//任务量
     */
    
    self.planName = info[@"name"];
    self.id = [info[@"id"] integerValue];
    self.mission = [NSString stringWithFormat:@"任务:金额达到%.0f",[info[@"task"] floatValue]/100];
    self.price_controller = [info[@"master"] floatValue]/100;
    self.price_supervision = [info[@"branch"] floatValue]/100;
    self.task = info[@"task"];
    
    
}



@end

@implementation TeameModel

- (instancetype)initWith:(NSDictionary *)info{
    self = [super init];
    if (self) {
        /*@property (strong,nonatomic) NSString *teameName;//团腿名称
         @property (assign,nonatomic) CGFloat source;//团队评分
         @property (strong,nonatomic) NSString *imageUrl;//团队封面图
         @property (strong,nonatomic) NSString *teameLev;//团队等级
         @property (assign,nonatomic) NSInteger teamCount;//团队人数
         @property (assign,nonatomic) NSInteger missionCount;//团队执行任务数
         @property (assign,nonatomic) NSInteger id;//团队ID*/
        self.teameName = info[@"name"];
        self.source = [info[@"num"] floatValue];
        self.imageUrl = info[@"teamLogo"];
        self.teameLev = info[@"interests"];
        self.teamCount = [info[@"members"] integerValue];
        self.missionCount = [info[@"num"] integerValue];
        self.id = [info[@"id"] integerValue];
    }
    return self;
}

@end

@implementation SubmitModel

- (instancetype)init{
    self = [super init];
    if (self) {
        self.images = [[NSMutableArray alloc] init];
    }
    return self;
}

@end

