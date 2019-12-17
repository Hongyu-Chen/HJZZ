//
//  PVTableViewCell.h
//  HJZSU
//
//  Created by apple on 2019/3/7.
//  Copyright © 2019 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PVTableViewCell : UITableViewCell

@property (strong,nonatomic) NSDictionary *cellInfo;

@property (copy,nonatomic) void(^userDeleteSuccess)(void);

@end

NS_ASSUME_NONNULL_END
