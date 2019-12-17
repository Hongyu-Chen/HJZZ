//
//  Lianmeng.m
//  HJZSU
//
//  Created by apple on 2019/5/17.
//  Copyright © 2019 apple. All rights reserved.
//

#import "Lianmeng.h"
#import "STInfoTableViewCell.h"
#import "STTipTableViewCell.h"
#import "SubmitNormalCell.h"
#import "SbmitNextTableViewCell.h"
#import "STNTableViewCell.h"
#import "SafeViewController.h"
#import "PinPaiCellTableViewCell.h"

@interface Lianmeng ()<UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic) UITableView *tableView;
@property (strong,nonatomic) NSMutableArray *data;


@end

@implementation Lianmeng

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.tableView];
    }
    return self;
}

- (void)setModel:(SubmitModel *)model{
    _model = model;
    if (_model) {
        [self getPackageWith:_model.activityType success:^(id  _Nonnull result) {
            self.data = result;
            [self.tableView reloadData];
        } failed:^(NSString * _Nonnull reson) {
            ;
        }];
    }
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.bounds];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = UIColorMake(239, 239, 239);
        [_tableView registerClass:[STTipTableViewCell class] forCellReuseIdentifier:NSStringFromClass([STTipTableViewCell class])];
        [_tableView registerClass:[STInfoTableViewCell class] forCellReuseIdentifier:NSStringFromClass([STInfoTableViewCell class])];
        [_tableView registerClass:[STNTableViewCell class] forCellReuseIdentifier:NSStringFromClass([STNTableViewCell class])];
        [_tableView registerClass:[SbmitNextTableViewCell class] forCellReuseIdentifier:NSStringFromClass([SbmitNextTableViewCell class])];
        [_tableView registerClass:[PinPaiCellTableViewCell class] forCellReuseIdentifier:NSStringFromClass([PinPaiCellTableViewCell class])];
    }
    return _tableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.data ? self.data.count + 3 : 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.data) {
        if(section == self.data.count + 1 || section == 0){
            return 1;
        }
        else{
            return 2;
        }
    }
    else{
        if (section == 0) {
            return 1;
        }
        else{
            return 2;
        }
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


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.data) {
        if (indexPath.section <= self.data.count) {
            if (indexPath.section == 0) {
                PinPaiCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PinPaiCellTableViewCell class])];
                cell.submitModel = self.model;
                __weak typeof(self) weakself = self;
                cell.numberChangedBlock = ^(BOOL state) {
                    [weakself.tableView reloadData];
                };
                return cell;
            }
            else{
                if (indexPath.row == 0) {
                    STTipTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([STTipTableViewCell class])];
                    cell.subMitModel = self.model;
                    cell.model = self.data ? self.data[indexPath.section - 1] : nil;
                    __weak typeof(self) weakself = self;
                    cell.selectionBlock = ^(PlanModel * _Nonnull model, BOOL state) {
                        if (state) {
                            weakself.model.safe = nil;
                            weakself.model.vocherModel = nil;
                            if (weakself.model.activityType == 5) {//培训价格计算方式
                                weakself.model.allMoneny = model.price_controller * model.supervision_number;
                                weakself.model.plan = model;
                                for (PlanModel *tmp in weakself.data) {
                                    if ([model isEqual:tmp]) {
                                        ;
                                    }
                                    else{
                                        tmp.selected = NO;
                                    }
                                }
                            }
                            else if(weakself.model.activityType == 4){//联动价格计算方式
                                weakself.model.allMoneny = model.price_controller;
                                weakself.model.plan = model;
                                for (PlanModel *tmp in weakself.data) {
                                    if ([model isEqual:tmp]) {
                                        ;
                                    }
                                    else{
                                        tmp.selected = NO;
                                    }
                                }
                            }
                            else{
                                weakself.model.allMoneny = model.price_controller + model.price_supervision * model.supervision_number;
                                weakself.model.plan = model;
                                for (PlanModel *tmp in weakself.data) {
                                    if ([model isEqual:tmp]) {
                                        ;
                                    }
                                    else{
                                        tmp.selected = NO;
                                    }
                                }
                            }
                        }
                        else{
                            weakself.model.plan = nil;
                            weakself.model.safe = nil;
                            weakself.model.vocherModel = nil;
                            weakself.model.allMoneny = 0;
                            for (PlanModel *tmp in weakself.data) {
                                tmp.selected = NO;
                            }
                        }
                        [weakself.tableView reloadData];
                    };
                    return cell;
                }
                else{
                    STInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([STInfoTableViewCell class])];
                    cell.submitModel = self.model;
                    cell.model = self.data ? self.data[indexPath.section - 1] : nil;
                    __weak typeof(self) weakself = self;
                    cell.numberChangedBlock = ^(BOOL state) {
                        for (PlanModel *tmp in weakself.data) {
                            if (tmp.selected) {
                                if (weakself.model.activityType == 5) {
                                    weakself.model.allMoneny = tmp.price_controller * tmp.supervision_number;
                                }
                                else if(weakself.model.activityType == 4){//联动价格计算方式
                                    weakself.model.allMoneny = tmp.price_controller;
                                }
                                else{
                                    weakself.model.allMoneny = tmp.price_controller + tmp.price_supervision * tmp.supervision_number;
                                }
                                
                            }
                        }
                        [weakself.tableView reloadData];
                    };
                    return cell;
                }
            }
        }
        else if (indexPath.section == self.data.count + 1){
            STNTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([STNTableViewCell class])];
            cell.type = 1;
            cell.model = self.model;
            return cell;
        }
        
        else{
            if (indexPath.row == 0) {
                STNTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([STNTableViewCell class])];
                cell.type = 2;
                cell.model = self.model;
                return cell;
            }
            else{
                SbmitNextTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SbmitNextTableViewCell class])];
                cell.value = @"下一步";
                return cell;
            }
        }
    }
    else{
        if (indexPath.section == 0) {
            STNTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([STNTableViewCell class])];
            cell.type = 1;
            cell.model = self.model;
            return cell;
        }
        else{
            if (indexPath.row == 0) {
                STNTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([STNTableViewCell class])];
                cell.type = 2;
                cell.model = self.model;
                return cell;
            }
            else{
                SbmitNextTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SbmitNextTableViewCell class])];
                cell.value = @"下一步";
                return cell;
            }
        }
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.data) {
        if (indexPath.section == self.data.count + 2 && indexPath.row == 1){
            if (self.nextCellpressedBlock && _model.plan) {
                self.nextCellpressedBlock(1);
            }
            else{
                [QMUITips showError:@"请选择套餐"];
            }
        }
        else if (indexPath.section == self.data.count + 1){
            BOOL skip = NO;
            for (PlanModel *tmp in self.data) {
                if (tmp.selected) {
                    skip = YES;
                    SafeViewController *safe = [[SafeViewController alloc] init];
                    safe.selectedModel = self.model.safe;
                    safe.chooiseModel = self.model.vocherModel;
                    safe.pageID = tmp.id;
                    __weak typeof(self) weakself = self;
                    safe.safeBlock = ^(SafeModel * _Nonnull model, VocherModel * _Nonnull vocherModel) {
                        if (weakself.model.activityType == 5) {//培训价格计算方式
                            weakself.model.allMoneny = weakself.model.plan.price_controller * weakself.model.plan.supervision_number;
                        }
                        else if(weakself.model.activityType == 4){//联动价格计算方式
                            weakself.model.allMoneny = weakself.model.plan.price_controller + weakself.model.plan.supervision_number;
                        }
                        else{
                            weakself.model.allMoneny = weakself.model.plan.price_controller + weakself.model.plan.price_supervision * weakself.model.plan.supervision_number;
                        }
                        
                        if (model) {
                            weakself.model.safe = model;
                            if (vocherModel) {
                                weakself.model.vocherModel = vocherModel;
                            }
                            else{
                                weakself.model.vocherModel = nil;
                            }
                            weakself.model.allMoneny += ((weakself.model.safe ? weakself.model.safe.buy_money : 0) - (weakself.model.vocherModel ? weakself.model.vocherModel.worth_money/100 : 0));
                        }
                        else{
                            weakself.model.safe = nil;
                        }
                        [weakself.tableView reloadData];
                    };
                    [[ProjectTool getCurrentViewController].navigationController pushViewController:safe animated:YES];
                    break;
                }
            }
            if (!skip) {
                [QMUITips showError:@"请选择套餐"];
            }
        }
    }
}

@end

