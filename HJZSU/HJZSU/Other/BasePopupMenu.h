//
//  BasePopupMenu.h
//  HJZSU
//
//  Created by apple on 2019/3/9.
//  Copyright © 2019 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,BasePopupMenuAnimationType) {
    BasePopupMenuAnimationTypeNormal = 0,
    BasePopupMenuAnimationTypeAlert,
};


@interface BasePopupMenu : UIView

@property (assign,nonatomic) BasePopupMenuAnimationType type;
@property (assign,nonatomic) CGRect contentFrame;
@property (strong,nonatomic) UIView *contentView;
@property (strong,nonatomic) NSString *loadType;

@property (assign,nonatomic) BOOL tapCanel;

@property (copy,nonatomic) void (^viewButtonPressedBlock)(NSInteger index,id value);
- (void)showView;
- (void)hiddenView;
- (void)typeViewButtonPressed:(UIButton *)sender;
+ (id)showView:(NSString *)className loadDataType:(NSString *)type userBlock:(void(^)(NSInteger index,id value))userPressedBlock;
+ (void)showView:(NSString *)className userBlock:(void(^)(NSInteger index,id value))userPressedBlock;
+ (void)hiddenSubmitType;

@end

