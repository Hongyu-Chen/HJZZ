//
//  CommListView.m
//  HJZSU
//
//  Created by apple on 2019/3/12.
//  Copyright © 2019 apple. All rights reserved.
//

#import "CommListView.h"
#import "CListTableViewCell.h"

@interface CommListView ()<UITableViewDelegate,UITableViewDataSource,CListTableViewCellDelegate>

@property (strong,nonatomic) UITableView *tableView;

@end

@implementation CommListView

- (instancetype)init{
    self = [super init];
    if (self) {
        self.backgroundColor = UIColorMake(239, 239, 239);
        self.layer.cornerRadius = 5;
        [self addSubview:self.tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.right.left.equalTo(self).offset(0);
        }];
    }
    return self;
}

- (void)setListData:(NSArray *)listData{
    _listData = listData;
    if (_listData) {
        [self.tableView reloadData];
    }
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[CListTableViewCell class] forCellReuseIdentifier:NSStringFromClass([CListTableViewCell class])];
    }
    return _tableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.listData ? self.listData.count :0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    PRComment *model = self.listData ? self.listData[indexPath.row] : nil;
    if (model) {
        return model.cellHeight;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CListTableViewCell class])];
    
    [cell relpayCotentReload:self.listData ? self.listData[indexPath.row] : nil];
    cell.delegate = self;
    return cell;
}

- (void)listDelegateComm:(id)model andType:(NSInteger)index{
    [self listReplyWith:model andType:index];
}

- (void)listReplyWith:(id)model andType:(NSInteger)index{
    if (_delegate) {
        [_delegate listReplyWith:model andType:index];
    }
}





@end
