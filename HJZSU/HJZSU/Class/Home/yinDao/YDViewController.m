//
//  YDViewController.m
//  HJZSS
//
//  Created by apple on 2019/2/26.
//  Copyright © 2019 apple. All rights reserved.
//

#import "YDViewController.h"
#import "YDTableViewCell.h"
@interface YDViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic) UITableView *tableView;

@end

@implementation YDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleLab.text = @"操作指引";
    self.rightBtn.hidden = YES;
    [self.view addSubview:self.tableView];
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NavigationContentTopConstant, SCREEN_WIDTH, SCREEN_HEIGHT - NavigationContentTopConstant)];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[YDTableViewCell class] forCellReuseIdentifier:NSStringFromClass([YDTableViewCell class])];
        _tableView.backgroundColor = UIColorMake(239, 239, 239);
    }
    return _tableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 280;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YDTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([YDTableViewCell class])];
    cell.imageContent = @[@"第一步",@"第二步",@"第三步",@"第四步"][indexPath.row];
    cell.valueStr = @[@"完善资料获得更高关注",@"引导查看商户信息",@"点击在线咨询，并说明交流时间",@"说明活动评判标准"][indexPath.row];
    return cell;
}


@end
