//
//  NSObject+NetWork.h
//  VideoData
//
//  Created by pro1 on 2019/3/19.
//  Copyright © 2019 pro1. All rights reserved.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

@interface NSObject (NetWork)

/**
 用户注册

 @param parameters 传值
 @param successBlock 成功回调
 @param failedBlock 失败回调
 */
- (void)userRegisWith:(NSDictionary *)parameters
              success:(void(^)(id result))successBlock
               failed:(void(^)(NSString *reson))failedBlock;

/**
 获取验证码

 @param phone 手机号码
 @param type 验证码类型
 @param successBlock success
 @param failedBlock failed
 */
- (void)userGetMessageCodeWith:(NSString *)phone
                      codeType:(NSInteger)type
                       success:(void(^)(id result))successBlock
                        failed:(void(^)(NSString *reson))failedBlock;

/**
 用户登录

 @param parameters paramaeters
 @param successBlock success
 @param failedBlock failed
 */
- (void)userLogin:(NSDictionary *)parameters
          success:(void(^)(id result))successBlock
           failed:(void(^)(NSString *reson))failedBlock;

/**
 修改密码

 @param parameters dic
 @param successBlock success
 @param failedBlock failed
 */
- (void)userChangPassword:(NSDictionary *)parameters
                  success:(void(^)(id result))successBlock
                   failed:(void(^)(NSString *reson))failedBlock;

/**
 获取用户信息

 @param successBlock success
 @param failedBlock success
 */
- (void)getUserInfoSuccess:(void(^)(id result))successBlock
                    failed:(void(^)(NSString *reson))failedBlock;

/**
 获取首页banner

 @param successBlock success
 @param failedBlock failed
 */
- (void)getHomePageBannerSuccess:(void(^)(id result))successBlock
                          failed:(void(^)(NSString *reson))failedBlock;

/**
 获取首页列表

 @param successBlock success
 @param failedBlock success
 */
- (void)getHomeActiviteListSuccess:(void(^)(id result))successBlock
                            failed:(void(^)(NSString *reson))failedBlock;

/**
 获取城市列表

 @param successBlock success
 @param failedBlock failed
 */
- (void)getCityListSuccess:(void(^)(id result))successBlock
                    failed:(void(^)(NSString *reson))failedBlock;

/**
 获取活动详情

 @param activiteId 活动ID
 @param successBlock success
 @param failedBlock failed
 */
- (void)getActiviteInfoWith:(NSInteger)activiteId
                    Success:(void(^)(id result))successBlock
                     failed:(void(^)(NSString *reson))failedBlock;

/**
 获取活动列表

 @param parameters 传入参数
 @param successBlock success
 @param failedBlock failed
 */
- (void)getActiviteListWith:(NSDictionary *)parameters
                    success:(void(^)(id result))successBlock
                     failed:(void(^)(NSString *reson))failedBlock;

/**
 获取终端问诊列表

 @param parameters parameters
 @param successBlock successBlock
 @param failedBlock failedBlock
 */
- (void)getArticleListWith:(NSDictionary *)parameters
                    success:(void(^)(id result))successBlock
                     failed:(void(^)(NSString *reson))failedBlock;

/**
 获取团队列表

 @param parameters 传入参数
 @param successBlock success
 @param failedBlock failed
 */
- (void)getTeamListWith:(NSDictionary *)parameters
                success:(void(^)(id result))successBlock
                 failed:(void(^)(NSString *reson))failedBlock;


/**
 获取团队详情

 @param teamId 团队ID
 @param successBlock success
 @param failedBlock failed
 */
- (void)getTeaminfoWith:(NSInteger)teamId
                success:(void(^)(id result))successBlock
                 failed:(void(^)(NSString *reson))failedBlock;

/**
 获取获取套餐

 @param type 类型1-单点 2-促销 3-联盟 4-品牌联动 5-实战培训
 @param successBlock success
 @param failedBlock failed
 */
- (void)getPackageWith:(NSInteger)type
               success:(void(^)(id result))successBlock
                failed:(void(^)(NSString *reson))failedBlock;

/**
 获取安全砝码

 @param packageId packageId
 @param successBlock success
 @param failedBlock failed
 */
- (void)getPackageWithpackageId:(NSInteger)packageId
               success:(void(^)(id result))successBlock
                failed:(void(^)(NSString *reson))failedBlock;

/**
 上传文件

 @param key keyd
 @param datas data
 @param successBlock success
 @param failedBlock failed
 */
- (void)upImageWith:(NSString *)key
               data:(NSArray *)datas
            success:(void(^)(id result))successBlock
             failed:(void(^)(NSString *reson))failedBlock;

/**
 获取问诊评论

 @param articleId 问诊贴ID
 @param successBlock success
 @param failedBlock failed /article/getArticleComment
 */
