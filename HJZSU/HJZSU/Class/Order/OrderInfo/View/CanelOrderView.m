//
//  CanelOrderView.m
//  HJZSU
//
//  Created by apple on 2019/3/14.
//  Copyright © 2019 apple. All rights reserved.
//

#import "CanelOrderView.h"

@interface CanelOrderView ()

@property (strong,nonatomic) QMUIButton *resonOne;
@property (strong,nonatomic) QMUIButton *resonTwo;
@property (strong,nonatomic) QMUIButton *resonThere;
@property (strong,nonatomic) UIButton *canelBtn;
@property (strong,nonatomic) UIButton *sureBtn;
@property (strong,nonatomic) QMUITextView *textView;
@property (strong,nonatomic) NSArray *resonList;
@property (strong,nonatomic) UILabel *tip;
@property (strong,nonatomic) UILabel *value;

@end

@implementation CanelOrderView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.contentFrame = CGRectMake(13, (self.frame.size.height - 412)/2, self.frame.size.width - 26, 412);
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.contentView.layer.cornerRadius = 10;
        self.contentView.clipsToBounds = YES;
        self.type = BasePopupMenuAnimationTypeAlert;
        
        UILabel *title = [LabelCreat creatLabelWith:@"取消原因" font:[UIFont boldSystemFontOfSize:18] color:UIColorMake(255, 80, 0) textAlignment:NSTextAlignmentCenter];
        self.tip = [LabelCreat creatLabelWith:@"线下交易，出现财产损失与本平台无关。" font:[UIFont systemFontOfSize:12] color:UIColorMake(13, 13, 13) textAlignment:NSTextAlignmentLeft];
        self.value = [LabelCreat creatLabelWith:@"" font:[UIFont systemFontOfSize:12] color:UIColorMake(13, 13, 13) textAlignment:NSTextAlignmentLeft];
        self.resonOne = [self creatResonButtonWith:200 andTitle:@"取消原因一"];
        self.resonTwo = [self creatResonButtonWith:201 andTitle:@"取消原因二"];
        self.resonThere = [self creatResonButtonWith:202 andTitle:@"取消原因三"];
        [self.contentView addSubview:title];
        [self.contentView addSubview:self.value];
        [self.contentView addSubview:self.resonOne];
        [self.contentView addSubview:self.resonTwo];
        [self.contentView addSubview:self.resonThere];
        [self.contentView addSubview:self.textView];
        [self.contentView addSubview:self.canelBtn];
        [self.contentView addSubview:self.sureBtn];
        [self.contentView addSubview:self.tip];
        
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self.contentView).offset(0);
            make.height.offset(50);
        }];
        
        [_value mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(title.mas_bottom).offset(0);
            make.left.equalTo(self.contentView).offset(13);
            make.right.equalTo(self.contentView).offset(-13);
        }];
        
        [_resonOne mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(title.mas_bottom).offset(15);
            make.left.equalTo(self.contentView).offset(13);
            make.right.equalTo(self.contentView).offset(-13);
            make.height.offset(50);
        }];
        
        [_resonTwo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.resonOne.mas_bottom).offset(0);
            make.left.equalTo(self.contentView).offset(13);
            make.right.equalTo(self.contentView).offset(-13);
            make.height.offset(50);
        }];
        
        [_resonThere mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.resonTwo.mas_bottom).offset(0);
            make.left.equalTo(self.contentView).offset(13);
            make.right.equalTo(self.contentView).offset(-13);
            make.height.offset(50);
        }];
        
        [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.resonThere.mas_bottom).offset(15);
            make.left.equalTo(self.contentView).offset(13);
            make.right.equalTo(self.contentView).offset(-13);
            make.height.offset(90);
        }];
        
        [_tip mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.textView.mas_bottom).offset(10);
            make.left.equalTo(self.contentView).offset(13);
        }];
        
        [_canelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.textView.mas_bottom).offset(32);
            make.left.equalTo(self.contentView).offset(13);
            make.height.offset(40);
        }];
        
        [_sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.textView.mas_bottom).offset(32);
            make.left.equalTo(self.canelBtn.mas_right).offset(13);
            make.right.equalTo(self.contentView).offset(-13);
            make.height.offset(40);
            make.width.equalTo(self.canelBtn);
        }];
        
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = UIColorMake(220, 220, 220);
        [self.contentView addSubview:line];
        
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(title.mas_bottom).offset(15);
            make.left.equalTo(self.contentView).offset(13);
            make.right.equalTo(self.contentView).offset(-13);
            make.height.offset(1);
        }];
        
    }
    return self;
}

