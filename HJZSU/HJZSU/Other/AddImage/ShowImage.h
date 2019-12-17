//
//  ShowImage.h
//  HJZSU
//
//  Created by apple on 2019/3/9.
//  Copyright © 2019 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ShowImage : UIImageView

@property (copy,nonatomic) void(^userWantDeleteImageBlock)(NSInteger tag,NSInteger type);


//@property (strong,nonatomic,readonly)

- (void)hiddenDeleteBtnWith:(BOOL)state;

@property (strong,nonatomic) id imageContent;

@end

NS_ASSUME_NONNULL_END
