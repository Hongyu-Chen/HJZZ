//
//  TypeView.m
//  HJZSU
//
//  Created by apple on 2019/3/25.
//  Copyright © 2019 apple. All rights reserved.
//

#import "TypeView.h"

@interface TypeView ()


@end

@implementation TypeView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        for (int i = 0; i < 3; i++) {
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(13 + i * (103), 15, 90, 30)];
            [button setTitle:@"" forState:UIControlStateNormal];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
            [button setTitleColor:UIColorMake(137, 137, 137) forState:UIControlStateNormal];
            button.tag = 100 + i;
            button.layer.borderColor = UIColorMake(137, 137, 137).CGColor;
            button.layer.borderWidth = 0.5;
            button.layer.cornerRadius = 5;
            button.titleLabel.font = [UIFont systemFontOfSize:13];
            [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
        }
    }
    return self;
}

- (void)setSelectedIndex:(NSInteger)selectedIndex{
    _selectedIndex = selectedIndex;
    UIButton *tmp = [self viewWithTag:100 + _selectedIndex];
    tmp.selected = YES;
    tmp.layer.borderWidth = 0.0;
    tmp.backgroundColor = UIColorMake(255, 80, 0);
}

- (void)buttonPressed:(UIButton *)sender{
    if (sender.selected) {
        return;
    }
    for (int i = 0; i < 3; i++) {
        UIButton *tmp = [self viewWithTag:100 + i];
        if (sender.tag == tmp.tag) {
            sender.selected = YES;
            sender.layer.borderWidth = 0.0;
            sender.backgroundColor = UIColorMake(255, 80, 0);
            if (self.choiseIndex) {
                self.choiseIndex(i);
            }
        }
        else{
            tmp.selected = NO;
            tmp.backgroundColor = [UIColor whiteColor];
            tmp.layer.borderWidth = 0.5;
        }
    }
}

- (void)setTitles:(NSArray *)titles{
    _titles = titles;
    if (_titles) {
        for (int i = 0; i < 3; i++) {
            UIButton *tmp = [self viewWithTag:100 + i];
            if (i < _titles.count) {
                tmp.hidden = NO;
                [tmp setTitle:_titles[i] forState:UIControlStateNormal];
            }
            else{
                tmp.hidden = YES;
            }
        }
    }
}

@end
