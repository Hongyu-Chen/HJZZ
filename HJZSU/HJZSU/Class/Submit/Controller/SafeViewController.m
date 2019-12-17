//
//  SafeViewController.m
//  HJZSU
//
//  Created by apple on 2019/3/11.
//  Copyright © 2019 apple. All rights reserved.
//

#import "SafeViewController.h"
#import "VoucherTableViewCell.h"

@interface SafeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic) UIView *tipView;
@property (assign,nonatomic) NSInteger index;
@property (strong,nonatomic) UIButton *sure;
@property (strong,nonatomic) NSMutableArray *list;

@property (strong,nonatomic) UITableView *tableView;
@property (strong,nonatomic) NSMutableArray *tableData;

@end

@implementation SafeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleLab.text = @"安全砝码选择";
    
    [self.view addSubview:self.tipView];
    
    self.index = 0;
    
    
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.tipView;
    [self.view addSubview:self.sure];
    [self.tableView.mj_header beginRefreshing];
    
    [_sure mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-SafeAreaInsetsConstantForDeviceWithNotch.bottom - 40);
        make.left.equalTo(self.view).offset(13);
        make.right.equalTo(self.view).offset(-13);
        make.height.offset(50);
    }];
    
    UIButton *typeBtn = [self creatButtonAnd:@"无" value:@"无" tag:100];
    [self.tipView addSubview:typeBtn];
    
    __weak typeof(self) weakself= self;
    [self getPackageWithpackageId:self.pageID success:^(id  _Nonnull result) {
        [self setList:result];
        for (SafeModel *model in self.list) {
            UIButton *typeBtn = [self creatButtonAnd:model.name value:[NSString stringWithFormat:@"购买%.0f-->可退%.0f",model.buy_money,model.back_money] tag:101 + [self.list indexOfObject:model]];
            [weakself.tipView addSubview:typeBtn];
            if (weakself.selectedModel) {
                if (weakself.selectedModel.id == model.id) {
                    [weakself safeButtonPressed:typeBtn];
                }
            }
            
        }
    } failed:^(NSString * _Nonnull reson) {
        ;
    }];
    
}

- (UIView *)tipView{
    if (!_tipView) {
        _tipView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 300)];
        _tipView.backgroundColor = [UIColor whiteColor];
        
        UILabel *tip = [LabelCreat creatLabelWith:@"请选择安全砝码" font:[UIFont systemFontOfSize:15] color:UIColorMake(34, 34, 34) textAlignment:NSTextAlignmentLeft];
        UIImageView *icon = [[UIImageView alloc] init];
        icon.image = [UIImage imageNamed:@"安全砝码"];
        icon.contentMode = UIViewContentModeScaleAspectFit;
        [_tipView addSubview:tip];
        [_tipView addSubview:icon];
        [tip mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.tipView).offset(0);
            make.left.equalTo(self.tipView).offset(13);
            make.height.offset(50);
        }];
        
        [icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.tipView).offset(0);
            make.left.equalTo(tip.mas_right).offset(13);
            make.width.offset(15);
            make.height.offset(50);
        }];
        
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = UIColorMake(239, 239, 239);
        
        [_tipView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.tipView).offset(0);
            make.left.equalTo(self.tipView).offset(13);
            make.right.equalTo(self.tipView).offset(-13);
            make.height.offset(1);
        }];
        
        UILabel *tip1 = [LabelCreat creatLabelWith:@"购买安全砝码，在活动结束且未达成约定任务时，可按相应砝码退款，时间为3个工作日内。" font:[UIFont systemFontOfSize:13] color:UIColorMake(34, 34, 34) textAlignment:NSTextAlignmentLeft];
        tip1.numberOfLines = 0;
        
        [_tipView addSubview:tip1];
        [tip1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.tipView).offset(50);
            make.left.equalTo(self.tipView).offset(13);
            make.right.equalTo(self.tipView).offset(-13);
        }];
    }
    return _tipView;
}
- (UIButton *)creatButtonAnd:(NSString *)typeName value:(NSString *)valuestr tag:(NSInteger)tag{
    UIButton *button = [[UIButton alloc] init];
    button.backgroundColor = [UIColor whiteColor];
    button.frame = CGRectMake(0, 100 + 50 * (tag - 100), SCREEN_WIDTH, 50);
    button.tag = tag;
    
    UILabel *type = [LabelCreat creatLabelWith:typeName font:[UIFont systemFontOfSize:15] color:UIColorMake(34, 34, 34) textAlignment:NSTextAlignmentLeft];
    UIImageView *icon = [[UIImageView alloc] init];
    icon.image = [UIImage imageNamed:@"勾选-未选中"];
    icon.contentMode = UIViewContentModeScaleAspectFit;
    icon.tag = 200;
    UILabel *value = [LabelCreat creatLabelWith:valuestr font:[UIFont systemFontOfSize:15] color:UIColorMake(137, 137, 137) textAlignment:NSTextAlignmentLeft];
    
    [button addSubview:type];
    [button addSubview:icon];
    [button addSubview:value];
    
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(button).offset(0);
        make.left.equalTo(button).offset(13);
        make.width.offset(15);
    }];
    
    [type mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(button).offset(0);
        make.left.equalTo(icon.mas_right).offset(13);
    }];
    
    [value mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(button).offset(0);
        make.left.equalTo(type.mas_right).offset(30);
    }];
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = UIColorMake(239, 239, 239);
    
    [button addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(button).offset(0);
        make.left.equalTo(button).offset(13);
        make.right.equalTo(button).offset(-13);
        make.height.offset(1);
    }];
