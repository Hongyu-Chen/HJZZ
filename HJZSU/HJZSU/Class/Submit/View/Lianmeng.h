//
//  Lianmeng.h
//  HJZSU
//
//  Created by apple on 2019/5/17.
//  Copyright © 2019 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Lianmeng : UIView

@property (copy,nonatomic) void(^nextCellpressedBlock)(NSInteger index);
@property (strong,nonatomic) SubmitModel *model;

@end

NS_ASSUME_NONNULL_END
