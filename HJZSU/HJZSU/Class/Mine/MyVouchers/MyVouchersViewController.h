//
//  MyVouchersViewController.h
//  HJZSU
//
//  Created by apple on 2019/3/14.
//  Copyright © 2019 apple. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface MyVouchersViewController : BaseViewController

@property (assign,nonatomic) BOOL isChooseStyle;

@property (copy,nonatomic) void(^userChooseBlock)(VocherModel *model);

@property (strong,nonatomic) VocherModel *chooiseModel;

@property (assign,nonatomic) NSInteger type;

@end

NS_ASSUME_NONNULL_END
