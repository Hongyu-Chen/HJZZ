//
//  SubmitTipView.h
//  HJZSU
//
//  Created by apple on 2019/3/6.
//  Copyright © 2019 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SubmitTipView : UIView

@property (copy,nonatomic) void (^submitTypeButtonPressedBlock)(NSInteger index);
- (void)showView;
- (void)hiddenView;


+ (void)showSubmitTypeViewUserBlock:(void(^)(NSInteger index))userPressedBlock;
+ (void)hiddenSubmitType;


@end

NS_ASSUME_NONNULL_END
