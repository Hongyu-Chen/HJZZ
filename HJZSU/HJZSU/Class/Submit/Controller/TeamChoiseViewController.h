//
//  TeamChoiseViewController.h
//  HJZSU
//
//  Created by apple on 2019/3/11.
//  Copyright © 2019 apple. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface TeamChoiseViewController : BaseViewController

@property (copy,nonatomic) void(^choiseTeamBlock)(TeamListModel *model);

@end

NS_ASSUME_NONNULL_END
