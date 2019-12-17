//
//  MessageViewController.m
//  HJZSS
//
//  Created by apple on 2019/3/1.
//  Copyright © 2019 apple. All rights reserved.
//

#import "MessageViewController.h"
#import "MessageListTableViewCell.h"
#import "MdetailViewController.h"

@interface MessageViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic) UITableView *tableView;
@property (strong,nonatomic) NSMutableArray *tableData;

@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleLab.text = @"消息";
    [self.view addSubview:self.tableView];
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getSystemMessageListsuccess:^(id  _Nonnull result) {
        [self setTableData:result];
        [self.tableView reloadData];
    } failed:^(NSString * _Nonnull reson) {
        ;
    }];
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NavigationContentTopConstant, SCREEN_WIDTH, SCREEN_HEIGHT - NavigationContentTopConstant)];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = self.view.backgroundColor;
        [_tableView registerClass:[MessageListTableViewCell class] forCellReuseIdentifier:NSStringFromClass([MessageListTableViewCell class])];
    }
    return _tableView;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tableData.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MessageListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MessageListTableViewCell class])];
    cell.model = self.tableData ? self.tableData[indexPath.row] : nil;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MdetailViewController *detail = [[MdetailViewController alloc] init];
    detail.model = self.tableData[indexPath.row];
    [self.navigationController pushViewController:detail animated:YES];
}




@end