- (QMUIButton *)creatResonButtonWith:(NSInteger)tag andTitle:(NSString *)title{
    QMUIButton *button = [[QMUIButton alloc] init];
    [button setImage:[UIImage imageNamed:@"勾选-未选中"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"勾选"] forState:UIControlStateSelected];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:UIColorMake(34, 34, 34) forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    button.spacingBetweenImageAndTitle = 13;
    button.tag = tag;
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [button addTarget:self action:@selector(resonButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

- (UIButton *)canelBtn{
    if (!_canelBtn) {
        _canelBtn = [[UIButton alloc] init];
        [_canelBtn setTitleColor:UIColorMake(34, 34, 34) forState:UIControlStateNormal];
        _canelBtn.layer.cornerRadius = 5;
        _canelBtn.layer.borderColor = UIColorMake(239, 239, 239).CGColor;
        _canelBtn.layer.borderWidth = 1.0;
        [_canelBtn setTitle:@"取消" forState:UIControlStateNormal];
        _canelBtn.tag = 100;
        _canelBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        [_canelBtn addTarget:self action:@selector(typeViewButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _canelBtn;
}

- (UIButton *)sureBtn{
    if (!_sureBtn) {
        _sureBtn = [[UIButton alloc] init];
        [_sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        _sureBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        _sureBtn.backgroundColor = UIColorMake(255, 80, 0);
        _sureBtn.layer.cornerRadius = 5;
        _sureBtn.tag = 101;
        [_sureBtn addTarget:self action:@selector(typeViewButtonPressedCanel:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureBtn;
}

- (void)typeViewButtonPressedCanel:(UIButton *)sender{
    if (self.viewButtonPressedBlock) {
        NSMutableDictionary *tmp = [[NSMutableDictionary alloc] init];
        if (self.resonOne.selected || self.resonTwo.selected || self.resonThere.selected) {
            NSInteger index = self.resonOne.selected ? 0 : self.resonTwo.selected ? 1 : 2;
            tmp = [self.resonList[index] mutableCopy];
        }
        if (!IsNullString(self.textView.text)) {
            [tmp setObject:self.textView.text forKey:@"other"];
            
        }
        
        if (tmp.count != 0) {
            self.viewButtonPressedBlock(1, tmp);
        }
        else{
            [QMUITips showError:@"请说明取消原因"];
        }
    }
}

- (QMUITextView *)textView{
    if (!_textView) {
        _textView = [[QMUITextView alloc] init];
        _textView.backgroundColor = UIColorMake(239, 239, 239);
        _textView.font = [UIFont systemFontOfSize:13];
        _textView.textColor = UIColorMake(34, 34, 34);
        _textView.placeholder = @"请填写取消原因";
        _textView.placeholderColor = UIColorMake(137, 137, 137);
        _textView.placeholderMargins = UIEdgeInsetsMake(5, 5, 5, 5);
        _textView.clipsToBounds = YES;
        _textView.layer.cornerRadius = 5;
    }
    return _textView;
}

- (void)resonButtonPressed:(UIButton *)sender{
    for (int i = 0; i < 3; i++) {
        QMUIButton *tmp = [self viewWithTag:200 + i];
        if (sender.tag == (i + 200)) {
            tmp.selected = YES;
        }
        else{
            tmp.selected = NO;
        }
    }
}

- (void)reloadResonList{
    [self getResonWithCode:self.loadType success:^(id  _Nonnull result) {
        [self setResonList:result];
        [self reloadViewData];
    } failed:^(NSString * _Nonnull reson) {
        [QMUITips showError:reson];
    }];
}

- (void)updateWithCanel:(BuySafe *)model{
    self.value.text = [NSString stringWithFormat:@"购买%.0f元->可退%.0f元",model.buy_money/100,model.back_money/100];
    self.tip.text = @"申请提交后2个工作日达到余额账户";
}


- (void)reloadViewData{
    NSArray *listBtn = @[self.resonOne,self.resonTwo,self.resonThere];
    for (int i = 0; i < 3; i++) {
        QMUIButton *tmp = listBtn[i];
        if (i < self.resonList.count) {
            tmp.hidden = NO;
            [tmp setTitle:self.resonList[i][@"content"] forState:UIControlStateNormal];
        }
        else{
            tmp.hidden = YES;
        }
    }
}

@end
