//
//  BasePopupMenu.m
//  HJZSU
//
//  Created by apple on 2019/3/9.
//  Copyright © 2019 apple. All rights reserved.
//

#import "BasePopupMenu.h"


@implementation BasePopupMenu

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.type = BasePopupMenuAnimationTypeNormal;
        
        self.backgroundColor = UIColorMakeWithRGBA(51, 51, 51, 0.3);
        [self addSubview:self.contentView];
        self.userInteractionEnabled = YES;
        self.tapCanel = YES;
        UITapGestureRecognizer *canelTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tanCanel:)];
        [self addGestureRecognizer:canelTap];
    }
    return self;
}

- (UIView *)contentView{
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height, self.frame.size.width, 255)];
        _contentView.backgroundColor = UIColorMake(239, 239, 239);
    }
    return _contentView;
}

- (void)setContentFrame:(CGRect)contentFrame{
    _contentFrame = contentFrame;
    self.contentView.frame = _contentFrame;
}

- (void)showView{
    if (self.type == BasePopupMenuAnimationTypeNormal) {
        [UIView animateWithDuration:0.3 animations:^{
            self.backgroundColor = UIColorMakeWithRGBA(51, 51, 51, 0.3);
            self.contentView.center = CGPointMake(self.frame.size.width/2, self.frame.size.height - self.contentView.frame.size.height/2);
        }];
    }
    else if (self.type == BasePopupMenuAnimationTypeAlert){
        self.contentView.transform = CGAffineTransformScale(self.contentView.transform, 0.1, 0.1);
        [UIView animateWithDuration:0.3 animations:^{
            self.backgroundColor = UIColorMakeWithRGBA(51, 51, 51, 0.3);
            self.contentView.transform = CGAffineTransformIdentity;
        }];
    }
}
- (void)hiddenView{
    if (self.type == BasePopupMenuAnimationTypeNormal) {
        [UIView animateWithDuration:0.3 animations:^{
            self.backgroundColor = UIColorMakeWithRGBA(51, 51, 51, 0.0);
            self.contentView.center = CGPointMake(self.frame.size.width/2, self.frame.size.height + self.contentView.frame.size.height/2);
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }
    else if(self.type == BasePopupMenuAnimationTypeAlert){
        [UIView animateWithDuration:0.3 animations:^{
            self.backgroundColor = UIColorMakeWithRGBA(51, 51, 51, 0.0);
            self.contentView.transform = CGAffineTransformScale(self.contentView.transform, 0.1, 0.1);
        } completion:^(BOOL finished) {
            self.contentView.transform = CGAffineTransformIdentity;
            [self removeFromSuperview];
        }];
    }
}

- (void)tanCanel:(UITapGestureRecognizer *)sender{
    if (self.tapCanel) {
        [self hiddenView];
    }
}

+ (id)showView:(NSString *)className loadDataType:(NSString *)type  userBlock:(void(^)(NSInteger index,id value))userPressedBlock{
    id obj = [[NSClassFromString(className) alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    BasePopupMenu *View = (BasePopupMenu *)obj;
    View.loadType = type;
    __weak typeof(View) weakself = View;
    View.viewButtonPressedBlock = ^(NSInteger index,id value) {
        [weakself hiddenView];
        userPressedBlock(index,value);
    };
    View.tag = 10010;
    [[UIApplication sharedApplication].keyWindow addSubview:View];
    [View showView];
    return obj;
}

+ (void)showView:(NSString *)className userBlock:(void(^)(NSInteger index,id value))userPressedBlock{
    id obj = [[NSClassFromString(className) alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    BasePopupMenu *View = (BasePopupMenu *)obj;
    __weak typeof(View) weakself = View;
    View.viewButtonPressedBlock = ^(NSInteger index,id value) {
        [weakself hiddenView];
        userPressedBlock(index,value);
    };
    View.tag = 10010;
    [[UIApplication sharedApplication].keyWindow addSubview:View];
    [View showView];
}

+ (void)hiddenSubmitType{
    BasePopupMenu *tmp = [[UIApplication sharedApplication].keyWindow viewWithTag:10010];
    [tmp hiddenView];
}

- (void)typeViewButtonPressed:(UIButton *)sender{
    if (self.viewButtonPressedBlock) {
        self.viewButtonPressedBlock(sender.tag - 100,nil);
    }
}


@end
