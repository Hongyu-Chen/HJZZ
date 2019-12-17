//
//  MdetailViewController.m
//  HJZSS
//
//  Created by apple on 2019/3/4.
//  Copyright © 2019 apple. All rights reserved.
//

#import "MdetailViewController.h"

@interface MdetailViewController ()

@property (strong,nonatomic) UIView *topTip;
@property (strong,nonatomic) UILabel *time;
@property (strong,nonatomic) UIView *contentBg;
@property (strong,nonatomic) FormatLabel *contentLab;
@property (strong,nonatomic) UIButton *sureBtn;


@end

@implementation MdetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleLab.text = @"消息详情";
    [self.view addSubview:self.topTip];
    [self.view addSubview:self.contentBg];
    [self.view addSubview:self.sureBtn];

    
    [_contentBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topTip.mas_bottom).offset(0);
        make.left.right.equalTo(self.view).offset(0);
    }];
    
    [_sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-SafeAreaInsetsConstantForDeviceWithNotch.bottom - 40);
        make.left.equalTo(self.view).offset((SCREEN_WIDTH - 140)/2);
        make.width.offset(140);
        make.height.offset(50);
    }];
    
    self.time.text = [NSString hoursTimeWith:self.model.create_time];
    self.contentLab.text = _model.content;
}

- (UIView *)topTip{
    if (!_topTip) {
        _topTip = [[UIView alloc] initWithFrame:CGRectMake(0, NavigationContentTopConstant, SCREEN_WIDTH, 40)];
        _topTip.backgroundColor = [UIColor whiteColor];
        UILabel *tip = [LabelCreat creatLabelWith:@"系统消息" font:[UIFont boldSystemFontOfSize:13] color:UIColorMake(51, 51, 51) textAlignment:NSTextAlignmentLeft];
        self.time = [LabelCreat creatLabelWith:@"2019-01-22 12:33:34" font:[UIFont systemFontOfSize:13] color:UIColorMake(137, 137, 137) textAlignment:NSTextAlignmentLeft];
        [_topTip addSubview:tip];
        [_topTip addSubview:_time];
        
        [tip mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.top.equalTo(self.topTip).offset(0);
            make.left.equalTo(self.topTip).offset(13);
        }];
        
        [_time mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.top.equalTo(self.topTip).offset(0);
            make.right.equalTo(self.topTip).offset(-13);
        }];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(13, 39, SCREEN_WIDTH - 26, 1)];
        line.backgroundColor = self.view.backgroundColor;
        [_topTip addSubview:line];
        
    }
    return _topTip;
}

- (UIView *)contentBg{
    if (!_contentBg) {
        _contentBg = [[UIView alloc] init];
        _contentBg.backgroundColor = [UIColor whiteColor];
        [_contentBg addSubview:self.contentLab];
        [_contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.equalTo(self.contentBg).offset(13);
            make.right.bottom.equalTo(self.contentBg).offset(-13);
        }];
    }
    return _contentBg;
}

- (FormatLabel *)contentLab{
    if (!_contentLab) {
        _contentLab = [[FormatLabel alloc] init];
        _contentLab.backgroundColor = [UIColor whiteColor];
        _contentLab.numberOfLines = 0;
        _contentLab.lineSpcae = 5.0;
        _contentLab.wordSpace = 1.5;
        _contentLab.textColor = UIColorMake(137, 137, 137);
        _contentLab.font = [UIFont systemFontOfSize:13];
        _contentLab.text = @"文字描述...文字描述...文字描述...文字描述...文字描述...文字描述...文字描述...文字描述...文字描述...文字描述...文字描述...文字描述...文字描述...文字描述...文字描述...文字描述...文字描述...文字描述...文字描述...文字描述...文字描述...文字描述...文字描述...文字描述...文字描述...文字描述...文字描述...文字描述...文字描述...文字描述...文字描述...文字描述...文字描述...文字描述...文字描述...文字描述...文字描述...文字描述...文字描述...文字描述...文字描述...文字描述...文字描述...文字描述...文字描述...文字描述...文字描述...文字描述...文字描述...文字描述...文字描述...文字描述...文字描述...文字描述...文字描述...文字描述...文字描述...文字描述...文字描述...文字描述...文字描述...文字描述...文字描述...";
    }
    return _contentLab;
}

- (UIButton *)sureBtn{
    if (!_sureBtn) {
        _sureBtn = [[UIButton alloc] init];
        [_sureBtn setTitleColor:UIColorMake(122, 122, 122) forState:UIControlStateNormal];
        _sureBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        _sureBtn.layer.cornerRadius = 5;
        _sureBtn.layer.borderWidth = 1.0;
        _sureBtn.layer.borderColor = UIColorMake(122, 122, 122).CGColor;
        [_sureBtn setTitle:@"删除" forState:UIControlStateNormal];
        [_sureBtn addTarget:self action:@selector(deleteSystemMssage) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureBtn;
}

- (void)deleteSystemMssage{
    [self deleteSystemMsg:self.model.id success:^(id  _Nonnull result) {
        [QMUITips showSucceed:@"删除成功"];
        [self.navigationController popViewControllerAnimated:YES];
    } failed:^(NSString * _Nonnull reson) {
        [QMUITips showError:reson];
    }];
}

@end
