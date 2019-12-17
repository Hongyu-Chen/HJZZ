//
//  CListTableViewCell.h
//  HJZSU
//
//  Created by apple on 2019/3/12.
//  Copyright © 2019 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CListTableViewCellDelegate  <NSObject>

@optional
- (void)listDelegateComm:(id)model andType:(NSInteger)index;

@end

NS_ASSUME_NONNULL_BEGIN

@interface CListTableViewCell : UITableViewCell

- (void)relpayCotentReload:(PRComment *)model;
@property (assign,nonatomic) id<CListTableViewCellDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
