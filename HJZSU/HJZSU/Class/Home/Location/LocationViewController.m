//
//  LocationViewController.m
//  HJZSS
//
//  Created by apple on 2019/2/27.
//  Copyright © 2019 apple. All rights reserved.
//

#import "LocationViewController.h"

@interface LocationViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic) UITableView *tableView;
@property (strong,nonatomic) NSArray *cityData;

@end

@implementation LocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleLab.text = @"选择城市";
    self.rightBtn.hidden = YES;
    [self.view addSubview:self.tableView];
    
    [self getCityListSuccess:^(id  _Nonnull result) {
        NSLog(@"%@",result);
    } failed:^(NSString * _Nonnull reson) {
        NSLog(@"%@",reson);
    }];
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NavigationContentTopConstant, SCREEN_WIDTH, SCREEN_HEIGHT - NavigationContentTopConstant)];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = UIColorMake(239, 239, 239);
        [self.tableView setSectionIndexBackgroundColor:[UIColor clearColor]];
        [self.tableView setSectionIndexColor:[UIColor blueColor]];
        if (@available(iOS 10.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
    return _tableView;
}



- (NSArray *)cityData{
    if (!_cityData) {
        _cityData = [[NSArray alloc] initWithObjects:@"",@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z", nil];
    }
    return _cityData;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.cityData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    else{
        return 5;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }
    else{
        return 40;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return nil;
    }
    else{
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
        UILabel *tip = [LabelCreat creatLabelWith:@"" font:[UIFont systemFontOfSize:15] color:UIColorMake(51, 51, 51) textAlignment:NSTextAlignmentLeft];
        tip.text = self.cityData[section];
        [view addSubview:tip];
        [tip mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.top.equalTo(view).offset(0);
            make.left.equalTo(view).offset(15);
        }];
        return view;
    }
}

//添加索引栏标题数组
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
//    NSMutableArray *resultArray =[NSMutableArray arrayWithObject:UITableViewIndexSearch];
//    for (NSDictionary *dict in self.dataArray) {
//        NSString *title = dict[@"firstLetter"];
//        [resultArray addObject:title];
//    }
    return self.cityData;
}


//点击索引栏标题时执行
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    //这里是为了指定索引index对应的是哪个section的，默认的话直接返回index就好。其他需要定制的就针对性处理
    if ([title isEqualToString:UITableViewIndexSearch])
    {
        [tableView setContentOffset:CGPointZero animated:NO];//tabview移至顶部
        return NSNotFound;
    }
    else
    {
        return [[UILocalizedIndexedCollation currentCollation] sectionForSectionIndexTitleAtIndex:index];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"locationCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"locationCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor whiteColor];
        UIView *line1  = [[UIView alloc] init];
        line1.backgroundColor = UIColorMake(239, 239, 239);
        [cell addSubview:line1];
        [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(cell).offset(0);
            make.left.right.equalTo(cell).offset(0);
            make.height.offset(1);
        }];
    }
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.textLabel.textColor = UIColorMake(137, 137, 137);
    cell.textLabel.text = @"A城市";
    return cell;
}

@end
