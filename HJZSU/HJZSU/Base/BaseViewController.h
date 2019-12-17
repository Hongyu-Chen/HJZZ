//
//  BaseViewController.h
//  呼叫战神
//
//  Created by apple on 2019/2/25.
//  Copyright © 2019 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseViewController : UIViewController

@property (strong,nonatomic) UIView *navigationView;
@property (strong,nonatomic) UILabel *titleLab;
@property (strong,nonatomic) UIButton *leftItem;
@property (strong,nonatomic) UIButton *rightBtn;

- (void)leftItemButtenPressed:(UIButton *)sender;
- (void)righttemButtenPressed:(UIButton *)sender;
- (void)addReadPoint:(NSInteger)number;
- (void)removeReadPoint;

@end

NS_ASSUME_NONNULL_END
