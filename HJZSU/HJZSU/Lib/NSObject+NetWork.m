//
//  NSObject+NetWork.m
//  VideoData
//
//  Created by pro1 on 2019/3/19.
//  Copyright © 2019 pro1. All rights reserved.
//

#import "NSObject+NetWork.h"
#import <BANetManager/BANetManager.h>
#import <BANetManager/BADataEntity.h>
#import <YYCache/YYCache.h>
#import "NSString+MD5.h"
#import <Photos/Photos.h>


#define BASEURL @"https://api.hjiaozs.com/user"

@implementation NSObject (NetWork)

- (void)userRegisWith:(NSDictionary *)parameters
              success:(void(^)(id result))successBlock
               failed:(void(^)(NSString *reson))failedBlock{
    BADataEntity *data = [[BADataEntity alloc] init];
    data.urlString = [NSString stringWithFormat:@"%@/user/register",BASEURL];
    data.parameters = parameters;
    data.needCache = NO;
    [self projectNetWorkWith:data netWorkType:BAHttpRequestTypePost success:^(id result) {
        successBlock(result);
    } failed:^(NSString *reson) {
        failedBlock(reson);
    }];
}
- (void)userGetMessageCodeWith:(NSString *)phone
                      codeType:(NSInteger)type
                       success:(void(^)(id result))successBlock
                        failed:(void(^)(NSString *reson))failedBlock{
    BADataEntity *data = [[BADataEntity alloc] init];
    data.urlString = [NSString stringWithFormat:@"%@/user/phoneCode",BASEURL];
    data.parameters = @{@"phone":phone,@"type":[NSNumber numberWithInteger:type]};
    data.needCache = NO;
    [self projectNetWorkWith:data netWorkType:BAHttpRequestTypeGet success:^(id result) {
        successBlock(result);
    } failed:^(NSString *reson) {
        failedBlock(reson);
    }];
}

