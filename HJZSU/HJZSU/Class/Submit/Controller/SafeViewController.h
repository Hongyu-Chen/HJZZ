//
//  SafeViewController.h
//  HJZSU
//
//  Created by apple on 2019/3/11.
//  Copyright © 2019 apple. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SafeViewController : BaseViewController

@property (assign,nonatomic) NSInteger pageID;
@property (copy,nonatomic) void(^safeBlock)(SafeModel *model,VocherModel *vocherModel);
@property (strong,nonatomic) SafeModel *selectedModel;
@property (strong,nonatomic) VocherModel *chooiseModel;
//@property ()


@end

NS_ASSUME_NONNULL_END