//    if (tag == 100) {
//        icon.image = [UIImage imageNamed:@"勾选"];
//    }
    [button addTarget:self action:@selector(safeButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

- (void)safeButtonPressed:(UIButton *)sender{
    for (int i = 0; i < self.list.count + 1; i++) {
        UIButton *tmp = [self.view viewWithTag:i + 100];
        UIImageView *icon = [tmp viewWithTag:200];
        if (i == (sender.tag - 100)) {
            icon.image = [UIImage imageNamed:@"勾选"];
            self.index = i;
            if (i == 0) {
                for (VocherModel *model in self.tableData) {
                    model.chooseStatus = NO;
                }
                [self.tableView reloadData];
            }
        }
        else{
            icon.image = [UIImage imageNamed:@"勾选-未选中"];
        }
    }
}

- (UIButton *)sure{
    if (!_sure) {
        _sure = [[UIButton alloc] init];
        [_sure setTitle:@"确定" forState:UIControlStateNormal];
        [_sure setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _sure.backgroundColor = UIColorMake(255, 80, 0);
        _sure.layer.cornerRadius = 5;
        _sure.titleLabel.font = [UIFont systemFontOfSize:18];
        [_sure addTarget:self action:@selector(sureButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sure;
}

- (void)sureButtonPressed{
    if (self.list) {
        if (self.safeBlock) {
            BOOL back = NO;
            VocherModel *backModel = nil;
            for (VocherModel *model in self.tableData) {
                if (model.chooseStatus) {
                    back = YES;
                    backModel = model;
                    break;
                }
            }
            if (_index == 0) {
                self.safeBlock(nil,backModel);
                [self.navigationController popViewControllerAnimated:YES];
            }
            else{
                self.safeBlock(self.list[_index - 1],backModel);
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
    }
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NavigationContentTopConstant, SCREEN_WIDTH, SCREEN_HEIGHT - (NavigationContentTopConstant))];
        _tableView.backgroundColor = self.view.backgroundColor;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[VoucherTableViewCell class] forCellReuseIdentifier:NSStringFromClass([VoucherTableViewCell class])];
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        __weak typeof(self) weakself= self;
        _tableView.mj_header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
            [weakself reloadViewData];
        }];
    }
    return _tableView;
}

- (void)reloadViewData{
    [self getVocherListsuccess:^(id  _Nonnull result) {
        
        if (!self.tableData) {
            self.tableData = [[NSMutableArray alloc] init];
        }
        else{
            [self.tableData removeAllObjects];
        }
        
        for (VocherModel *model in result) {
            if (model.status == 0 && model.type == 1) {
                [self.tableData addObject:model];
            }
        }
        
        if (self.chooiseModel) {
            for (VocherModel *model in self.tableData) {
                if (model.id == self.chooiseModel.id) {
                    model.chooseStatus = YES;
                }
            }
        }
        
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    } failed:^(NSString * _Nonnull reson) {
        [self.tableView.mj_header endRefreshing];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tableData.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    VoucherTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([VoucherTableViewCell class])];
    cell.model = self.tableData ? self.tableData[indexPath.row] : nil;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.index == 0) {
        return;
    }
    
    VocherModel *model = self.tableData[indexPath.row];
    model.chooseStatus = !model.chooseStatus;
    if (model.chooseStatus) {
        for (VocherModel *tmp in self.tableData) {
            if (model.id != tmp.id) {
                tmp.chooseStatus = NO;
            }
        }
    }
    [self.tableView reloadData];
}


@end
