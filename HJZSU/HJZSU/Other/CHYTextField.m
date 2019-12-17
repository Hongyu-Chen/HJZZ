//
//  CHYTextField.m
//  ModelPage
//
//  Created by pro1 on 2018/10/24.
//  Copyright © 2018 pro1. All rights reserved.
//

#import "CHYTextField.h"
@interface CHYTextField ()<UITextFieldDelegate>

@end

@implementation CHYTextField

- (instancetype)init{
    self = [super init];
    if (self) {
        _maxLength = 0;
        self.delegate = self;
        [self addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return self;
}

- (void)textFieldDidChange:(UITextField *)sender{
    UITextField *textField = sender;
    NSUInteger maxLength = _maxLength;
    if (maxLength == 0) return;
    // text field 的内容
    NSString *contentText = textField.text;
    // 获取高亮内容的范围
    UITextRange *selectedRange = [textField markedTextRange];
    // 这行代码 可以认为是 获取高亮内容的长度
    NSInteger markedTextLength = [textField offsetFromPosition:selectedRange.start toPosition:selectedRange.end];
    // 没有高亮内容时,对已输入的文字进行操作
    if (markedTextLength == 0) {
        // 如果 text field 的内容长度大于我们限制的内容长度
        if (contentText.length > maxLength) {
            NSLog(@"%@", [NSString stringWithFormat:@"超出限制长度 限制长度%ld",maxLength]);
            // 截取从前面开始maxLength长度的字符串
            //            textField.text = [contentText substringToIndex:maxLength];
            // 此方法用于在字符串的一个range范围内，返回此range范围内完整的字符串的range
            NSRange rangeRange = [contentText rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, maxLength)];
            textField.text = [contentText substringWithRange:rangeRange];
        }
        !self.inputTextBlock?:self.inputTextBlock(textField.text);
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    !self.inputTextBlock?:self.inputTextBlock(textField.text);
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    !self.inputTextBlock?:self.inputTextBlock(textField.text);
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor{
    _placeholderColor = placeholderColor;
    if (_placeholderColor) {
         [self setValue:_placeholderColor forKeyPath:@"_placeholderLabel.textColor"];
    }
}

@end
