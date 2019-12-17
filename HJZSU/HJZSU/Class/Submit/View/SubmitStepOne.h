//
//  SubmitStepOne.h
//  HJZSU
//
//  Created by apple on 2019/3/9.
//  Copyright © 2019 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SubmitModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SubmitStepOne : UIView

@property (copy,nonatomic) void(^nextCellpressedBlock)(NSInteger index);
@property (strong,nonatomic) SubmitModel *model;

@end

NS_ASSUME_NONNULL_END
