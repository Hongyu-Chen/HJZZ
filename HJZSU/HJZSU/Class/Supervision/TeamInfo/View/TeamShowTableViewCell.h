//
//  TeamShowTableViewCell.h
//  HJZSU
//
//  Created by apple on 2019/3/13.
//  Copyright © 2019 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TeamShowTableViewCell : UITableViewCell

@property (assign,nonatomic) NSInteger type;
@property (strong,nonatomic) NSDictionary *info;

@end

NS_ASSUME_NONNULL_END
