//
//  SubmitStepOne.m
//  HJZSU
//
//  Created by apple on 2019/3/9.
//  Copyright © 2019 apple. All rights reserved.
//

#import "SubmitStepOne.h"
#import "SBTeamTableViewCell.h"
#import "SBImageTableViewCell.h"
#import "SBTipTableViewCell.h"
#import "SubmitNormalCell.h"
#import "DatePickerView.h"
#import "LocationView.h"
#import "SbmitNextTableViewCell.h"
#import "TeamChoiseViewController.h"


@interface SubmitStepOne ()<UITableViewDelegate,UITableViewDataSource,SBImageTableViewCellDelegate,TZImagePickerControllerDelegate>

@property (strong,nonatomic) UITableView *tableView;
//@property (strong,nonatomic) NSMutableArray *imagesContent;

@end

@implementation SubmitStepOne

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.tableView];
    }
    return self;
}

-(void)setModel:(SubmitModel *)model{
    _model = model;
    if (_model) {
        [self.tableView reloadData];
    }
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
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 2;
    }
    else if (section == 1){
        return 2;
    }
    else if (section == 5){
        return self.model && self.model.team ? 3 : 2;
    }
    else{
        return 1;
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
    if (indexPath.section <= 2) {
        SubmitNormalCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SubmitNormalCell class])];
        cell.indexPath = indexPath;
        cell.model = self.model;
        return cell;
    }
    else if (indexPath.section == 3){
        SBTipTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SBTipTableViewCell class])];
        cell.model = self.model;
        return cell;
    }
    else if (indexPath.section == 4){
        SBImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SBImageTableViewCell class])];
        cell.delegate = self;
        cell.imagesContent = self.model.images;
        return cell;
    }
    else{
        if (self.model && self.model.team) {
            if (indexPath.row == 0) {
                SubmitNormalCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SubmitNormalCell class])];
                cell.indexPath = indexPath;
                cell.model = self.model;
                return cell;
            }
            else if(indexPath.row == 1){
                SBTeamTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SBTeamTableViewCell class])];
                cell.model = self.model;
                return cell;
            }
            else{
                SbmitNextTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SbmitNextTableViewCell class])];
                cell.value = @"下一步";
                return cell;
            }
        }
        else{
            if (indexPath.row == 0) {
                SubmitNormalCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SubmitNormalCell class])];
                cell.indexPath = indexPath;
                cell.model = self.model;
                return cell;
            }
            else{
                SbmitNextTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SbmitNextTableViewCell class])];
                cell.value = @"下一步";
                cell.tipLabel.hidden = YES;
                return cell;
            }
        }
    }
}

- (void)userShouldChanedImagewith:(NSInteger)index type:(NSInteger)type{
    if (type == 0) {
        [self.model.images removeObjectAtIndex:index];
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:4] withRowAnimation:UITableViewRowAnimationNone];
    }
    else{
        if (self.model.images.count >= 9) {
            return;
        }
        TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:9 delegate:self];
        imagePickerVc.sortAscendingByModificationDate = NO;
        imagePickerVc.allowPickingOriginalPhoto = YES;
        imagePickerVc.selectedAssets = self.model.images;
        [[ProjectTool getCurrentViewController] presentViewController:imagePickerVc animated:YES completion:nil];
    }
}

#pragma mark - <TZImagePickerControllerDelegate>

- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto {
    self.model.images = [assets mutableCopy];
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:4] withRowAnimation:UITableViewRowAnimationNone];
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    if (indexPath.section == 1) {
        
        __block NSIndexPath *tmpIndexPath = indexPath;
        __weak typeof(self) weakself = self;
        [DatePickerView showView:@"DatePickerView" userBlock:^(NSInteger index,id value) {
            NSLog(@"------>%ld %@",index,value);
            if (index == 1) {
                if (tmpIndexPath.row == 0) {
                    weakself.model.startTime = value;
                }
                else if (tmpIndexPath.row == 1){
                    weakself.model.loadingTime = value;
                }
                else if (tmpIndexPath.row == 2){
                    weakself.model.endTime = value;
                }
                [weakself.tableView reloadRowsAtIndexPaths:@[tmpIndexPath] withRowAnimation:UITableViewRowAnimationNone];
            }
        }];
    }
    else if (indexPath.section == 2){
        __block NSIndexPath *tmpIndexPath = indexPath;
        __weak typeof(self) weakself = self;
        [LocationView showView:@"LocationView" userBlock:^(NSInteger index, id value) {
            if (index == 1) {
                weakself.model.location = value;
                [weakself.tableView reloadRowsAtIndexPaths:@[tmpIndexPath] withRowAnimation:UITableViewRowAnimationNone];
            }
        }];
    }
    else if ((indexPath.section == 5 && indexPath.row == 2 && self.model.team) || (indexPath.section == 5 && indexPath.row == 1 && !self.model.team)){
        
        if (IsNullString(_model.headPeo)) {
            [QMUITips showError:@"请输入负责人" inView:self.superview.superview hideAfterDelay:1.0];
            return;
        }
        if (IsNullString(_model.phone)) {
            [QMUITips showError:@"请输入联系方式" inView:self.superview.superview hideAfterDelay:1.0];
            return;
        }
        if (IsNullString(_model.startTime)) {
            [QMUITips showError:@"请选择发布时间" inView:self.superview.superview hideAfterDelay:1.0];
            return;
        }
        if (IsNullString(_model.loadingTime)) {
            [QMUITips showError:@"请选择执行时间" inView:self.superview.superview hideAfterDelay:1.0];
            return;
        }
//        if (IsNullString(_model.endTime)) {
//            [QMUITips showError:@"请选择结束时间" inView:self.superview.superview hideAfterDelay:1.0];
//            return;
//        }
        if (IsNullString(_model.location)) {
            [QMUITips showError:@"请输入地址" inView:self.superview.superview hideAfterDelay:1.0];
            return;
        }
        if (_model.images.count == 0) {
            [QMUITips showError:@"请选择至少一张图片" inView:self.superview.superview hideAfterDelay:1.0];
            return;
        }
        
        if (self.nextCellpressedBlock) {
            self.nextCellpressedBlock(1);
        }
    }
    else if (indexPath.section == 5 && indexPath.row == 0){
        TeamChoiseViewController *team = [[TeamChoiseViewController alloc] init];
        __weak typeof(self) weakself = self;
        team.choiseTeamBlock = ^(TeamListModel * _Nonnull model) {
          /*
           @property (strong,nonatomic) NSString *teameName;//团腿名称
           @property (assign,nonatomic) CGFloat source;//团队评分
           @property (strong,nonatomic) NSString *imageUrl;//团队封面图
           @property (strong,nonatomic) NSString *teameLev;//团队等级
           @property (assign,nonatomic) NSInteger teamCount;//团队人数
           @property (assign,nonatomic) NSInteger missionCount;//团队执行任务数
           @property (assign,nonatomic) NSInteger id;//团队ID
           */
            TeameModel *tmp = [[TeameModel alloc] init];
            tmp.teameName = model.name;
            tmp.source = model.start;
            tmp.imageUrl = model.logo;
            tmp.id = model.id;
            weakself.model.team = tmp;
            [weakself.tableView reloadData];
        };
        [[ProjectTool getCurrentViewController].navigationController pushViewController:team animated:YES];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}




@end
