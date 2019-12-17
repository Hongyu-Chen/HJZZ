//
//  SubmitTipView.m
//  HJZSU
//
//  Created by apple on 2019/3/6.
//  Copyright © 2019 apple. All rights reserved.
//

#import "SubmitTipView.h"

@interface SubmitTipView ()

@property (strong,nonatomic) UIView *bgView;

@property (strong,nonatomic) UIButton *canel;

@end

@implementation SubmitTipView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColorMakeWithRGBA(51, 51, 51, 0.0);
        
        
        [self addSubview:self.bgView];
        [self.bgView addSubview:self.canel];
        [_canel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.bgView).offset(-SafeAreaInsetsConstantForDeviceWithNotch.bottom - 10);
            make.left.equalTo(self.bgView).offset((self.bgView.frame.size.width - 110)/2);
            make.width.offset(110);
            make.height.offset(40);
        }];
    }
    return self;
}

- (void)showView{
    [UIView animateWithDuration:0.3 animations:^{
        self.backgroundColor = UIColorMakeWithRGBA(51, 51, 51, 0.3);
        self.bgView.center = CGPointMake(self.frame.size.width/2, self.frame.size.height - self.bgView.frame.size.height/2);
    }];
}
- (void)hiddenView{
    [UIView animateWithDuration:0.3 animations:^{
        self.backgroundColor = UIColorMakeWithRGBA(51, 51, 51, 0.0);
        self.bgView.center = CGPointMake(self.frame.size.width/2, self.frame.size.height + self.bgView.frame.size.height/2);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height, self.frame.size.width, 230 + SafeAreaInsetsConstantForDeviceWithNotch.bottom)];
        _bgView.backgroundColor = [UIColor whiteColor];
        
        UILabel *tip = [LabelCreat creatLabelWith:@"发布活动" font:[UIFont boldSystemFontOfSize:18] color:UIColorMake(51, 51, 51) textAlignment:NSTextAlignmentCenter];
        [_bgView addSubview:tip];
        [tip mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.bgView).offset(0);
            make.left.right.equalTo(self.bgView).offset(0);
            make.height.offset(75);
        }];
        
        CGFloat width = SCREEN_WIDTH/5;
        CGFloat height = 230 - 138;
        for (int i = 0; i < 5; i++) {
            QMUIButton *button = [[QMUIButton alloc] initWithFrame:CGRectMake(i * width, 70, width, height)];
            [button setTitle:@[@"单店",@"商场",@"联盟",@"联动",@"实战培训"][i] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:@[@"弹框-单店",@"弹框-商场",@"弹框-联盟",@"弹框-联动",@"弹框-实战培训"][i]] forState:UIControlStateNormal];
            button.imagePosition = QMUIButtonImagePositionTop;
            button.titleLabel.font = [UIFont systemFontOfSize:14];
            [button setTitleColor:UIColorMake(51, 51, 51) forState:UIControlStateNormal];
            button.tag = 100 + i + 1;
//            button.imageView.backgroundColor = [UIColor blackColor];
            button.imageView.contentMode = UIViewContentModeScaleAspectFit;
//            button.backgroundColor = [UIColor redColor];
            button.spacingBetweenImageAndTitle = 15;
            [button addTarget:self action:@selector(typeViewButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
            [_bgView addSubview:button];
        }
        
    }
    return _bgView;
}

+ (void)showSubmitTypeViewUserBlock:(void(^)(NSInteger index))userPressedBlock{
    SubmitTipView *view = [[SubmitTipView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    __weak typeof(view) weakself = view;
    view.submitTypeButtonPressedBlock = ^(NSInteger index) {
        [weakself hiddenView];
        userPressedBlock(index);
    };
    view.tag = 10010;
    [[UIApplication sharedApplication].keyWindow addSubview:view];
    [view showView];
}
+ (void)hiddenSubmitType{
    SubmitTipView *tmp = [[UIApplication sharedApplication].keyWindow viewWithTag:10010];
    [tmp hiddenView];
}

- (UIButton *)canel{
    if (!_canel) {
        _canel = [[UIButton alloc] init];
        [_canel setImage:[UIImage imageNamed:@"发布-弹框"] forState:UIControlStateNormal];
        _canel.imageView.contentMode = UIViewContentModeScaleAspectFit;
        _canel.imageEdgeInsets = UIEdgeInsetsMake(5, 0, 5, 0);
        _canel.tag = 100;
        [_canel addTarget:self action:@selector(typeViewButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _canel;
}

- (void)typeViewButtonPressed:(UIButton *)sender{
    if (self.submitTypeButtonPressedBlock) {
        self.submitTypeButtonPressedBlock(sender.tag - 100);
    }
}

@end
