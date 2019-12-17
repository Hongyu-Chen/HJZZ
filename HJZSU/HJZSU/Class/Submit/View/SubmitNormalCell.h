//
//  SubmitNormalCell.h
//  HJZSU
//
//  Created by apple on 2019/3/9.
//  Copyright © 2019 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SubmitModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SubmitNormalCell : UITableViewCell

@property (strong,nonatomic) NSIndexPath *indexPath;
@property (strong,nonatomic) NSIndexPath *doenIndexPath;
@property (strong,nonatomic) SubmitModel *model;

@end

NS_ASSUME_NONNULL_END
