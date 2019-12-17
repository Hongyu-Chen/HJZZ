//
//  SubmitStepDone.m
//  HJZSU
//
//  Created by apple on 2019/3/9.
//  Copyright © 2019 apple. All rights reserved.
//

#import "SubmitStepDone.h"
#import "SBTeamTableViewCell.h"
#import "SBImageTableViewCell.h"
#import "SBTipTableViewCell.h"
#import "SubmitNormalCell.h"
#import "DatePickerView.h"
#import "LocationView.h"
#import "SbmitNextTableViewCell.h"

@interface SubmitStepDone ()<UITableViewDelegate,UITableViewDataSource,SBImageTableViewCellDelegate>

@property (strong,nonatomic) UITableView *tableView;
@property (strong,nonatomic) NSMutableArray *imagesContent;

@end

@implementation SubmitStepDone

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.tableView];
    }
    return self;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.bounds];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedRowHeight = 150;
        _tableView.backgroundColor = UIColorMake(239, 239, 239);
        [_tableView registerClass:[SubmitNormalCell class] forCellReuseIdentifier:NSStringFromClass([SubmitNormalCell class])];
        [_tableView registerClass:[SBTipTableViewCell class] forCellReuseIdentifier:NSStringFromClass([SBTipTableViewCell class])];
        [_tableView registerClass:[SBTeamTableViewCell class] forCellReuseIdentifier:NSStringFromClass([SBTeamTableViewCell class])];
        [_tableView registerClass:[SBImageTableViewCell class] forCellReuseIdentifier:NSStringFromClass([SBImageTableViewCell class])];
        [_tableView registerClass:[SbmitNextTableViewCell class] forCellReuseIdentifier:NSStringFromClass([SbmitNextTableViewCell class])];
    }
    return _tableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 6;
    }
    else if (section == 1 || section == 2){
        return 1;
    }
    else if (section == 3){
        return 3;
    }
    else{
        return 2;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 13;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *tmp = [[UIView alloc] init];
    tmp.backgroundColor = [UIColor clearColor];
    return tmp;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 4) {
            SBTipTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SBTipTableViewCell class])];
            cell.model = self.model;
            return cell;
        }
        else{
            SubmitNormalCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SubmitNormalCell class])];
            cell.doenIndexPath = indexPath;
            cell.model = self.model;
            return cell;
        }
    }
    else if (indexPath.section == 1){
        SubmitNormalCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SubmitNormalCell class])];
        cell.doenIndexPath = indexPath;
        cell.model = self.model;
        return cell;
    }
    else if (indexPath.section == 2){
        SBImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SBImageTableViewCell class])];
        cell.delegate = self;
        cell.onlyShow = YES;
        cell.imagesContent = self.model.images;
        return cell;
    }
    if (indexPath.section == 3) {
        if (indexPath.row == 5) {
            SBTipTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SBTipTableViewCell class])];
            return cell;
        }
        else{
            SubmitNormalCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SubmitNormalCell class])];
            cell.doenIndexPath = indexPath;
            cell.model = self.model;
            return cell;
        }
    }
    else{
        if (indexPath.row == 0) {
            SubmitNormalCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SubmitNormalCell class])];
            cell.doenIndexPath = indexPath;
            cell.model = self.model;
            return cell;
        }
        else{
            SbmitNextTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SbmitNextTableViewCell class])];
            cell.value = @"确认发布";
            cell.tipLabel.hidden = YES;
            return cell;
        }
    }
}

- (void)userShouldChanedImagewith:(NSInteger)index type:(NSInteger)type{
    if (type == 0) {
        [self.imagesContent removeObjectAtIndex:index];
    }
    else{
        if (index < 0) {
            if (self.imagesContent.count >= 9) {
                return;
            }
            [self.imagesContent addObject:@"明星团队底图"];
        }
    }
    
    [_tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:4]] withRowAnimation:UITableViewRowAnimationNone];
}

