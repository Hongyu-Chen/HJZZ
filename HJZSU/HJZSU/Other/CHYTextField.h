//
//  CHYTextField.h
//  ModelPage
//
//  Created by pro1 on 2018/10/24.
//  Copyright © 2018 pro1. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CHYTextField : UITextField

//限制输入长度  默认maxLength == 0 时不限制长度
@property (assign,nonatomic) NSInteger maxLength;
//实时返回用户输入的数据
@property (copy,nonatomic) void(^inputTextBlock)(NSString *inputText);

@property (strong,nonatomic) UIColor *placeholderColor;


@end

NS_ASSUME_NONNULL_END