- (void)getPyCommWith:(NSInteger)articleId
              success:(void(^)(id result))successBlock
               failed:(void(^)(NSString *reson))failedBlock;

/**
 评论

 @param parameter input
 @param successBlock success
 @param failedBlock failed
 */
- (void)submitCommWith:(NSDictionary *)parameter
               success:(void(^)(id result))successBlock
                failed:(void(^)(NSString *reson))failedBlock;

/**
 添加活动

 @param parament 传入参数
 @param successBlock success
 @param failedBlock failed
 */
- (void)submitAvitity:(NSDictionary *)parament
              success:(void(^)(id result))successBlock
               failed:(void(^)(NSString *reson))failedBlock;

/**
 添加取消收藏

 @param teamId 团队ID
 @param type 0-添加收藏  1-取消收藏
 @param successBlock success
 @param failedBlock failed
 */
- (void)addDeleteTeamCollec:(NSInteger)teamId
                       type:(NSInteger)type
                    success:(void(^)(id result))successBlock
                     failed:(void(^)(NSString *reson))failedBlock;

/**
 获取订单

 @param status 1-待接单 2-待支付  3-进行中 4-已完成  默认全部
 @param page page
 @param size size
 @param successBlock success
 @param failedBlock failed
 */
- (void)getOrderList:(NSInteger)status
                page:(NSInteger)page
                size:(NSInteger)size
             success:(void(^)(id result))successBlock
              failed:(void(^)(NSString *reson))failedBlock;

/**
 获取订单详情

 @param orderNo order_id
 @param successBlock success
 @param failedBlock failed
 */
- (void)getOrderDetatilWithOrderNo:(NSString *)orderNo
             success:(void(^)(id result))successBlock
              failed:(void(^)(NSString *reson))failedBlock;
///order/sureOrder
- (void)sureOrderWith:(NSString *)orderNo
              success:(void(^)(id result))successBlock
               failed:(void(^)(NSString *reson))failedBlock;

- (void)submitReplyWithOrder:(NSDictionary *)parmater
                     success:(void(^)(id result))successBlock
                      failed:(void(^)(NSString *reson))failedBlock;

- (void)canelOrderWith:(NSDictionary *)parmater
               success:(void(^)(id result))successBlock
                failed:(void(^)(NSString *reson))failedBlock;

- (void)submitArticleWith:(NSDictionary *)parmater
                  success:(void(^)(id result))successBlock
                   failed:(void(^)(NSString *reson))failedBlock;
///person/getProfile
- (void)getUserInfosuccess:(void(^)(id result))successBlock
                    failed:(void(^)(NSString *reson))failedBlock;
///person/uptUserInfo
- (void)uploadUserInfo:(NSDictionary *)parmater
               success:(void(^)(id result))successBlock
                failed:(void(^)(NSString *reson))failedBlock;

- (void)changedPhone:(NSString *)phone
                code:(NSString *)code
             success:(void(^)(id result))successBlock
              failed:(void(^)(NSString *reson))failedBlock;
//
- (void)userAuthWIth:(NSDictionary *)parmater
             success:(void(^)(id result))successBlock
              failed:(void(^)(NSString *reson))failedBlock;
///person/moneyDetail
- (void)getMoneyDetail:(NSInteger)page size:(NSInteger)size
               success:(void(^)(id result))successBlock
                failed:(void(^)(NSString *reson))failedBlock;
///person/withdrawMoney
- (void)withdrawalWith:(NSDictionary *)parmater
               success:(void(^)(id result))successBlock
                failed:(void(^)(NSString *reson))failedBlock;
///person/getBankList
- (void)getMyBankListsuccess:(void(^)(id result))successBlock
                      failed:(void(^)(NSString *reson))failedBlock;
///person/delBankCard
- (void)deleteBankCareWith:(NSInteger)bankId
                   success:(void(^)(id result))successBlock
                    failed:(void(^)(NSString *reson))failedBlock;
///person/addBankCard
- (void)addBankCarWIth:(NSDictionary *)parmater
               success:(void(^)(id result))successBlock
                failed:(void(^)(NSString *reson))failedBlock;
///person/getUserWeights
- (void)getSafeListsuccess:(void(^)(id result))successBlock
                    failed:(void(^)(NSString *reson))failedBlock;
//
- (void)getMyCollectionsuccess:(void(^)(id result))successBlock
                        failed:(void(^)(NSString *reson))failedBlock;
///person/getCoupon
- (void)getVocherListsuccess:(void(^)(id result))successBlock
                      failed:(void(^)(NSString *reson))failedBlock;
///person/getPushActivity
- (void)getSubmitHistorysuccess:(void(^)(id result))successBlock
                         failed:(void(^)(NSString *reson))failedBlock;
///person/getMyPush
- (void)getTopPromotesuccess:(void(^)(id result))successBlock
                      failed:(void(^)(NSString *reson))failedBlock;
