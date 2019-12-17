//
//  MainTabbar.m
//  呼叫战神
//
//  Created by apple on 2019/2/25.
//  Copyright © 2019 apple. All rights reserved.
//

#import "MainTabbar.h"


@interface MainTabbar ()



@end

@implementation MainTabbar

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.barTintColor = [UIColor whiteColor];
        self.translucent = NO;
        [self addSubview:self.plusItem];
    }
    return self;
}

- (QMUIButton *)plusItem{
    if (!_plusItem) {
        _plusItem = [[QMUIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
        _plusItem.backgroundColor = [UIColor clearColor];
        _plusItem.adjustsImageWhenDisabled = NO;
        _plusItem.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [_plusItem setTitle:@"发布活动" forState:UIControlStateNormal];
        [_plusItem setTitleColor:UIColorMake(1, 1, 1) forState:UIControlStateNormal];
        _plusItem.titleLabel.font = [UIFont boldSystemFontOfSize:10];
        _plusItem.imagePosition = QMUIButtonImagePositionTop;
        _plusItem.spacingBetweenImageAndTitle  = 5;
        [_plusItem setImage:[UIImage imageNamed:@"发布"] forState:UIControlStateNormal];
        _plusItem.imageEdgeInsets = UIEdgeInsetsMake((TabBarHeight - SafeAreaInsetsConstantForDeviceWithNotch.bottom - 30)/2, 0, (TabBarHeight - SafeAreaInsetsConstantForDeviceWithNotch.bottom - 30)/2, 0);
    }
    return _plusItem;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat itemWidth = [UIScreen mainScreen].bounds.size.width / (self.items.count + 1);
    //系统自带的按钮类型是UITabBarButton，找出这些类型的按钮，然后重新排布位置，空出中间的位置
    NSInteger index = 0;
    Class class = NSClassFromString(@"UITabBarButton");
    for (UIView *child in self.subviews) {
        if ([child isKindOfClass:class]) {
            CGFloat width = itemWidth;
            CGFloat height = child.frame.size.height;
            CGFloat x = index * width;
            CGFloat y = child.frame.origin.y;
            child.frame = CGRectMake(x, y, width, height);
            index++;
            if (index == self.items.count/2) {
                CGFloat plusX = itemWidth * index;
                CGFloat plusY = 0;
                self.plusItem.frame = CGRectMake(plusX, plusY - 8, itemWidth, TabBarHeight - SafeAreaInsetsConstantForDeviceWithNotch.bottom);
                index++;
            }
        }
    }
    [self bringSubviewToFront:self.plusItem];
}


#pragma mark - 处理超出区域点击无效的问题
-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    if (self.hidden) {
        return [super hitTest:point withEvent:event];
    } else {
        //转换坐标
        CGPoint tempPoint = [self convertPoint:point toView:self.plusItem];
        //判断点击的点是否在按钮区域内
        if ([self.plusItem pointInside:tempPoint withEvent:event]) {
            return self.plusItem;
        } else {
            return [super hitTest:point withEvent:event];
        }
    }
}

@end
