//
//  CommListView.h
//  HJZSU
//
//  Created by apple on 2019/3/12.
//  Copyright © 2019 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CommListViewDelegate <NSObject>

@optional
- (void)listReplyWith:(id)model andType:(NSInteger)index;

@end

NS_ASSUME_NONNULL_BEGIN

@interface CommListView : UIView

@property (strong,nonatomic) NSArray *listData;
@property (assign,nonatomic) id<CommListViewDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