- (void)userLogin:(NSDictionary *)parameters
          success:(void(^)(id result))successBlock
           failed:(void(^)(NSString *reson))failedBlock{
    BADataEntity *data = [[BADataEntity alloc] init];
    data.urlString = [[NSString stringWithFormat:@"%@/user/login",BASEURL] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    data.parameters = parameters;
    data.needCache = NO;
    [self projectNetWorkWith:data netWorkType:BAHttpRequestTypePost success:^(id result) {
        successBlock(result);
    } failed:^(NSString *reson) {
        failedBlock(reson);
    }];
}

- (void)userChangPassword:(NSDictionary *)parameters
                  success:(void(^)(id result))successBlock
                   failed:(void(^)(NSString *reson))failedBlock{
    BADataEntity *data = [[BADataEntity alloc] init];
    data.urlString = [NSString stringWithFormat:@"%@/user/changePassword",BASEURL];
    data.parameters = parameters;
    data.needCache = NO;
    [self projectNetWorkWith:data netWorkType:BAHttpRequestTypePost success:^(id result) {
        successBlock(result);
    } failed:^(NSString *reson) {
        failedBlock(reson);
    }];
}

- (void)getUserInfoSuccess:(void(^)(id result))successBlock
                    failed:(void(^)(NSString *reson))failedBlock{
    BADataEntity *data = [[BADataEntity alloc] init];
    data.urlString = [NSString stringWithFormat:@"%@/person/getProfile",BASEURL];
    data.needCache = NO;
    [self projectNetWorkWith:data netWorkType:BAHttpRequestTypeGet success:^(id result) {
        successBlock([UserBaseModel mj_objectWithKeyValues:result]);
    } failed:^(NSString *reson) {
        failedBlock(reson);
    }];
}

- (void)getHomePageBannerSuccess:(void(^)(id result))successBlock
                          failed:(void(^)(NSString *reson))failedBlock{
    ///system/getBanner
    BADataEntity *data = [[BADataEntity alloc] init];
    data.urlString = [NSString stringWithFormat:@"%@/system/getBanner",BASEURL];
    data.needCache = NO;
    [self projectNetWorkWith:data netWorkType:BAHttpRequestTypeGet success:^(id result) {
        successBlock(result);
    } failed:^(NSString *reson) {
        failedBlock(reson);
    }];
}

- (void)getHomeActiviteListSuccess:(void(^)(id result))successBlock
                            failed:(void(^)(NSString *reson))failedBlock{
    BADataEntity *data = [[BADataEntity alloc] init];
    data.urlString = [NSString stringWithFormat:@"%@/activity/getIndexActivity",BASEURL];
    data.needCache = NO;
    [self projectNetWorkWith:data netWorkType:BAHttpRequestTypeGet success:^(id result) {
        successBlock(result);
    } failed:^(NSString *reson) {
        failedBlock(reson);
    }];
}

- (void)getCityListSuccess:(void(^)(id result))successBlock
                    failed:(void(^)(NSString *reson))failedBlock{
    BADataEntity *data = [[BADataEntity alloc] init];
    data.urlString = [NSString stringWithFormat:@"%@/system/getSystemCity",BASEURL];
    data.needCache = NO;
    data.parameters = @{@"parentId":@"",@"leval":@"0"};
    [self projectNetWorkWith:data netWorkType:BAHttpRequestTypeGet success:^(id result) {
        successBlock(result);
    } failed:^(NSString *reson) {
        failedBlock(reson);
    }];
}

- (void)getActiviteInfoWith:(NSInteger)activiteId
                    Success:(void(^)(id result))successBlock
                     failed:(void(^)(NSString *reson))failedBlock{
    BADataEntity *data = [[BADataEntity alloc] init];
    data.urlString = [NSString stringWithFormat:@"%@/activity/getActivityDetail",BASEURL];
    data.needCache = NO;
    data.parameters = @{@"activityId":[NSNumber numberWithInteger:activiteId]};
    [self projectNetWorkWith:data netWorkType:BAHttpRequestTypeGet success:^(id result) {
        successBlock(result);
    } failed:^(NSString *reson) {
        failedBlock(reson);
    }];
}

- (void)getActiviteListWith:(NSDictionary *)parameters
                    success:(void(^)(id result))successBlock
                     failed:(void(^)(NSString *reson))failedBlock{
    BADataEntity *data = [[BADataEntity alloc] init];
    data.urlString = [NSString stringWithFormat:@"%@/activity/getAllActivity",BASEURL];
    data.needCache = NO;
    data.parameters = parameters;
    [self projectNetWorkWith:data netWorkType:BAHttpRequestTypeGet success:^(id result) {
        successBlock(result);
    } failed:^(NSString *reson) {
        failedBlock(reson);
    }];
}

- (void)getArticleListWith:(NSDictionary *)parameters
                   success:(void(^)(id result))successBlock
                    failed:(void(^)(NSString *reson))failedBlock{
    BADataEntity *data = [[BADataEntity alloc] init];
    data.urlString = [NSString stringWithFormat:@"%@/article/getArticleList",BASEURL];
    data.needCache = NO;
    data.parameters = parameters;
    [self projectNetWorkWith:data netWorkType:BAHttpRequestTypeGet success:^(id result) {
        successBlock(result);
    } failed:^(NSString *reson) {
        failedBlock(reson);
    }];
}

- (void)getTeamListWith:(NSDictionary *)parameters
                success:(void(^)(id result))successBlock
                 failed:(void(^)(NSString *reson))failedBlock{
    BADataEntity *data = [[BADataEntity alloc] init];
    data.urlString = [NSString stringWithFormat:@"%@/activity/getTeamList",BASEURL];
    data.needCache = NO;
    data.parameters = parameters;
    [self projectNetWorkWith:data netWorkType:BAHttpRequestTypeGet success:^(id result) {
        NSMutableArray *reList = [NSMutableArray array];
        NSArray *tmp = (NSArray *)result;
        for (NSDictionary *info in tmp) {
            TeamListModel *model = [[TeamListModel alloc] init];
            [model uploadWith:info];
            [reList addObject:model];
        }
        successBlock(reList);
    } failed:^(NSString *reson) {
        failedBlock(reson);
    }];
}

- (void)getTeaminfoWith:(NSInteger)teamId
                success:(void(^)(id result))successBlock
                 failed:(void(^)(NSString *reson))failedBlock{
    BADataEntity *data = [[BADataEntity alloc] init];
    data.urlString = [NSString stringWithFormat:@"%@/activity/getTeamDetail",BASEURL];
    data.needCache = NO;
    data.parameters = @{@"id":[NSNumber numberWithInteger:teamId]};
    [self projectNetWorkWith:data netWorkType:BAHttpRequestTypeGet success:^(id result) {
        successBlock(result);
    } failed:^(NSString *reson) {
        failedBlock(reson);
    }];
}

- (void)getPackageWith:(NSInteger)type
               success:(void(^)(id result))successBlock
                failed:(void(^)(NSString *reson))failedBlock{
    BADataEntity *data = [[BADataEntity alloc] init];
    data.urlString = [NSString stringWithFormat:@"%@/activity/getPackage",BASEURL];
    data.needCache = NO;
    data.parameters = @{@"type":[NSNumber numberWithInteger:type]};
    [self projectNetWorkWith:data netWorkType:BAHttpRequestTypeGet success:^(id result) {
        NSArray *tmp = (NSArray *)result;
        NSMutableArray *resList = [NSMutableArray array];
        for (NSDictionary *info in tmp) {
            PlanModel *model = [[PlanModel alloc] init];
            model.supervision_number = 1;
            [model uploadModelWith:info];
            [resList addObject:model];
        }
        successBlock(resList);
    } failed:^(NSString *reson) {
        failedBlock(reson);
    }];
}

- (void)getPackageWithpackageId:(NSInteger)packageId
                        success:(void(^)(id result))successBlock
                         failed:(void(^)(NSString *reson))failedBlock{
    BADataEntity *data = [[BADataEntity alloc] init];
    data.urlString = [NSString stringWithFormat:@"%@/activity/getWeightList",BASEURL];
    data.needCache = NO;
    data.parameters = @{@"packageId":[NSNumber numberWithInteger:packageId]};
    [self projectNetWorkWith:data netWorkType:BAHttpRequestTypeGet success:^(id result) {
        NSArray *tmp = (NSArray *)result;
        NSMutableArray *resList = [NSMutableArray array];
        for (NSDictionary *info in tmp) {
            SafeModel *model = [[SafeModel alloc] init];
            [model uploadModelWith:info];
            [resList addObject:model];
        }
        successBlock(resList);
    } failed:^(NSString *reson) {
        failedBlock(reson);
    }];
}


- (void)upImageWith:(NSString *)key
               data:(NSArray *)data
            success:(void(^)(id result))successBlock
             failed:(void(^)(NSString *reson))failedBlock{
    __block NSMutableArray *names = [NSMutableArray array];
    for (int i = 0; i < data.count; i++) {
        [names addObject:[NSString stringWithFormat:@"%@%u",[NSDate date],arc4random()%1000]];
    }
    BAImageDataEntity *imageEntity = [[BAImageDataEntity alloc] init];
    imageEntity.imageType = @"jpg";
    imageEntity.imageArray = data;
    imageEntity.imageScale = 0.5;
    imageEntity.fileNames = names;
    imageEntity.parameters = @{@"bath":key};
    imageEntity.urlString = [NSString stringWithFormat:@"%@/system/uploadFile",BASEURL];
    
    [BANetManager ba_uploadImageWithEntity:imageEntity successBlock:^(id response) {
        if (response) {
            if ([response isKindOfClass:[NSDictionary class]]) {
                NSDictionary *result = response;
                if ([result[@"status"] intValue] == 0) {
                    successBlock(result[@"data"]);
                }
                else{
                    failedBlock(result[@"resmsg"]);
                }
            }
            else{
                failedBlock(@"数据返回错误");
            }
        }
        else{
            failedBlock(@"无数据返回");
        }
    } failurBlock:^(NSError *error) {
        failedBlock([error localizedDescription]);
    } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        ;
    }];
}

