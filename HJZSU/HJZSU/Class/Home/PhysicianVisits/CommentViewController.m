//
//  CommentViewController.m
//  HJZSU
//
//  Created by apple on 2019/3/12.
//  Copyright © 2019 apple. All rights reserved.
//

#import "CommentViewController.h"
#import "CommentTableViewCell.h"
#import "CommBottomView.h"

@interface CommentViewController ()<UITableViewDelegate,UITableViewDataSource,CommentTableViewCellDelegate>

@property (strong,nonatomic) UITableView *tableView;
@property (strong,nonatomic) CommBottomView *bottomView;
@property (strong,nonatomic) NSMutableArray *tableData;
@property (strong,nonatomic) NSString *commId;
@property (strong,nonatomic) NSString *toUid;

@end

@implementation CommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleLab.text = @"评论";
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.bottomView];
    
    [self reloadViewData];
}

- (void)reloadViewData{
    [self getPyCommWith:self.articleId success:^(id  _Nonnull result) {
        [self setTableData:result];
        [self.tableView reloadData];
    } failed:^(NSString * _Nonnull reson) {
        ;
    }];
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NavigationContentTopConstant, SCREEN_WIDTH, SCREEN_HEIGHT - NavigationContentTopConstant - SafeAreaInsetsConstantForDeviceWithNotch.bottom - 50)];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        [_tableView registerClass:[CommentTableViewCell class] forCellReuseIdentifier:NSStringFromClass([CommentTableViewCell class])];
    }
    return _tableView;
}

- (CommBottomView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[CommBottomView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 50 - SafeAreaInsetsConstantForDeviceWithNotch.bottom, SCREEN_WIDTH, SafeAreaInsetsConstantForDeviceWithNotch.bottom + 50)];
        __weak typeof(self) weakself = self;
        _bottomView.userSubmitReply = ^(NSString * _Nonnull text) {
            NSMutableDictionary *input = [[NSMutableDictionary alloc] init];
            [input setObject:[NSNumber numberWithInteger:weakself.articleId] forKey:@"articleId"];
            if (weakself.commId) {
                [input setObject:weakself.commId forKey:@"commentId"];
            }
            if (weakself.toUid) {
                [input setObject:weakself.toUid forKey:@"toUid"];
            }
            [input setObject:text forKey:@"content"];
            
            [weakself submitCommWith:input success:^(id  _Nonnull result) {
                [weakself.bottomView restBottomView];
                [weakself reloadViewData];
                weakself.commId = nil;
                weakself.toUid = nil;
            } failed:^(NSString * _Nonnull reson) {
                [QMUITips showError:reson];
            }];
        };
    }
    return _bottomView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tableData.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    PhyRecomModel *model = self.tableData ? self.tableData[indexPath.row] : nil;
    if (model) {
        return model.cellHeight;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CommentTableViewCell class])];
    [cell uploadCellValueWith:self.tableData ? self.tableData[indexPath.row] : nil];
    cell.delegate = self;
    return cell;
}

- (void)replyCommBtnPressed:(id)model andTYpe:(NSInteger)index{
    if (index == 1) {
        if ([model isKindOfClass:[PhyRecomModel class]]) {
            PhyRecomModel *tmp = model;
            self.commId = tmp.id;
            [self.bottomView beginEditText];
            NSLog(@"评论------楼》");
        }
        else if ([model isKindOfClass:[NSDictionary class]]){
            self.commId = model[@"commId"];
            self.toUid = model[@"toUid"];
            [self.bottomView beginEditText];
            NSLog(@"评论————————楼中楼》");
        }
    }
    else{
        if ([model isKindOfClass:[PhyRecomModel class]]) {
            NSLog(@"删除楼");
            PhyRecomModel *tmp = model;
            __weak typeof(self) weakself = self;
            [self deleteCOmmWith:[NSString stringWithFormat:@"%ld",self.articleId] andCommID:tmp.id success:^(id  _Nonnull result) {
                [weakself reloadViewData];
            } failed:^(NSString * _Nonnull reson) {
                [QMUITips showError:reson];
            }];
        }
        else if ([model isKindOfClass:[NSDictionary class]]){
            NSLog(@"删除楼zhonglou");
            NSDictionary *tmp = model;
            __weak typeof(self) weakself = self;
            [self deleteCOmmWith:@"" andCommID:tmp[@"loucommId"] success:^(id  _Nonnull result) {
                [weakself reloadViewData];
            } failed:^(NSString * _Nonnull reson) {
                [QMUITips showError:reson];
            }];
        }
    }
}

@end
