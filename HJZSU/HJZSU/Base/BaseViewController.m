//
//  BaseViewController.m
//  呼叫战神
//
//  Created by apple on 2019/2/25.
//  Copyright © 2019 apple. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()




@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColorMake(239, 239, 239);
//    self.navigationController.navigationBar.hidden = YES;
    [self.view addSubview:self.navigationView];
}

- (UIView *)navigationView{
    if (!_navigationView) {
        _navigationView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, NavigationContentTopConstant)];
        _navigationView.backgroundColor = UIColorMake(255, 80, 0);
        [_navigationView addSubview:self.titleLab];
        [_navigationView addSubview:self.leftItem];
        [_navigationView addSubview:self.rightBtn];
    }
    return _navigationView;
}

- (UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] initWithFrame:CGRectMake(NavigationBarHeight, StatusBarHeightConstant, SCREEN_WIDTH - (NavigationBarHeight * 2), NavigationBarHeight)];
        _titleLab.textAlignment = NSTextAlignmentCenter;
        _titleLab.font = [UIFont boldSystemFontOfSize:16];
        _titleLab.textColor = [UIColor whiteColor];
    }
    return _titleLab;
}

- (UIButton *)leftItem{
    if (!_leftItem) {
        _leftItem = [[UIButton alloc] initWithFrame:CGRectMake(0, StatusBarHeightConstant, NavigationBarHeight, NavigationBarHeight)];
        _leftItem.backgroundColor = [UIColor clearColor];
        [_leftItem addTarget:self action:@selector(leftItemButtenPressed:) forControlEvents:UIControlEventTouchUpInside];
        _leftItem.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [_leftItem setImage:[UIImage imageNamed:@"返回-白色"] forState:UIControlStateNormal];
        _leftItem.imageEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
    }
    return _leftItem;
}

- (UIButton *)rightBtn{
    if (!_rightBtn) {
        _rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - NavigationBarHeight, StatusBarHeightConstant, NavigationBarHeight, NavigationBarHeight)];
        _rightBtn.backgroundColor = [UIColor clearColor];
        _rightBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_rightBtn addTarget:self action:@selector(righttemButtenPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightBtn;
}

- (void)leftItemButtenPressed:(UIButton *)sender{
    if (self.navigationController.topViewController == self) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
- (void)righttemButtenPressed:(UIButton *)sender{
    
}

- (void)addReadPoint:(NSInteger)number{
    if (number == 0) {
        return;
    }
    [self removeReadPoint];
    if (![self.rightBtn viewWithTag:90000]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            UILabel *pointView = [LabelCreat creatLabelWith:@"" font:[UIFont systemFontOfSize:8] color:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter];
            pointView.frame = CGRectMake(NavigationBarHeight - 18.5, 6.5, 15, 15);
            pointView.clipsToBounds = YES;
            pointView.backgroundColor= [UIColor redColor];
            pointView.layer.cornerRadius = 7.5;
            pointView.tag = 90000;
            pointView.text = number > 99 ? @"99+" : [[NSString alloc] initWithFormat:@"%ld",number];
            [self.rightBtn addSubview:pointView];
        });
    }
}
- (void)removeReadPoint{
    if ([self.rightBtn viewWithTag:90000]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [[self.rightBtn viewWithTag:90000] removeFromSuperview];
        });
    }
}

//- (void)layoutSubviews {
////    [super layoutSubviews];
//
//    for (UIView *subview in self.navigationController.navigationBar.subviews) {
//        if ([NSStringFromClass([subview class]) containsString:@"_UINavigationBarContentView"]) {
//            if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
//                UIEdgeInsets margins = subview.layoutMargins;
//                subview.frame = CGRectMake(-margins.left, -margins.top, margins.left + margins.right + subview.frame.size.width, margins.top + margins.bottom + subview.frame.size.height);
//            } else {
//                subview.layoutMargins = UIEdgeInsetsZero;
//            }
//            break;
//        }
//    }
//}



@end