- (void)getPyCommWith:(NSInteger)articleId
              success:(void(^)(id result))successBlock
               failed:(void(^)(NSString *reson))failedBlock{
    BADataEntity *data = [[BADataEntity alloc] init];
    data.urlString = [NSString stringWithFormat:@"%@/article/getArticleComment",BASEURL];
    data.needCache = NO;
    data.parameters = @{@"articleId":[NSNumber numberWithInteger:articleId]};
    [self projectNetWorkWith:data netWorkType:BAHttpRequestTypeGet success:^(id result) {
        NSArray *tmp = (NSArray *)result;
        NSMutableArray *resList = [NSMutableArray array];
        for (NSDictionary *info in tmp) {
            PhyRecomModel *model = [[PhyRecomModel alloc] init];
            [model uploadModelWith:info];
            [model uploadCellHeight];
            [resList addObject:model];
        }
        successBlock(resList);
    } failed:^(NSString *reson) {
        failedBlock(reson);
    }];
}

- (void)submitCommWith:(NSDictionary *)parameter
               success:(void(^)(id result))successBlock
                failed:(void(^)(NSString *reson))failedBlock{
    BADataEntity *data = [[BADataEntity alloc] init];
    data.urlString = [NSString stringWithFormat:@"%@/article/replyComment",BASEURL];
    data.needCache = NO;
    data.parameters = parameter;
    [self projectNetWorkWith:data netWorkType:BAHttpRequestTypePost success:^(id result) {
        successBlock(result);
    } failed:^(NSString *reson) {
        failedBlock(reson);
    }];
}

- (void)submitAvitity:(NSDictionary *)parament
              success:(void(^)(id result))successBlock
               failed:(void(^)(NSString *reson))failedBlock{
    BADataEntity *data = [[BADataEntity alloc] init];
    data.urlString = [NSString stringWithFormat:@"%@/activity/addActivity",BASEURL];
    data.needCache = NO;
    data.parameters = parament;
    [self projectNetWorkWith:data netWorkType:BAHttpRequestTypePost success:^(id result) {
        successBlock(result);
    } failed:^(NSString *reson) {
        failedBlock(reson);
    }];
}

- (void)addDeleteTeamCollec:(NSInteger)teamId
                       type:(NSInteger)type
                    success:(void(^)(id result))successBlock
                     failed:(void(^)(NSString *reson))failedBlock{
    BADataEntity *data = [[BADataEntity alloc] init];
    data.urlString = [NSString stringWithFormat:@"%@/person/addUserCollection",BASEURL];
    data.needCache = NO;
    data.parameters = @{@"teamId":[NSNumber numberWithInteger:teamId],@"type":[NSNumber numberWithInteger:type]};
    [self projectNetWorkWith:data netWorkType:BAHttpRequestTypePost success:^(id result) {
        successBlock(result);
    } failed:^(NSString *reson) {
        failedBlock(reson);
    }];
}

- (void)getOrderList:(NSInteger)status
                page:(NSInteger)page
                size:(NSInteger)size
             success:(void(^)(id result))successBlock
              failed:(void(^)(NSString *reson))failedBlock{
    BADataEntity *data = [[BADataEntity alloc] init];
    data.urlString = [NSString stringWithFormat:@"%@/order/getOrder",BASEURL];
    data.needCache = NO;
    data.parameters = @{@"status":status == 0 ? @"" : [NSNumber numberWithInteger:status],@"page":[NSNumber numberWithInteger:page],@"size":[NSNumber numberWithInteger:size]};
    [self projectNetWorkWith:data netWorkType:BAHttpRequestTypeGet success:^(id result) {
        successBlock([OrderModel mj_objectArrayWithKeyValuesArray:result]);
    } failed:^(NSString *reson) {
        failedBlock(reson);
    }];
}


- (void)getOrderDetatilWithOrderNo:(NSString *)orderNo
                           success:(void(^)(id result))successBlock
                            failed:(void(^)(NSString *reson))failedBlock{
    BADataEntity *data = [[BADataEntity alloc] init];
    data.urlString = [NSString stringWithFormat:@"%@/order/getOrderDetail",BASEURL];
    data.needCache = NO;
    data.parameters = @{@"orderNo":orderNo};
    [self projectNetWorkWith:data netWorkType:BAHttpRequestTypeGet success:^(id result) {
        OrderModelInfo *info = [OrderModelInfo mj_objectWithKeyValues:result];
        UserOderCommModel *comm = [UserOderCommModel mj_objectWithKeyValues:result[@"serverComment"]];
        info.serverComment = comm;
        successBlock(info);
    } failed:^(NSString *reson) {
        failedBlock(reson);
    }];
}

