//
//  PhyRecomModel.h
//  HJZSU
//
//  Created by apple on 2019/3/26.
//  Copyright © 2019 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PRComment : NSObject
/*
 "content": "测试第二位", //评论内容
 "createTime": 1552614658000,
 "fromHead": "http://heipa.oss-cn-hangzhou.aliyuncs.com/head/153915074457164512em_default_avatar.png",  //二级评论人头像
 "fromName": "无敌战神", //二级评论人名称
 "fromUid": 2, //二级评论人id
 "id": 222, //回复主键id
 "toName": "孙育慎",  //被评论人名字
 "toUid": 10007  //被评论人id
 */
@property (strong,nonatomic) NSString *content;
@property (strong,nonatomic) NSString *createTime;
@property (strong,nonatomic) NSString *fromHead;
@property (strong,nonatomic) NSString *fromName;
@property (strong,nonatomic) NSString *fromUid;
@property (strong,nonatomic) NSString *id;
@property (strong,nonatomic) NSString *toName;
@property (strong,nonatomic) NSString *toUid;

@property (assign,nonatomic) CGFloat cellHeight;

- (void)uploadModelWithReply:(NSDictionary *)info;
- (void)uploadReplyCellHeight;

@end

@interface PhyRecomModel : NSObject
/*"articleId": 3198, //帖子id
 "content": "一楼", //评论内容
 "createTime": 1553138520000, //评论时间戳
 "id": 1376, //评论id
 "userHead": "http://heipa.oss-cn-hangzhou.aliyuncs.com/head/153915074457164512em_default_avatar.png",  //头像
 "userId": 2,   //评论用户id
 "userName": "无敌战神" //评论用户名称
 "reply": [*/

- (void)uploadModelWith:(NSDictionary *)info;
- (void)uploadCellHeight;

@property (strong,nonatomic) NSString *articleId;
@property (strong,nonatomic) NSString *content;
@property (strong,nonatomic) NSString *createTime;
@property (strong,nonatomic) NSString *id;
@property (strong,nonatomic) NSString *userHead;
@property (strong,nonatomic) NSString *userId;
@property (strong,nonatomic) NSString *userName;
@property (strong,nonatomic) NSMutableArray *reply;

@property (assign,nonatomic) CGFloat cellHeight;

@end

NS_ASSUME_NONNULL_END
