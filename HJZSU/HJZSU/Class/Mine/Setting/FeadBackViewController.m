//
//  FeadBackViewController.m
//  HJZSS
//
//  Created by apple on 2019/3/4.
//  Copyright © 2019 apple. All rights reserved.
//

#import "FeadBackViewController.h"

@interface FeadBackViewController ()

@property (strong,nonatomic) QMUITextView *textView;
@property (strong,nonatomic) UIButton *sure;

@end

@implementation FeadBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleLab.text = @"反馈建议";
    
    [self.view addSubview:self.textView];
    [self.view addSubview:self.sure];
    
    [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(NavigationContentTopConstant);
        make.left.right.equalTo(self.view).offset(0);
        make.height.offset(250);
    }];
    
    [_sure mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textView.mas_bottom).offset(100);
        make.left.equalTo(self.view).offset(13);
        make.right.equalTo(self.view).offset(-13);
        make.height.offset(50);
    }];
    
}

- (QMUITextView *)textView{
    if (!_textView) {
        _textView = [[QMUITextView alloc] init];
        _textView.maximumTextLength = 500;
        _textView.placeholder = @"什么问题可以写下来...";
        _textView.placeholderColor = UIColorMake(137, 137, 137);
        _textView.font = [UIFont boldSystemFontOfSize:15];
        _textView.contentInset = UIEdgeInsetsMake(13, 13, 13, 13);
        _textView.textColor = UIColorMake(51, 51, 51);
    }
    return _textView;
}

- (UIButton *)sure{
    if (!_sure) {
        _sure = [[UIButton alloc] init];
        [_sure setTitle:@"提交" forState:UIControlStateNormal];
        _sure.titleLabel.font = [UIFont systemFontOfSize:15];
        [_sure setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _sure.layer.cornerRadius = 5;
        _sure.backgroundColor = UIColorMake(255, 80, 0);
        [_sure addTarget:self action:@selector(bottomSubmitBottonPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sure;
}
- (void)bottomSubmitBottonPressed:(UIButton *)sender{
    [_textView resignFirstResponder];
    if (IsNullString(_textView.text)) {
        [QMUITips showError:@"请输入内容"];
        return;
    }
    [QMUITips showLoadingInView:self.view];
    [self submitTextWith:_textView.text success:^(id  _Nonnull result) {
        [QMUITips hideAllTips];
        [QMUITips showSucceed:@"反馈提交成功"];
        [self.navigationController popViewControllerAnimated:YES];
    } failed:^(NSString * _Nonnull reson) {
        [QMUITips hideAllTips];
        [QMUITips showError:reson];
    }];
}

@end