- (void)sureOrderWith:(NSString *)orderNo
              success:(void(^)(id result))successBlock
               failed:(void(^)(NSString *reson))failedBlock{
    BADataEntity *data = [[BADataEntity alloc] init];
    data.urlString = [NSString stringWithFormat:@"%@/order/sureOrder",BASEURL];
    data.needCache = NO;
    data.parameters = @{@"orderNo":orderNo};
    [self projectNetWorkWith:data netWorkType:BAHttpRequestTypePost success:^(id result) {
        successBlock([OrderModelInfo mj_objectWithKeyValues:result]);
    } failed:^(NSString *reson) {
        failedBlock(reson);
    }];
}

- (void)submitReplyWithOrder:(NSDictionary *)parmater
                     success:(void(^)(id result))successBlock
                      failed:(void(^)(NSString *reson))failedBlock{
    BADataEntity *data = [[BADataEntity alloc] init];
    data.urlString = [NSString stringWithFormat:@"%@/order/discussOrder",BASEURL];
    data.needCache = NO;
    data.parameters = parmater;
    [self projectNetWorkWith:data netWorkType:BAHttpRequestTypePost success:^(id result) {
        successBlock([OrderModelInfo mj_objectWithKeyValues:result]);
    } failed:^(NSString *reson) {
        failedBlock(reson);
    }];
}

- (void)canelOrderWith:(NSDictionary *)parmater
               success:(void(^)(id result))successBlock
                failed:(void(^)(NSString *reson))failedBlock{
    BADataEntity *data = [[BADataEntity alloc] init];
    data.urlString = [NSString stringWithFormat:@"%@/order/cancelOrder",BASEURL];
    data.needCache = NO;
    data.parameters = parmater;
    [self projectNetWorkWith:data netWorkType:BAHttpRequestTypePost success:^(id result) {
        successBlock([OrderModelInfo mj_objectWithKeyValues:result]);
    } failed:^(NSString *reson) {
        failedBlock(reson);
    }];
}

- (void)submitArticleWith:(NSDictionary *)parmater
                  success:(void(^)(id result))successBlock
                   failed:(void(^)(NSString *reson))failedBlock{
    BADataEntity *data = [[BADataEntity alloc] init];
    data.urlString = [NSString stringWithFormat:@"%@/article/addArticle",BASEURL];
    data.needCache = NO;
    data.parameters = parmater;
    [self projectNetWorkWith:data netWorkType:BAHttpRequestTypePost success:^(id result) {
        successBlock([OrderModelInfo mj_objectWithKeyValues:result]);
    } failed:^(NSString *reson) {
        failedBlock(reson);
    }];
}

- (void)getUserInfosuccess:(void(^)(id result))successBlock
                    failed:(void(^)(NSString *reson))failedBlock{
    BADataEntity *data = [[BADataEntity alloc] init];
    data.urlString = [NSString stringWithFormat:@"%@/order/getOrderDetail",BASEURL];
    data.needCache = NO;
    [self projectNetWorkWith:data netWorkType:BAHttpRequestTypeGet success:^(id result) {
        successBlock([UserBaseModel mj_objectWithKeyValues:result]);
    } failed:^(NSString *reson) {
        failedBlock(reson);
    }];
}

- (void)uploadUserInfo:(NSDictionary *)parmater
               success:(void(^)(id result))successBlock
                failed:(void(^)(NSString *reson))failedBlock{
    BADataEntity *data = [[BADataEntity alloc] init];
    data.urlString = [NSString stringWithFormat:@"%@/person/uptUserInfo",BASEURL];
    data.needCache = NO;
    data.parameters = parmater;
    [self projectNetWorkWith:data netWorkType:BAHttpRequestTypePost success:^(id result) {
        successBlock(result);
    } failed:^(NSString *reson) {
        failedBlock(reson);
    }];
}

- (void)changedPhone:(NSString *)phone
                code:(NSString *)code
             success:(void(^)(id result))successBlock
              failed:(void(^)(NSString *reson))failedBlock{
    BADataEntity *data = [[BADataEntity alloc] init];
    data.urlString = [NSString stringWithFormat:@"%@/user/bindPhone",BASEURL];
    data.needCache = NO;
    data.parameters = @{@"phone":phone,@"code":code};
    [self projectNetWorkWith:data netWorkType:BAHttpRequestTypePost success:^(id result) {
        successBlock(result);
    } failed:^(NSString *reson) {
        failedBlock(reson);
    }];
}

- (void)userAuthWIth:(NSDictionary *)parmater
             success:(void(^)(id result))successBlock
              failed:(void(^)(NSString *reson))failedBlock{
    BADataEntity *data = [[BADataEntity alloc] init];
    data.urlString = [NSString stringWithFormat:@"%@/person/real",BASEURL];
    data.needCache = NO;
    data.parameters = parmater;
    [self projectNetWorkWith:data netWorkType:BAHttpRequestTypePost success:^(id result) {
        successBlock(result);
    } failed:^(NSString *reson) {
        failedBlock(reson);
    }];
}

//
- (void)getMoneyDetail:(NSInteger)page size:(NSInteger)size
               success:(void(^)(id result))successBlock
                failed:(void(^)(NSString *reson))failedBlock{
    BADataEntity *data = [[BADataEntity alloc] init];
    data.urlString = [NSString stringWithFormat:@"%@/person/moneyDetail",BASEURL];
    data.needCache = NO;
    data.parameters = @{@"page":[NSNumber numberWithInteger:page],@"size":[NSNumber numberWithInteger:size]};
    [self projectNetWorkWith:data netWorkType:BAHttpRequestTypeGet success:^(id result) {
        successBlock([MoneyDetail mj_objectArrayWithKeyValuesArray:result]);
    } failed:^(NSString *reson) {
        failedBlock(reson);
    }];
}

