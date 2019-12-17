//
//  VoucherTableViewCell.h
//  HJZSU
//
//  Created by apple on 2019/3/14.
//  Copyright © 2019 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface VoucherTableViewCell : UITableViewCell

@property (strong,nonatomic) VocherModel *model;

@property (assign,nonatomic) BOOL ischooseStyle;

@end

NS_ASSUME_NONNULL_END
