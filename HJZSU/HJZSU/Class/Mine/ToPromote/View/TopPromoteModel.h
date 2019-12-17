//
//  TopPromoteModel.h
//  HJZSU
//
//  Created by apple on 2019/3/31.
//  Copyright © 2019 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TopPromoteModel : NSObject
/*
 "head": "https://hjzsmy.oss-cn-shanghai.aliyuncs.com/%22user%22/155306893509462588Luban_1553068934499.jpg",
 "id": 10008,
 "name": "测试"*/

@property (strong,nonatomic) NSString *head;
@property (assign,nonatomic) NSInteger id;
@property (strong,nonatomic) NSString *name;

@end

NS_ASSUME_NONNULL_END