//
- (void)withdrawalWith:(NSDictionary *)parmater
               success:(void(^)(id result))successBlock
                failed:(void(^)(NSString *reson))failedBlock{
    BADataEntity *data = [[BADataEntity alloc] init];
    data.urlString = [NSString stringWithFormat:@"%@/person/withdrawMoney",BASEURL];
    data.needCache = NO;
    data.parameters = parmater;
    [self projectNetWorkWith:data netWorkType:BAHttpRequestTypePost success:^(id result) {
        successBlock(result);
    } failed:^(NSString *reson) {
        failedBlock(reson);
    }];
}

///person/getBankList
- (void)getMyBankListsuccess:(void(^)(id result))successBlock
                      failed:(void(^)(NSString *reson))failedBlock{
    BADataEntity *data = [[BADataEntity alloc] init];
    data.urlString = [NSString stringWithFormat:@"%@/person/getBankList",BASEURL];
    data.needCache = NO;
    [self projectNetWorkWith:data netWorkType:BAHttpRequestTypeGet success:^(id result) {
        successBlock([BankModel mj_objectArrayWithKeyValuesArray:result]);
    } failed:^(NSString *reson) {
        failedBlock(reson);
    }];
}

///person/delBankCard
- (void)deleteBankCareWith:(NSInteger)bankId
                   success:(void(^)(id result))successBlock
                    failed:(void(^)(NSString *reson))failedBlock{
    BADataEntity *data = [[BADataEntity alloc] init];
    data.urlString = [NSString stringWithFormat:@"%@/person/delBankCard",BASEURL];
    data.needCache = NO;
    data.parameters = @{@"bankId":[NSNumber numberWithInteger:bankId]};
    [self projectNetWorkWith:data netWorkType:BAHttpRequestTypePost success:^(id result) {
        successBlock(result);
    } failed:^(NSString *reson) {
        failedBlock(reson);
    }];
}

- (void)addBankCarWIth:(NSDictionary *)parmater
               success:(void(^)(id result))successBlock
                failed:(void(^)(NSString *reson))failedBlock{
    BADataEntity *data = [[BADataEntity alloc] init];
    data.urlString = [NSString stringWithFormat:@"%@/person/addBankCard",BASEURL];
    data.needCache = NO;
    data.parameters = parmater;
    [self projectNetWorkWith:data netWorkType:BAHttpRequestTypePost success:^(id result) {
        successBlock(result);
    } failed:^(NSString *reson) {
        failedBlock(reson);
    }];
}


- (void)getSafeListsuccess:(void(^)(id result))successBlock
                    failed:(void(^)(NSString *reson))failedBlock{
    BADataEntity *data = [[BADataEntity alloc] init];
    data.urlString = [NSString stringWithFormat:@"%@/person/getUserWeights",BASEURL];
    data.needCache = NO;
    [self projectNetWorkWith:data netWorkType:BAHttpRequestTypeGet success:^(id result) {
        successBlock([BuySafe mj_objectArrayWithKeyValuesArray:result]);
    } failed:^(NSString *reson) {
        failedBlock(reson);
    }];
}

- (void)getMyCollectionsuccess:(void(^)(id result))successBlock
                        failed:(void(^)(NSString *reson))failedBlock{
    BADataEntity *data = [[BADataEntity alloc] init];
    data.urlString = [NSString stringWithFormat:@"%@/person/getUserCollection",BASEURL];
    data.needCache = NO;
    [self projectNetWorkWith:data netWorkType:BAHttpRequestTypeGet success:^(id result) {
        NSMutableArray *list = [NSMutableArray array];
        for (NSDictionary *info in result) {
            TeamListModel *model = [[TeamListModel alloc] init];
            [model uploadWithCollection:info];
            [list addObject:model];
        }
        successBlock(list);
    } failed:^(NSString *reson) {
        failedBlock(reson);
    }];
}

//
- (void)getVocherListsuccess:(void(^)(id result))successBlock
                      failed:(void(^)(NSString *reson))failedBlock{
    BADataEntity *data = [[BADataEntity alloc] init];
    data.urlString = [NSString stringWithFormat:@"%@/person/getCoupon",BASEURL];
    data.needCache = NO;
    [self projectNetWorkWith:data netWorkType:BAHttpRequestTypeGet success:^(id result) {
        successBlock([VocherModel mj_objectArrayWithKeyValuesArray:result]);
    } failed:^(NSString *reson) {
        failedBlock(reson);
    }];
}

//
- (void)getSubmitHistorysuccess:(void(^)(id result))successBlock
                         failed:(void(^)(NSString *reson))failedBlock{
    BADataEntity *data = [[BADataEntity alloc] init];
    data.urlString = [NSString stringWithFormat:@"%@/person/getPushActivity",BASEURL];
    data.needCache = NO;
    [self projectNetWorkWith:data netWorkType:BAHttpRequestTypeGet success:^(id result) {
        successBlock([SubHisModel mj_objectArrayWithKeyValuesArray:result]);
    } failed:^(NSString *reson) {
        failedBlock(reson);
    }];
}

