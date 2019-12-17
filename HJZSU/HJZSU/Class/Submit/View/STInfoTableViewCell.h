//
//  STInfoTableViewCell.h
//  HJZSU
//
//  Created by apple on 2019/3/11.
//  Copyright © 2019 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SubmitModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface STInfoTableViewCell : UITableViewCell

@property (strong,nonatomic) PlanModel *model;
@property (strong,nonatomic) SubmitModel *submitModel;
@property (copy,nonatomic) void(^numberChangedBlock)(BOOL state);

@end

NS_ASSUME_NONNULL_END
