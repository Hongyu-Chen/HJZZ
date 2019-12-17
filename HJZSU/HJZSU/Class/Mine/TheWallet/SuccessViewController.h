//
//  SuccessViewController.h
//  HJZSS
//
//  Created by apple on 2019/3/4.
//  Copyright © 2019 apple. All rights reserved.
//

#import "BaseViewController.h"

typedef NS_ENUM(NSInteger,SuccessType) {
    SuccessTypeTupUp = 1,
    SuccessTypeWithdrawal,
};

NS_ASSUME_NONNULL_BEGIN

@interface SuccessViewController : BaseViewController

@property (assign,nonatomic) SuccessType type;

@end

NS_ASSUME_NONNULL_END
