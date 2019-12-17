//
//  OrderListViewController.h
//  HJZSU
//
//  Created by apple on 2019/3/13.
//  Copyright © 2019 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OrderListViewController : UIViewController

@property (assign,nonatomic) NSInteger orderType;

- (void)reloadViewDataWithTableiew;

@end

NS_ASSUME_NONNULL_END
