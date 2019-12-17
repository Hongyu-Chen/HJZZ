//
//  OrderInfoViewController.m
//  HJZSU
//
//  Created by apple on 2019/3/13.
//  Copyright © 2019 apple. All rights reserved.
//

#import "OrderInfoViewController.h"
#import "OrderShowTableViewCell.h"
#import "OrderSpaceTableViewCell.h"
#import "OrderImageTableViewCell.h"
#import "OrderPlanTableViewCell.h"
#import "OrderTeamTableViewCell.h"
#import "CanelOrderView.h"
#import "PayTypeView.h"
#import "CommentStartVC.h"
#import "OrderCommTableViewCell.h"
#import "IsDoneSelectedView.h"
#import "MyVouchersViewController.h"
@interface OrderInfoViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (strong,nonatomic) UITableView *tableView;
@property (strong,nonatomic) UIView *bottomView;
@property (strong,nonatomic) UIButton *canelOrder;
@property (strong,nonatomic) QMUIButton *server;
@property (strong,nonatomic) UIButton *sure;
//@property (strong,nonatomic) UIButton *refresh;
@property (strong,nonatomic) OrderModelInfo *infoModel;
@property (strong,nonatomic) UserOderCommModel *commModel;
@property (assign,nonatomic) BOOL sureState;
@property (assign,nonatomic) NSInteger isDone;
@property (strong,nonatomic) VocherModel *vocherModel;
@end

@implementation OrderInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleLab.text = @"订单详情";
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.bottomView];
//    [self.view addSubview:self.refresh];
//    [_refresh mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(self.view).offset(-20);
//        make.bottom.equalTo(self.view).offset(-SafeAreaInsetsConstantForDeviceWithNotch.bottom - 50 - 30);
//        make.width.height.offset(40);
//    }];
    
    [_server mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bottomView).offset(5);
        make.left.equalTo(self.bottomView).offset(10);
        make.height.offset(40);
    }];
    
    [_sure mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bottomView).offset(7.5);
        make.right.equalTo(self.bottomView).offset(-13);
        make.width.offset(100);
        make.height.offset(35);
    }];
    
    [_canelOrder mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bottomView).offset(7.5);
        make.right.equalTo(self.sure.mas_left).offset(-13);
        make.height.width.equalTo(self.sure);
    }];
    [self reloadOrder];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userPaySuccessWithWechat:) name:WX_PAY_STATE object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userPaySuccessWithAL:) name:AL_IPAY_STATE object:nil];
    
    self.rightBtn.hidden = NO;
    [self.rightBtn setTitle:@"刷新" forState:UIControlStateNormal];
    [self.rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.rightBtn.titleLabel.font = [UIFont systemFontOfSize:14];
}

- (void)righttemButtenPressed:(UIButton *)sender{
    [self reloadOrder];
}

- (void)userPaySuccessWithWechat:(NSNotification *)center{
    [self reloadOrder];
}

- (void)userPaySuccessWithAL:(NSNotification *)center{
    [self reloadOrder];
}

- (void)reloadOrder{
    __weak typeof(self) weakself = self;
    [self getOrderDetatilWithOrderNo:self.orderNo success:^(id  _Nonnull result) {
        weakself.infoModel = result;
        weakself.isDone = 0;
        [weakself reloadSelfViewData];
    } failed:^(NSString * _Nonnull reson) {
        ;
    }];
}

- (void)reloadSelfViewData{
    switch (self.infoModel.status) {
        case 1:
        {
//            if (IsNullString(self.infoModel.teamId)) {
//                [self.canelOrder setTitle:@"取消订单" forState:UIControlStateNormal];
//                self.sure.hidden = YES;
//                [_canelOrder mas_makeConstraints:^(MASConstraintMaker *make) {
//                    make.right.equalTo(self.bottomView).offset(-13);
//                    make.width.offset(100);
//                }];
//            }
//            else{
//                [self.canelOrder setTitle:@"取消订单" forState:UIControlStateNormal];
//                [self.sure setTitle:@"确认订单" forState:UIControlStateNormal];
//                [_canelOrder mas_makeConstraints:^(MASConstraintMaker *make) {
//                    make.right.equalTo(self.sure.mas_left).offset(-13);
//                }];
//            }
            [self.canelOrder setTitle:@"取消订单" forState:UIControlStateNormal];
            [self.sure setTitle:@"确认订单" forState:UIControlStateNormal];
        }
            break;
        case 2:
        {
            self.canelOrder.hidden = YES;
            [self.sure setTitle:@"去支付" forState:UIControlStateNormal];
        }
            break;
        case 3:
        {
            if ((self.infoModel.finishData || [self.infoModel.activityType integerValue] == 5)  && !self.infoModel.is_success) {
                self.canelOrder.hidden = YES;
                [self.sure setTitle:@"确认完成" forState:UIControlStateNormal];
            }
            else{
                self.canelOrder.hidden = YES;
                self.sure.hidden = YES;
            }
        }
            break;
        case 4:
        {
            if (self.infoModel.is_success) {
                self.canelOrder.hidden = YES;
                if (self.infoModel.iscomment) {
                    self.sure.hidden = YES;
                }
                else{
                    self.sure.hidden = NO;
                }
                [self.sure setTitle:@"去评价" forState:UIControlStateNormal];
            }
            else{
                self.canelOrder.hidden = YES;
                self.sure.hidden = YES;
//                [self.sure setTitle:@"确认完成" forState:UIControlStateNormal];
            }
        }
            break;
        case 5:
        {
            self.canelOrder.hidden = YES;
            self.sure.hidden = YES;
        }
            break;
        case 6:
        {
            
        }
            break;
            
        default:
            break;
    }
    
    [self.tableView reloadData];
}

