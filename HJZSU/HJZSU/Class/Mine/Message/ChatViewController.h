//
//  ChatViewController.h
//  HJZSU
//
//  Created by pro1 on 2019/4/11.
//  Copyright © 2019 apple. All rights reserved.
//

#import "EaseMessageViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ChatViewController : EaseMessageViewController

@property (strong,nonatomic) NSString *toUserName;
@property (strong,nonatomic) NSString *toUserHeader;

@end

NS_ASSUME_NONNULL_END
