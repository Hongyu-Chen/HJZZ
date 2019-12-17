//
//  IsDoneSelectedView.h
//  HJZSU
//
//  Created by apple on 2019/5/25.
//  Copyright © 2019 apple. All rights reserved.
//

#import "BasePopupMenu.h"

NS_ASSUME_NONNULL_BEGIN

@interface IsDoneSelectedView : BasePopupMenu

+ (void)showView:(NSString *)className info:(NSDictionary *)info userBlock:(void(^)(NSInteger index,id value))userPressedBlock;

@end

NS_ASSUME_NONNULL_END
