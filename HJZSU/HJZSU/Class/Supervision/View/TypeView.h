//
//  TypeView.h
//  HJZSU
//
//  Created by apple on 2019/3/25.
//  Copyright © 2019 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TypeView : UIView

@property (strong,nonatomic) NSArray *titles;
@property (assign,nonatomic) NSInteger selectedIndex;
@property (copy,nonatomic) void(^choiseIndex)(NSInteger selectedIndex);

@end

NS_ASSUME_NONNULL_END