///activity/getRank
- (void)getRankListsuccess:(void(^)(id result))successBlock
                    failed:(void(^)(NSString *reson))failedBlock;
///order/completeOrder
- (void)orderDoneWith:(NSInteger)type orderNo:(NSString *)orderNo
              success:(void(^)(id result))successBlock
               failed:(void(^)(NSString *reson))failedBlock;
///order/payOrderNo
- (void)getPayWith:(NSString *)orderNo
           payType:(NSInteger)type
      userCouponId:(NSInteger)userCouponId
           success:(void(^)(id result))successBlock
            failed:(void(^)(NSString *reson))failedBlock;

/**
 三方登录

 @param openType 三方类型（全小写）：wx/qq
 @param loginType 1：账号，密码 2：第三方
 @param openID 第三方生成的ID
 @param header 头像
 @param name 名字
 @param successBlock success
 @param failedBlock failed
 */
- (void)loginWithTherePlaceWith:(NSString *)openType
                        loginType:(NSString *)loginType
                            openId:(NSString *)openID
                            header:(NSString *)header
                            name:(NSString *)name
                        success:(void(^)(id result))successBlock
                        failed:(void(^)(NSString *reson))failedBlock;
/**
 充值
 
 @param moneny 充值金额
 @param payType 支付方式支付方式  1-微信 2-支付宝  3-银行卡  4-微信小程序支付
 @param successBlock success
 @param failedBlock failed
 */
- (void)topupMoneny:(NSString *)moneny
               type:(NSString *)payType
            success:(void(^)(id result))successBlock
             failed:(void(^)(NSString *reson))failedBlock;

/**
 获取订单评价
 
 @param order_no 订单号
 @param successBlock success
 @param failedBlock failed
 
 */
- (void)getOrderCommInfo:(NSString *)order_no
                 success:(void(^)(id result))successBlock
                  failed:(void(^)(NSString *reson))failedBlock;
//self.byOrder.selected = YES;

/**
 获取系统信息

 @param successBlock success

 @param failedBlock failed
 
 */
- (void)getSystemMessageListsuccess:(void(^)(id result))successBlock
                             failed:(void(^)(NSString *reson))failedBlock;

/**
 删除系统 消息

 @param message_id 消息ID
 @param successBlock success
 @param failedBlock failed
 */
- (void)deleteSystemMessage:(NSString *)message_id
                    success:(void(^)(id result))successBlock
                     failed:(void(^)(NSString *reson))failedBlock;

/**
 意见反馈
 
 @param content 内容
 @param successBlock success
 @param failedBlock failed
 */
- (void)submitTextWith:(NSString *)content
               success:(void(^)(id result))successBlock
                failed:(void(^)(NSString *reson))failedBlock;
///system/getSystemAbout

/**
 获取常见问题，关于我们，用户协议
 
 @param code code
 @param successBlock success
 @param failedBlock failed
 */
- (void)getNormalQuestionwithCode:(NSString *)code
                          success:(void(^)(id result))successBlock
                           failed:(void(^)(NSString *reson))failedBlock;

///system/getReturnMsg

/**
 获取原因

 @param type type
 @param successBlock success
 @param failedBlock failed
 */
- (void)getResonWithCode:(NSString *)type
                 success:(void(^)(id result))successBlock
                  failed:(void(^)(NSString *reson))failedBlock;
///person/applyReturn

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
               failed:(void(^)(NSString *reson))failedBlock;


/**
 删除系统消息
 
 @param msgId 消息ID
 @param successBlock success
 @param failedBlock failed
 */
- (void)deleteSystemMsg:(NSString *)msgId
                success:(void(^)(id result))successBlock
                 failed:(void(^)(NSString *reson))failedBlock;
///system/getSystemConfig
- (void)getSystemConfigsuccess:(void(^)(id result))successBlock
                        failed:(void(^)(NSString *reson))failedBlock;

- (void)getSystemAblutsuccess:(void(^)(id result))successBlock
                       failed:(void(^)(NSString *reson))failedBlock;

- (void)deleteCOmmWith:(NSString *)articleId andCommID:(NSString *)commentId success:(void(^)(id result))successBlock
                failed:(void(^)(NSString *reson))failedBlock;

- (void)otherLoginBindPhone:(NSString *)phone
                       code:(NSString *)code
                   openType:(NSString *)openType
                 inviteCode:(NSString *)inviteCode
                    success:(void(^)(id result))successBlock
                     failed:(void(^)(NSString *reson))failedBlock;

- (void)deleteProjectWith:(NSString *)articleId
                  success:(void(^)(id result))successBlock
                   failed:(void(^)(NSString *reson))failedBlock;

- (void)bindWxWith:(NSString *)code
           success:(void(^)(id result))successBlock
            failed:(void(^)(NSString *reson))failedBlock;


@end

NS_ASSUME_NONNULL_END
