//
//  MCollTableViewCell.h
//  HJZSU
//
//  Created by apple on 2019/3/14.
//  Copyright © 2019 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MCollTableViewCell : UITableViewCell

@property (strong,nonatomic) TeamListModel *model;
@property (copy,nonatomic) void(^deleteCell)(TeamListModel *model);

@end

NS_ASSUME_NONNULL_END
