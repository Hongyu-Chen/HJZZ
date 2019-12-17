//
//  HelpViewController.h
//  HJZSS
//
//  Created by apple on 2019/3/4.
//  Copyright © 2019 apple. All rights reserved.
//

#import "BaseViewController.h"

typedef NS_ENUM(NSInteger,HelpStatus) {
    HelpStatusAboutMe = 1,
    HelpStatusQuestion,
    HelpStatusProtol,
};

NS_ASSUME_NONNULL_BEGIN

@interface HelpViewController : BaseViewController

@property (assign,nonatomic) HelpStatus type;

@end

NS_ASSUME_NONNULL_END
