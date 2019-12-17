//
//  OrderShowTableViewCell.h
//  HJZSU
//
//  Created by apple on 2019/3/13.
//  Copyright © 2019 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OrderShowTableViewCell : UITableViewCell

@property (strong,nonatomic) NSIndexPath *indexPath;

@property (strong,nonatomic) OrderModelInfo *model;

@property (assign,nonatomic) NSInteger isDone;

@property (strong,nonatomic) VocherModel *vocherModel;

@end

NS_ASSUME_NONNULL_END
