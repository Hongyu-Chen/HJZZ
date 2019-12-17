//
//  SubmitViewController.m
//  呼叫战神
//
//  Created by apple on 2019/2/25.
//  Copyright © 2019 apple. All rights reserved.
//

#import "SubmitViewController.h"
#import "SubmitStepOne.h"
#import "SubmitStrpTwo.h"
#import "SubmitStepDone.h"
#import "Lianmeng.h"


@interface SubmitViewController ()

@property (strong,nonatomic) UIView *topView;
@property (strong,nonatomic) UIImageView *statusImage;
@property (strong,nonatomic) UIScrollView *scrollView;
@property (strong,nonatomic) SubmitStepOne *submitInfo;
@property (strong,nonatomic) SubmitStrpTwo *choise;
@property (strong,nonatomic) SubmitStepDone *submitDone;
@property (strong,nonatomic) Lianmeng *lianMeng;

@end

@implementation SubmitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleLab.text = @"发布";
    [self.view addSubview:self.topView];
    [self.view addSubview:self.scrollView];
}

- (UIView *)topView{
    if (!_topView) {
        _topView = [[UIView alloc] initWithFrame:CGRectMake(0, NavigationContentTopConstant, SCREEN_WIDTH, 95)];
        _topView.backgroundColor = [UIColor whiteColor];
        
        [_topView addSubview:self.statusImage];
        
        [_statusImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.topView).offset(20);
            make.left.equalTo(self.topView).offset(30);
            make.right.equalTo(self.topView).offset(-30);
        }];
        for (int i = 0; i < 3; i++) {
            UILabel *label = [LabelCreat creatLabelWith:@[@"填写信息",@"选择套餐",@"完成发布"][i] font:[UIFont systemFontOfSize:14] color:UIColorMake(255, 80, 0) textAlignment:NSTextAlignmentCenter];
            [_topView addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self.topView).offset(-20);
                make.left.equalTo(self.topView).offset(i * (SCREEN_WIDTH/3));
                make.width.offset(SCREEN_WIDTH/3);
            }];
        }
    }
    return _topView;
}

- (UIImageView *)statusImage{
    if (!_statusImage) {
        _statusImage = [[UIImageView alloc] init];
        _statusImage.contentMode = UIViewContentModeScaleAspectFit;
        _statusImage.image = [UIImage imageNamed:@"进度一"];
    }
    return _statusImage;
}

- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, NavigationContentTopConstant + 95, SCREEN_WIDTH, SCREEN_HEIGHT - (NavigationContentTopConstant + 95 + 10))];
        _scrollView.backgroundColor = [UIColor whiteColor];
        _scrollView.pagingEnabled = YES;
        _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * 3, 0);
        _scrollView.scrollEnabled = NO;
        [_scrollView addSubview:self.submitInfo];
        if (self.model.activityType == 3) {
            [_scrollView addSubview:self.lianMeng];
        }
        else{
            [_scrollView addSubview:self.choise];
        }
        [_scrollView addSubview:self.submitDone];
    }
    return _scrollView;
}

- (SubmitStepOne *)submitInfo{
    if (!_submitInfo) {
        _submitInfo = [[SubmitStepOne alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.scrollView.frame.size.height)];
        _submitInfo.model = self.model;
        __weak typeof(self) weakself = self;
        _submitInfo.nextCellpressedBlock = ^(NSInteger index) {
            [UIView animateWithDuration:0.3 animations:^{
                weakself.scrollView.contentOffset = CGPointMake(SCREEN_WIDTH, 0);
                weakself.statusImage.image = [UIImage imageNamed:@"进度二"];
            }];
        };
    }
    return _submitInfo;
}

- (SubmitStrpTwo *)choise{
    if (!_choise) {
        _choise = [[SubmitStrpTwo alloc] initWithFrame:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, self.scrollView.frame.size.height)];
        _choise.model = self.model;
        __weak typeof(self) weakself = self;
        _choise.nextCellpressedBlock = ^(NSInteger index) {
            [UIView animateWithDuration:0.3 animations:^{
                weakself.scrollView.contentOffset = CGPointMake(SCREEN_WIDTH * 2, 0);
                weakself.statusImage.image = [UIImage imageNamed:@"进度三"];
                [weakself.submitDone reloadView];
            }];
        };
    }
    return _choise;
}

- (SubmitStrpTwo *)lianMeng{
    if (!_lianMeng) {
        _lianMeng = [[Lianmeng alloc] initWithFrame:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, self.scrollView.frame.size.height)];
        _lianMeng.model = self.model;
        __weak typeof(self) weakself = self;
        _lianMeng.nextCellpressedBlock = ^(NSInteger index) {
            [UIView animateWithDuration:0.3 animations:^{
                weakself.scrollView.contentOffset = CGPointMake(SCREEN_WIDTH * 2, 0);
                weakself.statusImage.image = [UIImage imageNamed:@"进度三"];
                [weakself.submitDone reloadView];
            }];
        };
    }
    return _lianMeng;
}

- (SubmitStepDone *)submitDone{
    if (!_submitDone) {
        _submitDone = [[SubmitStepDone alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 2, 0, SCREEN_WIDTH, self.scrollView.frame.size.height)];
        _submitDone.model = self.model;
    }
    return _submitDone;
}

- (void)leftItemButtenPressed:(UIButton *)sender{
    if (self.scrollView.contentOffset.x > 0) {
        if (self.scrollView.contentOffset.x == SCREEN_WIDTH * 2) {
            [UIView animateWithDuration:0.3 animations:^{
                self.scrollView.contentOffset = CGPointMake(SCREEN_WIDTH, 0);
                self.statusImage.image = [UIImage imageNamed:@"进度二"];
            }];
        }
        else{
            [UIView animateWithDuration:0.3 animations:^{
                self.scrollView.contentOffset = CGPointMake(0, 0);
                self.statusImage.image = [UIImage imageNamed:@"进度一"];
            }];
        }
    }
    else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
