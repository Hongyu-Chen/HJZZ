//
//  SbmitNextTableViewCell.h
//  HJZSU
//
//  Created by apple on 2019/3/11.
//  Copyright © 2019 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SubmitModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SbmitNextTableViewCell : UITableViewCell

@property (strong,nonatomic) NSString *value;
@property (strong,nonatomic) SubmitModel *model;
@property (strong,nonatomic) UILabel *tipLabel;

@end

NS_ASSUME_NONNULL_END
