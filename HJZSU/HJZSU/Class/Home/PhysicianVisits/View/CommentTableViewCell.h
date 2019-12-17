//
//  CommentTableViewCell.h
//  HJZSU
//
//  Created by apple on 2019/3/12.
//  Copyright © 2019 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CommentTableViewCellDelegate <NSObject>

@optional
- (void)replyCommBtnPressed:(id)model andTYpe:(NSInteger)index;

@end

NS_ASSUME_NONNULL_BEGIN

@interface CommentTableViewCell : UITableViewCell

- (void)uploadCellValueWith:(PhyRecomModel *)model;

@property (assign,nonatomic) id<CommentTableViewCellDelegate> delegate;


@end

NS_ASSUME_NONNULL_END