- (void)getorderCommInfo{
    [self getOrderCommInfo:self.orderNo success:^(id  _Nonnull result) {
        [self setCommModel:result];
        [self.tableView reloadData];
        self.sure.hidden = YES;
    } failed:^(NSString * _Nonnull reson) {
        [QMUITips showError:reson];
    }];
}

- (UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - SafeAreaInsetsConstantForDeviceWithNotch.bottom - 50, SCREEN_WIDTH, SafeAreaInsetsConstantForDeviceWithNotch.bottom + 50)];
        _bottomView.backgroundColor = UIColorMake(51, 51, 51);
        [_bottomView addSubview:self.server];
        [_bottomView addSubview:self.canelOrder];
        [_bottomView addSubview: self.sure];
    }
    return _bottomView;
}

- (UIButton *)canelOrder{
    if (!_canelOrder) {
        _canelOrder = [[UIButton alloc] init];
        [_canelOrder setTitle:@"取消订单" forState:UIControlStateNormal];
        _canelOrder.layer.cornerRadius = 5;
        _canelOrder.layer.borderWidth = 1;
        _canelOrder.layer.borderColor = [UIColor whiteColor].CGColor;
        [_canelOrder setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _canelOrder.titleLabel.font = [UIFont systemFontOfSize:15];
        [_canelOrder addTarget:self action:@selector(canelButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _canelOrder;
}

- (QMUIButton *)server{
    if (!_server) {
        _server = [[QMUIButton alloc] init];
        [_server setTitle:@"联系客服" forState:UIControlStateNormal];
        [_server setImage:[UIImage imageNamed:@"联系客服"] forState:UIControlStateNormal];
        [_server setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _server.titleLabel.font = [UIFont systemFontOfSize:15];
        _server.imagePosition = SPItemImagePositionLeft;
        _server.spacingBetweenImageAndTitle = 10.0;
        [_server addTarget:self action:@selector(serverBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _server;
}

- (UIButton *)sure{
    if (!_sure) {
        _sure = [[UIButton alloc] init];
        [_sure setTitle:@"去评价" forState:UIControlStateNormal];
        [_sure setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _sure.titleLabel.font = [UIFont systemFontOfSize:15];
        _sure.backgroundColor = UIColorMake(255, 80, 0);
        _sure.layer.cornerRadius = 5;
        [_sure addTarget:self action:@selector(sureButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sure;
}

//- (UIButton *)refresh{
//    if (!_refresh) {
//        _refresh = [[UIButton alloc] init];
//        [_refresh setImage:[UIImage imageNamed:@"刷新-按钮"] forState:UIControlStateNormal];
//    }
//    return _refresh;
//}


- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NavigationContentTopConstant, SCREEN_WIDTH, SCREEN_HEIGHT - SafeAreaInsetsConstantForDeviceWithNotch.bottom - 50 - NavigationContentTopConstant)];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = self.view.backgroundColor;
        [_tableView registerClass:[OrderShowTableViewCell class] forCellReuseIdentifier:NSStringFromClass([OrderShowTableViewCell class])];
        [_tableView registerClass:[OrderSpaceTableViewCell class] forCellReuseIdentifier:NSStringFromClass([OrderSpaceTableViewCell class])];
        [_tableView registerClass:[OrderImageTableViewCell class] forCellReuseIdentifier:NSStringFromClass([OrderImageTableViewCell class])];
        [_tableView registerClass:[OrderPlanTableViewCell class] forCellReuseIdentifier:NSStringFromClass([OrderPlanTableViewCell class])];
        [_tableView registerClass:[OrderTeamTableViewCell class] forCellReuseIdentifier:NSStringFromClass([OrderTeamTableViewCell class])];
        [_tableView registerClass:[OrderCommTableViewCell class] forCellReuseIdentifier:NSStringFromClass([OrderCommTableViewCell class])];
    }
    return _tableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 9;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 2 || section == 4 || section == 5) {
        return 1;
    }
    else if (section == 0){
        return 3;
    }
    else if (section == 1){
        return 6;
    }
    else if (section == 3){
        return 2;
    }
    else if (section == 6){
        if (self.infoModel.teamId) {
            return 2;
        }
        else{
            return 0;
        }
    }
    else if (section == 7){
        if (self.infoModel.status == 3 || self.infoModel.status == 4) {
            return 1;
        }
        else{
            return 0;
        }
    }
    else if (section == 8){
        return self.infoModel.serverComment ? 1 : 0;
    }
    else{
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1 && indexPath.row == 4){
        OrderSpaceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([OrderSpaceTableViewCell class])];
        cell.model = self.infoModel;
        return cell;
    }
    else if (indexPath.section == 2){
        OrderImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([OrderImageTableViewCell class])];
        cell.model = self.infoModel;
        return cell;
    }
    else if (indexPath.section == 3 && indexPath.row == 1){
        OrderPlanTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([OrderPlanTableViewCell class])];
        cell.model = self.infoModel;
        return cell;
    }
    else if (indexPath.section == 6 && indexPath.row == 1){
        OrderTeamTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([OrderTeamTableViewCell class])];
        cell.model = self.infoModel;
        return cell;
    }
    else if (indexPath.section == 8){
        OrderCommTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([OrderCommTableViewCell class])];
        cell.model = self.infoModel.serverComment;
        return cell;
    }
    else{
        OrderShowTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([OrderShowTableViewCell class])];
        cell.indexPath = indexPath;
        cell.vocherModel = self.vocherModel;
        cell.model = self.infoModel;
        cell.isDone = self.isDone;
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 6) {
        if (self.infoModel.teamId) {
            return 13;
        }else{
            return 0;
        }
    }
    else{
        return 13;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *tmp = [[UIView alloc] init];
    tmp.backgroundColor = [UIColor clearColor];
    return tmp;
}

- (void)canelButtonPressed:(UIButton *)sender{
    __weak typeof(self) weakself = self;
    CanelOrderView *order = [CanelOrderView showView:@"CanelOrderView" loadDataType:@"2" userBlock:^(NSInteger index, id value) {
        if (index == 1) {
            NSString *reson = [NSString stringWithFormat:@"%@,%@",IsNullString(value[@"content"]) ? @"" : value[@"content"],IsNullString(value[@"other"]) ? @"" : value[@"other"]];
            [weakself canelOrderWith:@{@"orderNo":weakself.infoModel.order_no,@"comment":reson} success:^(id  _Nonnull result) {
                [QMUITips showSucceed:@"订单已取消"];
                [weakself.navigationController popViewControllerAnimated:YES];
            } failed:^(NSString * _Nonnull reson) {
                [QMUITips showError:reson];
            }];
        }
    }];
    [order reloadResonList];
}

- (void)sureButtonPressed:(UIButton *)sender{
    

    if (self.infoModel.status == 1) {
        
#pragma mark - <确认订单>
        __weak typeof(self) weakself = self;
        [self sureOrderWith:self.infoModel.order_no success:^(id  _Nonnull result) {
            [weakself reloadOrder];
        } failed:^(NSString * _Nonnull reson) {
            [QMUITips showError:reson];
        }];

    }
    else if (self.infoModel.status == 2){
        
        if ([self.infoModel.activityType integerValue] == 5 || !IsNullString(self.infoModel.weightsId)) {
            self.sureState = YES;
        }
        
        if (!self.sureState) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"你还没有购买安全砝码" preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"我知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                self.sureState = YES;
            }]];
            [self presentViewController:alert animated:YES completion:nil];
        }
        else{
#pragma mark - <支付订单>
            __weak typeof(self)weakself = self;
            [PayTypeView showView:@"PayTypeView" info:self.infoModel showView:self.view userBlock:^(NSInteger index, id  _Nonnull value) {
                if (index == 1) {
                    if ([value integerValue] == 1) {
                        [WeChatTool WXPayWithOrder:weakself.infoModel.order_no userCouponId:weakself.vocherModel ? weakself.vocherModel.id : 0];
                    }
                    else if ([value integerValue] == 2){
                        [weakself getPayWith:weakself.infoModel.order_no
                                     payType:[value integerValue]
                                userCouponId:weakself.vocherModel ? weakself.vocherModel.id : 0
                                     success:^(id  _Nonnull result) {
                            [[PayManager sharePayManager] handleOrderPayWithParams:@{@"payInfo":result}];
                        } failed:^(NSString * _Nonnull reson) {
                            [QMUITips showWithText:reson];
                        }];
                    }else if ([value integerValue] == 0){
                        [weakself getPayWith:weakself.infoModel.order_no
                                     payType:[value integerValue]
                                userCouponId:weakself.vocherModel ? weakself.vocherModel.id : 0
                                     success:^(id  _Nonnull result) {
                            [QMUITips showSucceed:@"支付成功"];
                            [weakself reloadOrder];
                        } failed:^(NSString * _Nonnull reson) {
                            [QMUITips showError:reson];
                        }];
                    }
                }
                else if (index == 2){
                    MyVouchersViewController *vochers = [[MyVouchersViewController alloc] init];
                    vochers.chooiseModel = self.vocherModel;
                    vochers.isChooseStyle = YES;
                    vochers.type = [self.infoModel.activityType integerValue] == 5 ? 0 : 2;
                    __weak typeof(self) weakself = self;
                    vochers.userChooseBlock = ^(VocherModel * _Nonnull model) {
                        weakself.vocherModel = model;
                        PayTypeView *tmp = [self.view viewWithTag:10010];
                        if (model) {
                            [tmp showChooseType:YES];
                        }
                        else {
                            [tmp showChooseType:NO];
                        }
                        [tmp reloadDataWith:model];
                        
                    };
                    [weakself.navigationController pushViewController:vochers animated:YES];
                }
            }];
        }
    }
    else if (self.infoModel.status == 3){
#pragma mark - <确认完成>
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"确认此次活动已结束" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (!self.isDone) {
                [QMUITips showWithText:@"请选择是否完成任务"];
                return;
            }
            __weak typeof(self) weakself = self;
            [self orderDoneWith:(self.isDone - 1) orderNo:weakself.infoModel.order_no success:^(id  _Nonnull result) {
                [weakself reloadOrder];
                if (weakself.isDone - 1) {
                    [QMUITips showWithText:@"感谢使用战神客户端，祝您生意兴隆。"];
                }
                else{
                    [QMUITips showWithText:@"已反馈至后台，我们将进行查证。"];
                }
            } failed:^(NSString * _Nonnull reson) {
                [QMUITips showError:reson];
            }];
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }]];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else if (self.infoModel.status == 4){
        
#pragma mark - <评价订单>
        CommentStartVC *comm = [[CommentStartVC alloc] init];
        comm.order_no = self.infoModel.order_no;
        [self.navigationController pushViewController:comm animated:YES];
//        if (self.infoModel.is_success) {
//            CommentStartVC *comm = [[CommentStartVC alloc] init];
//            comm.order_no = self.infoModel.order_no;
//            [self.navigationController pushViewController:comm animated:YES];
//        }
//        else{
//            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"确认此次活动已结束" preferredStyle:UIAlertControllerStyleAlert];
//            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//                if (!self.isDone) {
//                    [QMUITips showWithText:@"请选择是否完成任务"];
//                }
//                __weak typeof(self) weakself = self;
//                [self orderDoneWith:(self.isDone - 1) orderNo:weakself.infoModel.order_no success:^(id  _Nonnull result) {
//                    [weakself reloadOrder];
//                    if (weakself.isDone - 1) {
//                        [QMUITips showWithText:@"感谢使用战神客户端，祝您生意兴隆。"];
//                    }
//                    else{
//                        [QMUITips showWithText:@"已反馈至后台，我们将进行查证。"];
//                    }
//                } failed:^(NSString * _Nonnull reson) {
//                    [QMUITips showError:reson];
//                }];
//            }]];
//            [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//            }]];
//            [self presentViewController:alert animated:YES completion:nil];
//        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 7 && indexPath.row == 0 && self.infoModel.status == 3 && !self.infoModel.is_success) {
//        NSLog(@"选择任务完成情况");
        __weak typeof(self) weakself = self;
        [IsDoneSelectedView showView:@"IsDoneSelectedView" info:@{} userBlock:^(NSInteger index, id  _Nonnull value) {
            if (index == 1) {
                weakself.isDone = [value integerValue];
                [weakself.tableView reloadData];
            }
            else{
                weakself.isDone = 0;
                [weakself.tableView reloadData];
            }
        }];
    }
}


- (void)serverBtnPressed:(UIButton *)sender{
    NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",@"18600006979"];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    
}

@end
