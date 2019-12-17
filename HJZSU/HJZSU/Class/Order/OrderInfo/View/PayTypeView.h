//
//  PayTypeView.h
//  HJZSU
//
//  Created by apple on 2019/3/14.
//  Copyright © 2019 apple. All rights reserved.
//

#import "BasePopupMenu.h"

NS_ASSUME_NONNULL_BEGIN

@interface PayTypeView : BasePopupMenu

@property (strong,nonatomic) OrderModelInfo *model;
@property (assign,nonatomic) BOOL hiddenPage;

+ (void)showView:(NSString *)className info:(OrderModelInfo *)info showView:(UIView *)view userBlock:(void(^)(NSInteger index,id value))userPressedBlock;
+ (void)showTopUPView:(NSString *)className info:(OrderModelInfo *)info userBlock:(void(^)(NSInteger index,id value))userPressedBlock;


- (void)showChooseButton:(BOOL)status;
- (void)showChooseType:(BOOL)status;

+ (void)showPayMonenyWith:(UIView *)view;

- (void)reloadDataWith:(VocherModel *)vochModel;


@end

NS_ASSUME_NONNULL_END