- (void)getTopPromotesuccess:(void(^)(id result))successBlock
                      failed:(void(^)(NSString *reson))failedBlock{
    BADataEntity *data = [[BADataEntity alloc] init];
    data.urlString = [NSString stringWithFormat:@"%@/person/getMyPush",BASEURL];
    data.needCache = NO;
    [self projectNetWorkWith:data netWorkType:BAHttpRequestTypeGet success:^(id result) {
        successBlock([TopPromoteModel mj_objectArrayWithKeyValuesArray:result]);
    } failed:^(NSString *reson) {
        failedBlock(reson);
    }];
}
//
- (void)getRankListsuccess:(void(^)(id result))successBlock
                    failed:(void(^)(NSString *reson))failedBlock{
    BADataEntity *data = [[BADataEntity alloc] init];
    data.urlString = [NSString stringWithFormat:@"%@/activity/getRank",BASEURL];
    data.needCache = NO;
    [self projectNetWorkWith:data netWorkType:BAHttpRequestTypeGet success:^(id result) {
        successBlock([RankModel mj_objectArrayWithKeyValuesArray:result]);
    } failed:^(NSString *reson) {
        failedBlock(reson);
    }];
}

- (void)orderDoneWith:(NSInteger)type orderNo:(NSString *)orderNo
              success:(void(^)(id result))successBlock
               failed:(void(^)(NSString *reson))failedBlock{
    BADataEntity *data = [[BADataEntity alloc] init];
    data.urlString = [NSString stringWithFormat:@"%@/person/finishOrder",BASEURL];
    data.needCache = NO;
    data.parameters = @{@"type":[NSNumber numberWithInteger:type + 1],@"orderNo":orderNo};
    [self projectNetWorkWith:data netWorkType:BAHttpRequestTypePost success:^(id result) {
        successBlock(result);
    } failed:^(NSString *reson) {
        failedBlock(reson);
    }];
}

- (void)getPayWith:(NSString *)orderNo
           payType:(NSInteger)type
      userCouponId:(NSInteger)userCouponId
           success:(void(^)(id result))successBlock
            failed:(void(^)(NSString *reson))failedBlock{
    BADataEntity *data = [[BADataEntity alloc] init];
    data.urlString = [NSString stringWithFormat:@"%@/order/payOrderNo",BASEURL];
    data.needCache = NO;
    if (userCouponId) {
        data.parameters = @{@"payType":[NSNumber numberWithInteger:type],@"orderNo":orderNo,@"activCouponId":@(userCouponId)};
    }
    else{
        data.parameters = @{@"payType":[NSNumber numberWithInteger:type],@"orderNo":orderNo};
    }
    [self projectNetWorkWith:data netWorkType:BAHttpRequestTypePost success:^(id result) {
        successBlock(result);
    } failed:^(NSString *reson) {
        failedBlock(reson);
    }];
}


/**
 项目请求

 @param dataEntity 请求数据传入
 @param type 请求类型
 @param successBlock success
 @param failedBlock failed
 */
- (void)projectNetWorkWith:(BADataEntity *)dataEntity
               netWorkType:(BAHttpRequestType)type
                   success:(void(^)(id result))successBlock
                    failed:(void(^)(NSString *reson))failedBlock{
    if (type == BAHttpRequestTypePost) {
        [BANetManager ba_request_POSTWithEntity:dataEntity successBlock:^(id response) {
            if (response) {
                if ([response isKindOfClass:[NSDictionary class]]) {
                    NSDictionary *result = response;
                    if ([result[@"status"] intValue] == 0) {
                        successBlock(result[@"data"]);
                    }
                    else{
                        failedBlock(result[@"resmsg"]);
                    }
                }
                else{
                    failedBlock(@"数据返回错误");
                }
            }
            else{
                failedBlock(@"无数据返回");
            }
        } failureBlock:^(NSError *error) {
            failedBlock([error localizedDescription]);
        } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
            
        }];
    }
    else if(type == BAHttpRequestTypeGet){
        [BANetManager ba_request_GETWithEntity:dataEntity successBlock:^(id response) {
            if (response) {
                if ([response isKindOfClass:[NSDictionary class]]) {
                    NSDictionary *result = response;
                    if ([result[@"status"] intValue] == 0) {
                        successBlock(result[@"data"]);
                    }
                    else{
                        if ([result[@"status"] intValue] == 105 || [result[@"status"] intValue] == 106 || [result[@"status"] intValue] == 107) {
                            [[ProjectTool getCurrentViewController].navigationController pushViewController:[[LoginViewController alloc] init] animated:YES];
                            failedBlock(result[@"resmsg"]);
                        }
                        else{
                            failedBlock(result[@"resmsg"]);
                        }
                    }
                }
                else{
                    failedBlock(@"数据返回错误");
                }
            }
            else{
                failedBlock(@"无数据返回");
            }
        } failureBlock:^(NSError *error) {
            failedBlock([error localizedDescription]);
        } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
            ;
        }];
    }
    
}

+ (void)fetchImageWithAsset:(PHAsset*)mAsset imageBlock:(void(^)(UIImage *iamge))imageBlock {
    PHImageRequestOptions *phImageRequestOptions = [[PHImageRequestOptions alloc] init];
    phImageRequestOptions.synchronous = YES;
    [[PHImageManager defaultManager] requestImageForAsset:mAsset targetSize:CGSizeMake(SCREEN_WIDTH * 1.5, SCREEN_HEIGHT * 1.5) contentMode:PHImageContentModeDefault options:phImageRequestOptions resultHandler:^(UIImage *resultImage, NSDictionary *info) {
        if ([[info valueForKey:@"PHImageResultIsDegradedKey"]integerValue] == 0){
            if (imageBlock) {
                imageBlock(resultImage);
            }
        }
    }];
}
    
