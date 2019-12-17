//
//  MessageModel.h
//  HJZSU
//
//  Created by pro1 on 2019/4/12.
//  Copyright © 2019 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MessageModel : NSObject

@property (strong,nonatomic) NSString *content;
@property (strong,nonatomic) NSString *create_time;
@property (strong,nonatomic) NSString *id;
@property (strong,nonatomic) NSString *title;

@end

NS_ASSUME_NONNULL_END
