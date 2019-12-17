//
//  SBImageTableViewCell.h
//  HJZSU
//
//  Created by apple on 2019/3/9.
//  Copyright © 2019 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SubmitModel.h"

@protocol SBImageTableViewCellDelegate <NSObject>

@optional
- (void)userShouldChanedImagewith:(NSInteger)index type:(NSInteger)type;

@end

NS_ASSUME_NONNULL_BEGIN

@interface SBImageTableViewCell : UITableViewCell

@property (strong,nonatomic) NSMutableArray *imagesContent;
@property (assign,nonatomic) id<SBImageTableViewCellDelegate>delegate;
@property (strong,nonatomic) SubmitModel *model;
@property (assign,nonatomic) BOOL onlyShow;

@end

NS_ASSUME_NONNULL_END
