//
//  UserOderCommModel.h
//  HJZSU
//
//  Created by apple on 2019/4/11.
//  Copyright © 2019 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserOderCommModel : NSObject
/*
 commentId = 2;
 content = "\U7238\U7238";
 createTime = 1554991400000;
 images = "https://hjzsmy.oss-cn-shanghai.aliyuncs.com/activity/1554991400033260152019-04-1114%3A03%3A19%2B000066%2Cjpg.jpg;";
 score = 5;
 teamId = 26;
 */

@property (strong,nonatomic) NSString *content;
@property (strong,nonatomic) NSString *createTime;
@property (strong,nonatomic) NSString *commentId;
@property (strong,nonatomic) NSString *images;
@property (strong,nonatomic) NSString *score;
@property (strong,nonatomic) NSString *teamId;
@property (strong,nonatomic) NSString *teamName;
@property (strong,nonatomic) NSString *teamHead;

@end

NS_ASSUME_NONNULL_END
