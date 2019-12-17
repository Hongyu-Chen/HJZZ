//
//  STNTableViewCell.h
//  HJZSU
//
//  Created by apple on 2019/3/11.
//  Copyright © 2019 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SubmitModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface STNTableViewCell : UITableViewCell

@property (strong,nonatomic) NSIndexPath *indexPath;

@property (strong,nonatomic) SubmitModel *model;

@property (assign,nonatomic) NSInteger type;

@end

NS_ASSUME_NONNULL_END
