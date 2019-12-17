//
//  PhyRecomModel.m
//  HJZSU
//
//  Created by apple on 2019/3/26.
//  Copyright © 2019 apple. All rights reserved.
//

#import "PhyRecomModel.h"

@implementation PRComment

- (void)uploadModelWithReply:(NSDictionary *)info{
    /*@property (strong,nonatomic) NSString *content;
     @property (strong,nonatomic) NSString *createTime;
     @property (strong,nonatomic) NSString *fromHead;
     @property (strong,nonatomic) NSString *fromName;
     @property (strong,nonatomic) NSString *fromUid;
     @property (strong,nonatomic) NSString *id;
     @property (strong,nonatomic) NSString *toName;
     @property (strong,nonatomic) NSString *toUid;*/
    
    self.content = info[@"content"];
    self.createTime = info[@"createTime"];
    self.fromHead = info[@"fromHead"];
    self.fromName = info[@"fromName"];
    self.fromUid = info[@"fromUid"];
    self.id = info[@"id"];
    self.toName = info[@"toName"];
    self.toUid = info[@"toUid"];
    
}
- (void)uploadReplyCellHeight{
    self.cellHeight += 108;
    self.cellHeight += [self sizeWithString:self.content font:[UIFont systemFontOfSize:13] maxSize:CGSizeMake(SCREEN_WIDTH - (76 * 2), MAXFLOAT)].height;
}

- (CGSize)sizeWithString:(NSString *)str font:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *dict = @{NSFontAttributeName: font};
    CGSize textSize = [str boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    return textSize;
}

@end

@implementation PhyRecomModel

- (void)uploadModelWith:(NSDictionary *)info{
    /*"articleId": 3198, //帖子id
     "content": "一楼", //评论内容
     "createTime": 1553138520000, //评论时间戳
     "id": 1376, //评论id
     "userHead": "http://heipa.oss-cn-hangzhou.aliyuncs.com/head/153915074457164512em_default_avatar.png",  //头像
     "userId": 2,   //评论用户id
     "userName": "无敌战神" //评论用户名称
     "reply": [*/
    self.articleId = info[@"articleId"];
    self.content = info[@"content"];
    self.createTime = info[@"createTime"];
    self.id = info[@"id"];
    self.userHead = info[@"userHead"];
    self.userId = info[@"userId"];
    self.userName = info[@"userName"];
    
    NSMutableArray *replay = [NSMutableArray array];
    NSArray *tmp = info[@"reply"];
    if (tmp && tmp.count > 0) {
        for (NSDictionary *info in tmp) {
            PRComment *comment = [[PRComment alloc] init];
            [comment uploadModelWithReply:info];
            [comment uploadReplyCellHeight];
            [replay addObject:comment];
        }
    }
    self.reply = replay;
}

- (void)uploadCellHeight{
    self.cellHeight += 108;
    self.cellHeight += 70;
    self.cellHeight += [self sizeWithString:self.content font:[UIFont systemFontOfSize:13] maxSize:CGSizeMake(SCREEN_WIDTH - (76 * 2), MAXFLOAT)].height;
    if (self.reply && self.reply.count > 0) {
        for (PRComment *model in self.reply) {
            self.cellHeight += model.cellHeight;
        }
    }
    else{
        self.cellHeight -= 40;
    }
}

- (CGSize)sizeWithString:(NSString *)str font:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *dict = @{NSFontAttributeName: font};
    CGSize textSize = [(IsNullString(str) ? @" " : str) boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    return textSize;
}

@end
