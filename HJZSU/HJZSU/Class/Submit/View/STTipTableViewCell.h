//
//  STTipTableViewCell.h
//  HJZSU
//
//  Created by apple on 2019/3/11.
//  Copyright © 2019 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SubmitModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface STTipTableViewCell : UITableViewCell
@property (strong,nonatomic) SubmitModel *subMitModel;
@property (strong,nonatomic) PlanModel *model;
@property (copy,nonatomic) void(^selectionBlock)(PlanModel *model,BOOL state);

@end

NS_ASSUME_NONNULL_END
