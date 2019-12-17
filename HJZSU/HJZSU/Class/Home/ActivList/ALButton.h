//
//  ALButton.h
//  HJZSS
//
//  Created by apple on 2019/2/27.
//  Copyright © 2019 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ALButton : UIButton

@property (strong,nonatomic) UIImage *iconImage;

@property (strong,nonatomic) NSString *valueStr;

@property (assign,nonatomic) NSInteger style;

//@property ()

@property (copy,nonatomic) void(^buttonPressedBlock)(NSInteger style);

@end

NS_ASSUME_NONNULL_END
