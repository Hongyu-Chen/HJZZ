//
//  TeamInfoViewController.m
//  HJZSU
//
//  Created by apple on 2019/3/13.
//  Copyright © 2019 apple. All rights reserved.
//

#import "TeamInfoViewController.h"
#import "TTopInfoTableViewCell.h"
#import "TeamShowTableViewCell.h"
#import "TCommentTableViewCell.h"
#import "TeameBaseInfoView.h"
#import "SubmitTipView.h"
#import "SubmitViewController.h"

@interface TeamInfoViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic) UITableView *tableView;
@property (strong,nonatomic) UIView *bottomView;
@property (strong,nonatomic) QMUIButton *collecBtn;
@property (strong,nonatomic) UIButton *choise;
@property (strong,nonatomic) NSDictionary *teamInfo;

@end

@implementation TeamInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleLab.text = @"明星团队";
    self.navigationView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.tableView];
    [self.view bringSubviewToFront:self.navigationView];
    [self.view addSubview:self.bottomView];
    
    [self getTeaminfoWith:self.teamId success:^(id  _Nonnull result) {
        self.teamInfo = result;
        [self.tableView reloadData];
        self.collecBtn.selected = [result[@"isCollection"] integerValue] == 1 ? YES : NO;
    } failed:^(NSString * _Nonnull reson) {
        [QMUITips showError:reson];
    }];
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - SafeAreaInsetsConstantForDeviceWithNotch.bottom - 50)];
        _tableView.backgroundColor = UIColorMake(239, 239, 239);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[TTopInfoTableViewCell class] forCellReuseIdentifier:NSStringFromClass([TTopInfoTableViewCell class])];
        [_tableView registerClass:[TeamShowTableViewCell class] forCellReuseIdentifier:NSStringFromClass([TeamShowTableViewCell class])];
        [_tableView registerClass:[TCommentTableViewCell class] forCellReuseIdentifier:NSStringFromClass([TCommentTableViewCell class])];
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
    return _tableView;
}

-(UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - SafeAreaInsetsConstantForDeviceWithNotch.bottom - 50, SCREEN_WIDTH, SafeAreaInsetsConstantForDeviceWithNotch.bottom + 50)];
        UIView *bg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 108, _bottomView.frame.size.height)];
        bg.backgroundColor = UIColorMake(38, 38, 38);
        
        UIView *bg2 = [[UIView alloc] initWithFrame:CGRectMake(108, 0, _bottomView.frame.size.width - 108, _bottomView.frame.size.height)];
        bg2.backgroundColor = UIColorMake(255, 80, 0);
        
        [_bottomView addSubview:bg];
        [_bottomView addSubview:bg2];
        [_bottomView addSubview:self.collecBtn];
        [_bottomView addSubview:self.choise];
    }
    return _bottomView;
}

- (QMUIButton *)collecBtn{
    if (!_collecBtn) {
        _collecBtn = [[QMUIButton alloc] initWithFrame:CGRectMake(0, 0, 108, 50)];
        [_collecBtn setTitle:@"收藏" forState:UIControlStateNormal];
        [_collecBtn setTitle:@"已收藏" forState:UIControlStateSelected];
        [_collecBtn setImage:[UIImage imageNamed:@"收藏-未选中"] forState:UIControlStateNormal];
        [_collecBtn setImage:[UIImage imageNamed:@"收藏-已选中"] forState:UIControlStateSelected];
        _collecBtn.spacingBetweenImageAndTitle = 13;
        [_collecBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _collecBtn.imagePosition = QMUIButtonImagePositionLeft;
        [_collecBtn addTarget:self action:@selector(colectionPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _collecBtn;
}

- (UIButton *)choise{
    if (!_choise) {
        _choise = [[UIButton alloc] initWithFrame:CGRectMake(108, 0, SCREEN_WIDTH - 108, 50)];
        [_choise setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _choise.titleLabel.font = [UIFont systemFontOfSize:15];
        [_choise setTitle:@"选TA执行" forState:UIControlStateNormal];
        [_choise addTarget:self action:@selector(choiseBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _choise;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 1) {
        return self.teamInfo ? [self.teamInfo[@"comment"] count] : 0;
    }
    else{
        return 3;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }
    else{
        return 63;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return nil;
    }
    else{
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 63)];
        view.backgroundColor = [UIColor whiteColor];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 13)];
        line.backgroundColor = UIColorMake(239, 239, 239);
        [view addSubview:line];
        
        UIImageView *iconImage = [[UIImageView alloc] init];
        iconImage.contentMode = UIViewContentModeScaleAspectFit;
        iconImage.image = [UIImage imageNamed:@"装饰"];
        UILabel *tip = [LabelCreat creatLabelWith:@"用户评价" font:[UIFont systemFontOfSize:15] color:UIColorMake(34, 34, 34) textAlignment:NSTextAlignmentLeft];

        [view addSubview:iconImage];
        [view addSubview:tip];


        [iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(view).offset(13);
            make.left.equalTo(view).offset(13);
            make.height.offset(50);
            make.width.offset(7.5);
        }];

        [tip mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(view).offset(13);
            make.left.equalTo(iconImage.mas_right).offset(10);
            make.right.equalTo(view).offset(-13);
            make.height.offset(50);
        }];
        
        return view;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            TTopInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TTopInfoTableViewCell class])];
            cell.info = self.teamInfo;
            return cell;
        }
        else{
            TeamShowTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TeamShowTableViewCell class])];
            cell.type = indexPath.row;
            cell.info = self.teamInfo;
            return cell;
        }
    }
    else{
        TCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TCommentTableViewCell class])];
        cell.info = self.teamInfo ? self.teamInfo[@"comment"][indexPath.row] : nil;
        return cell;
    };
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && indexPath.row == 0) {
        [TeameBaseInfoView showView:@"TeameBaseInfoView" userBlock:^(NSInteger index,id value) {
            
        }];
    }
}

- (void)colectionPressed:(QMUIButton *)sender{
    __weak typeof(self) weakself = self;
    if (sender.selected) {
        //取消收藏
        [self addDeleteTeamCollec:[_teamInfo[@"id"] integerValue] type:1 success:^(id  _Nonnull result) {
            [QMUITips showSucceed:@"取消成功"];
            weakself.collecBtn.selected = NO;
        } failed:^(NSString * _Nonnull reson) {
            [QMUITips showError:reson];
        }];
    }
    else{
        //收藏
        [self addDeleteTeamCollec:[_teamInfo[@"id"] integerValue] type:0 success:^(id  _Nonnull result) {
            [QMUITips showSucceed:@"收藏成功"];
            weakself.collecBtn.selected = YES;
        } failed:^(NSString * _Nonnull reson) {
            [QMUITips showError:reson];
        }];
    }
}

- (void)choiseBtnPressed:(UIButton *)sender{
    __weak typeof(self) weakself = self;
    [SubmitTipView showSubmitTypeViewUserBlock:^(NSInteger index) {
        if (index != 0) {
            SubmitViewController *submit = [[SubmitViewController alloc] init];
            SubmitModel *model = [[SubmitModel alloc] init];
            model.activityType = index;
            model.pin_num = 10;
            model.team = [[TeameModel alloc] initWith:weakself.teamInfo];
            submit.model = model;
            [[ProjectTool getCurrentViewController].navigationController pushViewController:submit animated:YES];
        }
    }];
}


@end
