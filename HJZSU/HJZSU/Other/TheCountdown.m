//
//  TheCountdown.m
//  ModelPage
//
//  Created by pro1 on 2018/10/25.
//  Copyright © 2018 pro1. All rights reserved.
//

#import "TheCountdown.h"
#define TIMEOUT 60

@interface TheCountdown ()

@property (strong,nonatomic) UILabel *stateLabel;
@property (strong,nonatomic) UILabel *timeLab;
@property (strong,nonatomic) NSTimer *timer;
@property (assign,nonatomic) NSInteger nowCount;
@property (strong,nonatomic) UIActivityIndicatorView *loading;

@end

@implementation TheCountdown

- (instancetype)init{
    self = [super init];
    if (self) {
        _nowCount = TIMEOUT;
        [self addSubview:self.stateLabel];
        [self addSubview:self.timeLab];
        [self addSubview:self.loading];
        
        [_loading mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.left.right.equalTo(self).offset(0);
        }];
        self.selected = NO;
        self.btnClicked = YES;
        [self addTarget:self action:@selector(userPressedBtn) forControlEvents:UIControlEventTouchUpInside];
        self.style = TheCountdownStyleRightLeft;
    }
    return self;
}

- (void)setTimeLabColor:(UIColor *)timeLabColor{
    _timeLabColor = timeLabColor;
    if (_timeLabColor) {
        self.timeLab.textColor = _timeLabColor;
    }
}

- (void)setStateLabColor:(UIColor *)stateLabColor{
    _stateLabColor = stateLabColor;
    if (_stateLabColor) {
        self.stateLabel.textColor = _stateLabColor;
    }
}

- (void)setLoadColor:(UIColor *)loadColor{
    _loadColor = loadColor;
    if (_loadColor) {
        self.loading.color = _loadColor;
    }
}

- (void)setTimeFont:(UIFont *)timeFont{
    _timeFont = timeFont;
    if (_timeFont) {
        self.timeLab.font = _timeFont;
    }
}

- (void)setStateFont:(UIFont *)stateFont{
    _stateFont = stateFont;
    if (_stateFont) {
        self.stateLabel.font = _stateFont;
    }
}

- (void)setStyle:(TheCountdownStyle)style{
    _style = style;
    switch (_style) {
        case TheCountdownStyleLeftRight:
        {
            [_stateLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.right.bottom.equalTo(self).offset(0);
            }];
            [_timeLab mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.left.bottom.equalTo(self).offset(0);
            }];
            _stateLabel.textAlignment = NSTextAlignmentLeft;
            _timeLab.textAlignment = NSTextAlignmentLeft;
        }
            break;
        case TheCountdownStyleRightLeft:
        {
            [_stateLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.left.bottom.equalTo(self).offset(0);
            }];
            [_timeLab mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.right.bottom.equalTo(self).offset(0);
            }];
            _stateLabel.textAlignment = NSTextAlignmentLeft;
            _timeLab.textAlignment = NSTextAlignmentLeft;
        }
            break;
        case TheCountdownStyleOnlyTime:
        {
            [_timeLab mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.right.bottom.left.equalTo(self).offset(0);
            }];
            [_stateLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.right.bottom.left.equalTo(self).offset(0);
            }];
            _stateLabel.textAlignment = NSTextAlignmentCenter;
            _timeLab.textAlignment = NSTextAlignmentCenter;
        }
            break;
            
        default:
            break;
    }
}

- (void)userPressedBtn{
    if (!self.btnClicked) {
        return;
    }
    !self.userClickedBtn?:self.userClickedBtn(self.selected);
}

- (void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    self.timeLab.hidden = !selected;
}

- (void)setBtnState:(TheCountdownState)btnState{
    _btnState = btnState;
    switch (_btnState) {
        case TheCountdownLoading:
        {
            //点击按钮发送请求获取验证码
            self.stateLabel.hidden = YES;
            [_loading startAnimating];
        }
            break;
        case TheCountdownFaild:
        {
            //验证码发送失败
            self.stateLabel.hidden = NO;
            self.stateLabel.text = @"重新发送";
            self.timeLab.hidden = YES;
            [_loading stopAnimating];
        }
            break;
        case TheCountdownSuccess:
        {
            //验证码发送成功
            if (self.style == TheCountdownStyleOnlyTime) {
                self.stateLabel.hidden = YES;
            }
            else{
                self.stateLabel.hidden = NO;
            }
            self.stateLabel.text = @"重新发送";
            self.timeLab.hidden = NO;
            [self startTheCountDown];
            [_loading stopAnimating];
        }
            break;
            
        default:
            break;
    }
}

- (UILabel *)stateLabel{
    if (!_stateLabel) {
        _stateLabel = [[UILabel alloc] init];
        _stateLabel.text = @"获取验证码";
        _stateLabel.textColor = [UIColor grayColor];
        _stateLabel.font = [UIFont systemFontOfSize:14];
    }
    return _stateLabel;
}

- (UILabel *)timeLab{
    if (!_timeLab) {
        _timeLab = [[UILabel alloc] init];
        _timeLab.text = [NSString stringWithFormat:@"(%ds)",TIMEOUT];
        _timeLab.textColor = [UIColor redColor];
        _timeLab.font = [UIFont systemFontOfSize:12];
    }
    return _timeLab;
}

- (UIActivityIndicatorView *)loading{
    if (!_loading) {
        _loading = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _loading.color = [UIColor redColor]; // 改变圈圈的颜色为红色； iOS5引入
        [_loading setHidesWhenStopped:YES]; //当旋转结束时隐藏
    }
    return _loading;
}

- (void)startTheCountDown{
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerChangeView) userInfo:nil repeats:YES];
    }
}

- (void)timerChangeView{
    _nowCount--;
    if (_nowCount >0) {
        _timeLab.hidden = NO;
        _timeLab.text = [NSString stringWithFormat:@"(%lds)",_nowCount];
        if (self.style == TheCountdownStyleOnlyTime) {
            _stateLabel.hidden = YES;
        }
        self.btnClicked = NO;
    }
    else{
        _nowCount = TIMEOUT;
        _timeLab.hidden = YES;
        self.btnClicked = YES;
        [self stopTheCountDown];
        if (self.style == TheCountdownStyleOnlyTime) {
            _stateLabel.hidden = NO;
        }
    }
}

- (void)stopTheCountDown{
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
}

- (void)dealloc{
    [self stopTheCountDown];
    NSLog(@"TheCountDown -->%@",NSStringFromSelector(_cmd));
}
- (void)requestToServiceGetCodeWith:(NSString *)phone codeType:(NSInteger)type{
    //根据不同的codeType 发送请求获取验证码
    self.btnClicked = NO;
    self.btnState = TheCountdownLoading;
    
    __weak typeof(self) weakself = self;
    [self userGetMessageCodeWith:phone codeType:type success:^(id  _Nonnull result) {
        weakself.btnState = TheCountdownSuccess;
        weakself.btnClicked = NO;
        [QMUITips showSucceed:@"验证码发送成功" inView:[UIApplication sharedApplication].keyWindow hideAfterDelay:1.0];
    } failed:^(NSString * _Nonnull reson) {
        weakself.btnState = TheCountdownFaild;
        weakself.btnClicked = YES;
        [QMUITips showError:reson inView:[UIApplication sharedApplication].keyWindow hideAfterDelay:1.0];
    }];
}



@end