- (void)loginWithTherePlaceWith:(NSString *)openType
                          loginType:(NSString *)loginType
                             openId:(NSString *)openID
                             header:(NSString *)header
                               name:(NSString *)name
                            success:(void(^)(id result))successBlock
                             failed:(void(^)(NSString *reson))failedBlock{
    
    NSMutableDictionary *input = [NSMutableDictionary dictionary];
    [input setValue:openType forKey:@"openType"];
    [input setValue:loginType forKey:@"loginType"];
    [input setValue:openID forKey:@"openId"];
    [input setValue:header forKey:@"header"];
    [input setValue:name forKey:@"name"];
    [self userLogin:input success:^(id  _Nonnull result) {
        successBlock(result);
    } failed:^(NSString * _Nonnull reson) {
        failedBlock(reson);
    }];
}

- (void)topupMoneny:(NSString *)moneny
               type:(NSString *)payType
            success:(void(^)(id result))successBlock
             failed:(void(^)(NSString *reson))failedBlock{
    BADataEntity *data = [[BADataEntity alloc] init];
    data.urlString = [NSString stringWithFormat:@"%@/person/reCharge",BASEURL];
    data.needCache = NO;
    data.parameters = @{@"money":[NSNumber numberWithInteger:[moneny integerValue]],@"payType":payType};
    [self projectNetWorkWith:data netWorkType:BAHttpRequestTypePost success:^(id result) {
        successBlock(result);
    } failed:^(NSString *reson) {
        failedBlock(reson);
    }];
}

/**
 获取订单评价
 
 @param order_no 订单号
 @param successBlock success
 @param failedBlock failed
 
 */
- (void)getOrderCommInfo:(NSString *)order_no
                 success:(void(^)(id result))successBlock
                  failed:(void(^)(NSString *reson))failedBlock{
    BADataEntity *data = [[BADataEntity alloc] init];
    data.urlString = [NSString stringWithFormat:@"%@/order/getOrderComment",BASEURL];
    data.needCache = NO;
    data.parameters = @{@"orderNo":order_no};
    [self projectNetWorkWith:data netWorkType:BAHttpRequestTypeGet success:^(id result) {
        successBlock([UserOderCommModel mj_objectWithKeyValues:result]);
    } failed:^(NSString *reson) {
        failedBlock(reson);
    }];
}

/**
 获取系统信息
 
 @param successBlock success
 
 @param failedBlock failed
 
 */
- (void)getSystemMessageListsuccess:(void(^)(id result))successBlock
                             failed:(void(^)(NSString *reson))failedBlock{
    BADataEntity *data = [[BADataEntity alloc] init];
    data.urlString = [NSString stringWithFormat:@"%@/system/getSystemMsg",BASEURL];
    data.needCache = NO;
    [self projectNetWorkWith:data netWorkType:BAHttpRequestTypeGet success:^(id result) {
        successBlock([MessageModel mj_objectArrayWithKeyValuesArray:result]);
    } failed:^(NSString *reson) {
        failedBlock(reson);
    }];
}

/**
 删除系统 消息
 
 @param message_id 消息ID
 @param successBlock success
 @param failedBlock failed
 */
- (void)deleteSystemMessage:(NSString *)message_id
                    success:(void(^)(id result))successBlock
                     failed:(void(^)(NSString *reson))failedBlock{
    BADataEntity *data = [[BADataEntity alloc] init];
    data.urlString = [NSString stringWithFormat:@"%@/system/delSystemMsg",BASEURL];
    data.needCache = NO;
    data.parameters = @{@"id":message_id};
    [self projectNetWorkWith:data netWorkType:BAHttpRequestTypePost success:^(id result) {
        successBlock(result);
    } failed:^(NSString *reson) {
        failedBlock(reson);
    }];
}

/**
 意见反馈
 
 @param content 内容
 @param successBlock success
 @param failedBlock failed
 */
- (void)submitTextWith:(NSString *)content
               success:(void(^)(id result))successBlock
                failed:(void(^)(NSString *reson))failedBlock{
    BADataEntity *data = [[BADataEntity alloc] init];
    data.urlString = [NSString stringWithFormat:@"%@/system/feedback",BASEURL];
    data.needCache = NO;
    data.parameters = @{@"content":content};
    [self projectNetWorkWith:data netWorkType:BAHttpRequestTypePost success:^(id result) {
        successBlock(result);
    } failed:^(NSString *reson) {
        failedBlock(reson);
    }];
}

///system/getSystemAbout
/**
 获取常见问题，关于我们，用户协议
 
 @param code 关键字 常见问题：problem 关于我们：about
 
 @param successBlock success
 @param failedBlock failed
 */
- (void)getNormalQuestionwithCode:(NSString *)code
                          success:(void(^)(id result))successBlock
                           failed:(void(^)(NSString *reson))failedBlock{
    BADataEntity *data = [[BADataEntity alloc] init];
    data.urlString = [NSString stringWithFormat:@"%@/system/getSystemAbout",BASEURL];
    data.needCache = NO;
    data.parameters = @{@"code":code};
    [self projectNetWorkWith:data netWorkType:BAHttpRequestTypeGet success:^(id result) {
        successBlock(result);
    } failed:^(NSString *reson) {
        failedBlock(reson);
    }];
}

//

/**
 获取原因
 
 @param type type
 @param successBlock success
 @param failedBlock failed
 */
- (void)getResonWithCode:(NSString *)type
                 success:(void(^)(id result))successBlock
                  failed:(void(^)(NSString *reson))failedBlock{
    BADataEntity *data = [[BADataEntity alloc] init];
    data.urlString = [NSString stringWithFormat:@"%@/system/getReturnMsg",BASEURL];
    data.needCache = NO;
    data.parameters = @{@"type":type};
    [self projectNetWorkWith:data netWorkType:BAHttpRequestTypeGet success:^(id result) {
        successBlock(result);
    } failed:^(NSString *reson) {
        failedBlock(reson);
    }];
}

