//
//  CanelOrderView.h
//  HJZSU
//
//  Created by apple on 2019/3/14.
//  Copyright © 2019 apple. All rights reserved.
//

#import "BasePopupMenu.h"

NS_ASSUME_NONNULL_BEGIN

@interface CanelOrderView : BasePopupMenu

- (void)reloadResonList;

- (void)updateWithCanel:(BuySafe *)model;



@end

NS_ASSUME_NONNULL_END
