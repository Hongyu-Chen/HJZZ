//
//  LocationView.m
//  HJZSU
//
//  Created by apple on 2019/3/9.
//  Copyright © 2019 apple. All rights reserved.
//

#import "LocationView.h"

@interface LocationView ()

@property (strong,nonatomic) UIButton *close;
@property (strong,nonatomic) UIButton *canel;
@property (strong,nonatomic) UIButton *sure;
@property (strong,nonatomic) UILabel *titleLab;
@property (strong,nonatomic) QMUITextView *textView;

@end

@implementation LocationView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentFrame = CGRectMake(50, (self.frame.size.height - 172)/2, self.frame.size.width - 100, 172);
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.contentView.layer.cornerRadius = 10;
        self.contentView.clipsToBounds = YES;
        self.type = BasePopupMenuAnimationTypeAlert;
        
        self.titleLab = [LabelCreat creatLabelWith:@"地址" font:[UIFont boldSystemFontOfSize:14] color:UIColorMake(51, 51, 51) textAlignment:NSTextAlignmentCenter];
        [self.contentView addSubview:self.titleLab];
        [self.contentView addSubview:self.textView];
        [self.contentView addSubview:self.close];
        [self.contentView addSubview:self.canel];
        [self.contentView addSubview:self.sure];
        
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).offset(15);
            make.left.right.equalTo(self.contentView).offset(0);
        }];
        
        [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLab.mas_bottom).offset(10);
            make.left.equalTo(self.contentView).offset(13);
            make.right.equalTo(self.contentView).offset(-13);
            make.bottom.equalTo(self.contentView).offset(-56);
        }];
        
        [_close mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.equalTo(self.contentView).offset(0);
            make.width.height.offset(30);
        }];
        
        [_canel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.textView.mas_bottom).offset(13);
            make.left.bottom.equalTo(self.contentView).offset(0);
        }];
        [_sure mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.textView.mas_bottom).offset(13);
            make.right.bottom.equalTo(self.contentView).offset(0);
            make.left.equalTo(self.canel.mas_right).offset(0);
            make.width.equalTo(self.canel);
        }];
        
    }
    return self;
}

-(QMUITextView *)textView{
    if (!_textView) {
        _textView = [[QMUITextView alloc] init];
        _textView.backgroundColor = UIColorMake(220, 220, 220);
        _textView.textColor = UIColorMake(51, 51, 51);
        _textView.font = [UIFont systemFontOfSize:14];
    }
    return _textView;
}

- (UIButton *)close{
    if (!_close) {
        _close = [[UIButton alloc] init];
        [_close setImage:[UIImage imageNamed:@"关闭弹框"] forState:UIControlStateNormal];
        _close.tag = 102;
        _close.imageEdgeInsets = UIEdgeInsetsMake(15, 2, 0, 13);
        _close.titleLabel.font = [UIFont systemFontOfSize:14];
        [_close addTarget:self action:@selector(typeViewButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _close;
}

- (UIButton *)canel{
    if (!_canel) {
        _canel = [[UIButton alloc] init];
        [_canel setTitle:@"取消" forState:UIControlStateNormal];
        [_canel setTitleColor:UIColorMake(137, 137, 137) forState:UIControlStateNormal];
        _canel.backgroundColor = UIColorMake(239, 239, 239);
        _canel.tag = 100;
        _canel.titleLabel.font = [UIFont systemFontOfSize:14];
        [_canel addTarget:self action:@selector(typeViewButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _canel;
}

- (UIButton *)sure{
    if (!_sure) {
        _sure = [[UIButton alloc] init];
        [_sure setTitle:@"确定" forState:UIControlStateNormal];
        [_sure setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _sure.backgroundColor = UIColorMake(255, 80, 0);
        _sure.tag = 101;
        _sure.titleLabel.font = [UIFont systemFontOfSize:14];
        [_sure addTarget:self action:@selector(typeViewButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sure;
}

- (void)typeViewButtonPressed:(UIButton *)sender{
    if (self.viewButtonPressedBlock) {
        self.viewButtonPressedBlock(sender.tag - 100,self.textView.text);
    }
}

@end