//

/**
 申请返还
 
 @param orderNo orderNO
 @param comment 填写的原因
 @param applyReson 选择的原因（从 system/getReturnMsg获取）
 @param successBlock success
 @param failedBlock failed
 */
- (void)applySafeWith:(NSString *)orderNo
              comment:(NSString *)comment
                other:(NSString *)applyReson
              success:(void(^)(id result))successBlock
               failed:(void(^)(NSString *reson))failedBlock{
    BADataEntity *data = [[BADataEntity alloc] init];
    data.urlString = [NSString stringWithFormat:@"%@/person/applyReturn",BASEURL];
    data.needCache = NO;
    data.parameters = @{@"orderNo":orderNo,@"comment":comment,@"applyReason":applyReson};
    [self projectNetWorkWith:data netWorkType:BAHttpRequestTypePost success:^(id result) {
        successBlock(result);
    } failed:^(NSString *reson) {
        failedBlock(reson);
    }];
}

/**
 删除系统消息
 
 @param msgId 消息ID
 @param successBlock success
 @param failedBlock failed
 */
- (void)deleteSystemMsg:(NSString *)msgId
                success:(void(^)(id result))successBlock
                 failed:(void(^)(NSString *reson))failedBlock{
    BADataEntity *data = [[BADataEntity alloc] init];
    data.urlString = [NSString stringWithFormat:@"%@/system/delSystemMsg",BASEURL];
    data.needCache = NO;
    data.parameters = @{@"id":msgId};
    [self projectNetWorkWith:data netWorkType:BAHttpRequestTypePost success:^(id result) {
        successBlock(result);
    } failed:^(NSString *reson) {
        failedBlock(reson);
    }];
}

- (void)getSystemConfigsuccess:(void(^)(id result))successBlock
                        failed:(void(^)(NSString *reson))failedBlock{
    BADataEntity *data = [[BADataEntity alloc] init];
    data.urlString = [NSString stringWithFormat:@"%@/system/getSystemConfig",BASEURL];
    data.needCache = NO;
    [self projectNetWorkWith:data netWorkType:BAHttpRequestTypeGet success:^(id result) {
        successBlock(result);
    } failed:^(NSString *reson) {
        failedBlock(reson);
    }];
}

- (void)getSystemAblutsuccess:(void(^)(id result))successBlock
                        failed:(void(^)(NSString *reson))failedBlock{
    BADataEntity *data = [[BADataEntity alloc] init];
    data.urlString = [NSString stringWithFormat:@"%@/system/getSystemAbout",BASEURL];
    data.needCache = NO;
    data.parameters = @{@"code":@"rank_info"};
    [self projectNetWorkWith:data netWorkType:BAHttpRequestTypeGet success:^(id result) {
        successBlock(result);
    } failed:^(NSString *reson) {
        failedBlock(reson);
    }];
}

- (void)deleteCOmmWith:(NSString *)articleId andCommID:(NSString *)commentId success:(void(^)(id result))successBlock
                failed:(void(^)(NSString *reson))failedBlock{
    BADataEntity *data = [[BADataEntity alloc] init];
    data.urlString = [NSString stringWithFormat:@"%@/article/deleteComment",BASEURL];
    data.needCache = NO;
    data.parameters = @{@"articleId":articleId,@"commentId":commentId};
    [self projectNetWorkWith:data netWorkType:BAHttpRequestTypePost success:^(id result) {
        successBlock(result);
    } failed:^(NSString *reson) {
        failedBlock(reson);
    }];
}

- (void)otherLoginBindPhone:(NSString *)phone
                       code:(NSString *)code
                   openType:(NSString *)openType
                 inviteCode:(NSString *)inviteCode
                    success:(void(^)(id result))successBlock
                     failed:(void(^)(NSString *reson))failedBlock{
    BADataEntity *data = [[BADataEntity alloc] init];
    data.urlString = [NSString stringWithFormat:@"%@/user/bindPhone",BASEURL];
    data.needCache = NO;
    data.parameters = @{@"phone":phone,@"code":code,@"openType":openType,@"inviteCode":inviteCode};
    [self projectNetWorkWith:data netWorkType:BAHttpRequestTypePost success:^(id result) {
        successBlock(result);
    } failed:^(NSString *reson) {
        failedBlock(reson);
    }];
}

- (void)deleteProjectWith:(NSString *)articleId
                  success:(void(^)(id result))successBlock
                   failed:(void(^)(NSString *reson))failedBlock{
    BADataEntity *data = [[BADataEntity alloc] init];
    data.urlString = [NSString stringWithFormat:@"%@/article/delArticle",BASEURL];
    data.needCache = NO;
    data.parameters = @{@"articleId":articleId};
    [self projectNetWorkWith:data netWorkType:BAHttpRequestTypePost success:^(id result) {
        successBlock(result);
    } failed:^(NSString *reson) {
        failedBlock(reson);
    }];
}

- (void)bindWxWith:(NSString *)code
           success:(void(^)(id result))successBlock
            failed:(void(^)(NSString *reson))failedBlock{
    BADataEntity *data = [[BADataEntity alloc] init];
    data.urlString = [NSString stringWithFormat:@"%@/user/appBindWx",BASEURL];
    data.needCache = NO;
    data.parameters = @{@"openId":code,@"openType":@"wx"};
    [self projectNetWorkWith:data netWorkType:BAHttpRequestTypePost success:^(id result) {
        successBlock(result);
    } failed:^(NSString *reson) {
        failedBlock(reson);
    }];
}




@end
