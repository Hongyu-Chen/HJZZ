//
//  CommView.h
//  HJZSU
//
//  Created by apple on 2019/3/12.
//  Copyright © 2019 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CommViewDelegate <NSObject>

@optional

- (void)replyButtonPressedWith:(id)model andType:(NSInteger)index;

@end

NS_ASSUME_NONNULL_BEGIN

@interface CommView : UIView

- (void)uploadRecommModel:(PhyRecomModel *)model;
- (void)uploadReplyModel:(PRComment *)model;

@property (assign,nonatomic)id<CommViewDelegate> delegate;


@end

NS_ASSUME_NONNULL_END
