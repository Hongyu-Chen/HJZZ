//
//  CommBottomView.h
//  HJZSU
//
//  Created by apple on 2019/3/12.
//  Copyright © 2019 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CommBottomView : UIView


- (void)beginEditText;
- (void)restBottomView;
@property (copy,nonatomic) void(^userSubmitReply)(NSString *text);


@end

NS_ASSUME_NONNULL_END
