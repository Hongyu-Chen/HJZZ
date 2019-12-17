//
//  CommBottomView.m
//  HJZSU
//
//  Created by apple on 2019/3/12.
//  Copyright © 2019 apple. All rights reserved.
//

#import "CommBottomView.h"

@interface CommBottomView ()<QMUITextViewDelegate>

@property (strong,nonatomic) QMUITextView *inputText;
@property (strong,nonatomic) UIButton *keyBord;

@end

@implementation CommBottomView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColorMake(239, 239, 239);
        [self addSubview:self.inputText];
        [self addSubview:self.keyBord];
    }
    return self;
}

- (QMUITextView *)inputText{
    if (!_inputText) {
        _inputText = [[QMUITextView alloc] initWithFrame:CGRectMake(13, 8.5, self.frame.size.width - 65, 33)];
        _inputText.layer.cornerRadius = 3;
        _inputText.layer.borderWidth = 1.0;
        _inputText.layer.borderColor = UIColorMake(137, 137, 137).CGColor;
        _inputText.textColor = UIColorMake(34, 34, 34);
        _inputText.placeholderColor = UIColorMake(137, 137, 137);
        _inputText.placeholder = @"输入文字...";
        _inputText.delegate = self;
        _inputText.maximumHeight = 100;
    }
    return _inputText;
}

- (UIButton *)keyBord{
    if (!_keyBord) {
        _keyBord = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width - 53, 0, 53, 50)];
        _keyBord.imageEdgeInsets = UIEdgeInsetsMake(0, 13, 0, 13);
        [_keyBord setImage:[UIImage imageNamed:@"键盘-上"] forState:UIControlStateNormal];
        _keyBord.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [_keyBord addTarget:self action:@selector(submitPressed) forControlEvents:UIControlEventTouchUpInside];
    }
    return _keyBord;
}

- (void)textView:(QMUITextView *)textView newHeightAfterTextChanged:(CGFloat)height{
    CGFloat heightnow = height;
    if (height < 33) {
        heightnow = 33;
    }
    _inputText.frame = CGRectMake(13, 8.5, self.frame.size.width - 65, heightnow);
    CGRect frame = self.frame;
    frame.origin.y = SCREEN_HEIGHT - SafeAreaInsetsConstantForDeviceWithNotch.bottom - 17 - heightnow;
    self.frame = frame;
}

- (void)beginEditText{
    [_inputText becomeFirstResponder];
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    [textView resignFirstResponder];
    if (self.userSubmitReply && !IsNullString(textView.text)) {
        self.userSubmitReply(textView.text);
    }
    else{
        [QMUITips showError:@"请输入内容"];
    }
}

- (void)submitPressed{
    [self.inputText resignFirstResponder];
//    if (self.userSubmitReply && !IsNullString(self.inputText.text)) {
//        self.userSubmitReply(_inputText.text);
//    }
//    else{
//        [QMUITips showError:@"请输入内容"];
//    }
}
- (void)restBottomView{
    _inputText.text = @"";
    CGFloat heightnow = 33;
    _inputText.frame = CGRectMake(13, 8.5, self.frame.size.width - 65, heightnow);
    CGRect frame = self.frame;
    frame.origin.y = SCREEN_HEIGHT - SafeAreaInsetsConstantForDeviceWithNotch.bottom - 17 - heightnow;
    self.frame = frame;
}

@end
