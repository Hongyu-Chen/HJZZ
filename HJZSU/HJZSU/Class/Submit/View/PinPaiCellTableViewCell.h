//
//  PinPaiCellTableViewCell.h
//  HJZSU
//
//  Created by apple on 2019/5/17.
//  Copyright © 2019 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PinPaiCellTableViewCell : UITableViewCell

@property (strong,nonatomic) PlanModel *model;
@property (strong,nonatomic) SubmitModel *submitModel;
@property (copy,nonatomic) void(^numberChangedBlock)(BOOL state);

@end

NS_ASSUME_NONNULL_END
