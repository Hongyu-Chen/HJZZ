//
//  SubmitStepDone.h
//  HJZSU
//
//  Created by apple on 2019/3/9.
//  Copyright © 2019 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SubmitModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SubmitStepDone : UIView

//@property (copy,nonatomic) void(^nextCellpressedBlock)(NSInteger index);
@property (strong,nonatomic) SubmitModel *model;

- (void)reloadView;

@end

NS_ASSUME_NONNULL_END