- (NSMutableArray *)imagesContent{
    if (!_imagesContent) {
        _imagesContent = [[NSMutableArray alloc] init];
    }
    return _imagesContent;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 4 && indexPath.row == 1){
        __weak typeof(self) weakself = self;
        [QMUITips showLoadingInView:self];
        [self upImageWith:@"activity" data:weakself.model.images success:^(id  _Nonnull result) {
            NSMutableDictionary *input = [NSMutableDictionary dictionary];
            
            
            NSString *str = @"1";
            if (weakself.model.activityType == 5) {
            }
            else if (weakself.model.activityType == 2){
                str = [NSString stringWithFormat:@"%@",weakself.model.plan.task];
            }
            else if (weakself.model.activityType == 3){
                str = [NSString stringWithFormat:@"%ld",(weakself.model.pin_num - 10) * [YYCacheManager shareYYCacheManager].taskNumer + [weakself.model.plan.task integerValue]];
            }
            else if (weakself.model.activityType == 4){
                str = [NSString stringWithFormat:@"%ld",[weakself.model.plan.task integerValue] + weakself.model.plan.supervision_number * [YYCacheManager shareYYCacheManager].taskNumer];
            }
            
            CGFloat allmoney = weakself.model.allMoneny - ((weakself.model.safe ? weakself.model.safe.buy_money : 0) - (weakself.model.vocherModel ? weakself.model.vocherModel.worth_money/100 : 0));
            input =[@{@"type":[NSNumber numberWithInteger:weakself.model.activityType],
                      @"name":weakself.model.headPeo,
                      @"phone":weakself.model.phone,
                      @"startTime":[ProjectTool dateConversionTimeStamp:weakself.model.startTime],
                      @"downTime":[ProjectTool dateConversionTimeStamp:weakself.model.loadingTime],
                      @"endTime":[ProjectTool dateConversionTimeStamp:weakself.model.loadingTime],
                      @"taskMoney":weakself.model.plan.task,
                      @"taskNum":str,
                      @"address":weakself.model.location,
                      @"comment":IsNullString(weakself.model.requirements) ? @"" : weakself.model.requirements,
                      @"images":result[@"fileUrl"],
                      @"likeTeam":weakself.model.team ? [NSNumber numberWithInteger:weakself.model.team.id] : @"",
                      @"brandNum":weakself.model.activityType != 3 ? [NSNumber numberWithInt:1] : [NSNumber numberWithInteger:weakself.model.pin_num],
                      @"userCouponId":weakself.model.vocherModel ? [NSNumber numberWithInteger:weakself.model.vocherModel.id]: @"",
                      @"packageId":weakself.model.plan ? [NSNumber numberWithInteger:weakself.model.plan.id] : @"",
                      @"branchNum":weakself.model.activityType == 4 ? [NSNumber numberWithInteger:weakself.model.plan.supervision_number + [YYCacheManager shareYYCacheManager].arciveNumer] : [NSNumber numberWithInteger:weakself.model.plan.supervision_number],
                      @"weightsId":weakself.model.safe ? [NSNumber numberWithInteger:weakself.model.safe.id] : @"",
//                      @"amount":[NSNumber numberWithInteger:(NSInteger)weakself.model.allMoneny * 100],
                      @"expenses":[NSNumber numberWithInteger:(NSInteger)(allmoney * [YYCacheManager shareYYCacheManager].saleFloat * 100)],
                      } mutableCopy];
            //(_model.allMoneny - _model.safe.buy_money) * (1 + [YYCacheManager shareYYCacheManager].saleFloat) + _model.safe.buy_money
            [self submitAvitity:input success:^(id  _Nonnull result) {
                [QMUITips hideAllTips];
                [QMUITips showSucceed:@"创建成功"];
                [[ProjectTool getCurrentViewController].navigationController popViewControllerAnimated:YES];
            } failed:^(NSString * _Nonnull reson) {
                [QMUITips hideAllTips];
                [QMUITips showError:reson];
            }];
        } failed:^(NSString * _Nonnull reson) {
            [QMUITips hideAllTips];
            [QMUITips showError:reson];
        }];
        
    }
}

- (void)reloadView{
    [self.tableView reloadData];
}


@end
