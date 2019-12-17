//
//  SupervisionVC.m
//  呼叫战神
//
//  Created by apple on 2019/2/25.
//  Copyright © 2019 apple. All rights reserved.
//

#import "SupervisionVC.h"
#import "TeameCollectionCell.h"
#import "TeamInfoViewController.h"
#import "TypeView.h"

@interface SupervisionVC ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (strong,nonatomic) UIView *topMenu;
@property (strong,nonatomic) UICollectionView *collectionView;
@property (strong,nonatomic) QMUIButton *orderBy;
@property (strong,nonatomic) QMUIButton *saixuan;
@property (strong,nonatomic) TypeView *order;
@property (strong,nonatomic) TypeView *shai;
@property (strong,nonatomic) NSMutableDictionary *parameter;
@property (strong,nonatomic) NSMutableArray *collectionData;

@end

@implementation SupervisionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.leftItem.hidden = YES;
    self.titleLab.text = @"选择意向督导";
    [self.view addSubview:self.topMenu];
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.order];
    [self.view addSubview:self.shai];
    
    self.parameter = [[NSMutableDictionary alloc] init];
    [self.parameter setObject:@"0" forKey:@"type"];
    [self.parameter setObject:@"0" forKey:@"sort"];
    
    [self.collectionView.mj_header beginRefreshing];
    
}

- (void)uploadDataSource{
    [self getTeamListWith:self.parameter success:^(id  _Nonnull result) {
        self.collectionData = result;
        [self.collectionView reloadData];
        [self.collectionView.mj_header endRefreshing];
    } failed:^(NSString * _Nonnull reson) {
        [self.collectionView.mj_header endRefreshing];
    }];
}

- (UIView *)topMenu{
    if (!_topMenu) {
        _topMenu = [[UIView alloc] initWithFrame:CGRectMake(0, NavigationContentTopConstant, SCREEN_WIDTH, 50)];
        _topMenu.backgroundColor = UIColorMake(255, 80, 0);
        [_topMenu addSubview:self.orderBy];
        [_topMenu addSubview:self.saixuan];
        
        [_orderBy mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.topMenu).offset(0);
            make.left.equalTo(self.topMenu).offset(13);
        }];
        
        [_saixuan mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.topMenu).offset(0);
            make.right.equalTo(self.topMenu).offset(-13);
        }];
    }
    return _topMenu;
}

- (QMUIButton *)orderBy{
    if (!_orderBy) {
        _orderBy = [[QMUIButton alloc] init];
        [_orderBy setTitle:@"排序" forState:UIControlStateNormal];
        [_orderBy setImage:[UIImage imageNamed:@"排序-未选中"] forState:UIControlStateNormal];
        [_orderBy setImage:[UIImage imageNamed:@"排序-选中"] forState:UIControlStateSelected];
        _orderBy.imagePosition = QMUIButtonImagePositionLeft;
        _orderBy.spacingBetweenImageAndTitle = 10;
        [_orderBy setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _orderBy.titleLabel.font = [UIFont systemFontOfSize:13];
        [_orderBy addTarget:self action:@selector(orderByTypeButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _orderBy;
}

- (QMUIButton *)saixuan{
    if (!_saixuan) {
        _saixuan = [[QMUIButton alloc] init];
        [_saixuan setTitle:@"筛选" forState:UIControlStateNormal];
        [_saixuan setImage:[UIImage imageNamed:@"筛选-未选中"] forState:UIControlStateNormal];
        [_saixuan setImage:[UIImage imageNamed:@"筛选-选中"] forState:UIControlStateSelected];
        _saixuan.imagePosition = QMUIButtonImagePositionLeft;
        _saixuan.spacingBetweenImageAndTitle = 10;
        [_saixuan setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _saixuan.titleLabel.font = [UIFont systemFontOfSize:13];
        [_saixuan addTarget:self action:@selector(saixuanTypeButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _saixuan;
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
//        layout.itemSize = CGSizeMake((SCREEN_WIDTH - 39)/2, (SCREEN_WIDTH - 39)/2 * 215 /168.0);
        layout.itemSize = CGSizeMake((SCREEN_WIDTH - 39)/2, (SCREEN_WIDTH - 39)/2);
        layout.sectionInset = UIEdgeInsetsMake(13, 13, 13, 13);
        layout.minimumLineSpacing = 13;
        layout.minimumInteritemSpacing = 13;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, NavigationContentTopConstant + 50, SCREEN_WIDTH, SCREEN_HEIGHT - (NavigationContentTopConstant + 50 + TabBarHeight)) collectionViewLayout:layout];
        _collectionView.backgroundColor = self.view.backgroundColor;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[TeameCollectionCell class] forCellWithReuseIdentifier:NSStringFromClass([TeameCollectionCell class])];
        _collectionView.mj_header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(uploadDataSource)];
    }
    return _collectionView;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.collectionData.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    TeameCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([TeameCollectionCell class]) forIndexPath:indexPath];
    cell.model = self.collectionData ? self.collectionData[indexPath.row] : nil;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    TeamListModel *model = self.collectionData[indexPath.row];
    TeamInfoViewController *info = [[TeamInfoViewController alloc] init];
    info.teamId = model.id;
    [self.navigationController pushViewController:info animated:YES];
}

#pragma mark - <ButtonPressed>

- (void)orderByTypeButton:(QMUIButton *)sender{
    sender.selected = !sender.selected;
    if (sender.selected) {
        self.order.hidden = NO;
        self.shai.hidden = YES;
        _saixuan.selected = NO;
    }
    else{
        self.order.hidden = YES;
        self.shai.hidden = YES;
    }
}

- (void)saixuanTypeButton:(QMUIButton *)sender{
    sender.selected = !sender.selected;
    if (sender.selected) {
        self.order.hidden = YES;
        self.shai.hidden = NO;
        _orderBy.selected = NO;
    }
    else{
        self.order.hidden = YES;
        self.shai.hidden = YES;
    }
}

- (TypeView *)order{
    if (!_order) {
        _order = [[TypeView alloc] initWithFrame:CGRectMake(0, NavigationContentTopConstant + 50, SCREEN_WIDTH, 60)];
        _order.titles = @[@"综合排序",@"星评等级"];
        _order.selectedIndex = 0;
        _order.hidden = YES;
        __weak typeof(self) weakself = self;
        _order.choiseIndex = ^(NSInteger selectedIndex) {
            [weakself.parameter setObject:[NSNumber numberWithInteger:selectedIndex] forKey:@"sort"];
            [weakself.collectionView.mj_header beginRefreshing];
        };
    }
    return _order;
}

- (TypeView *)shai{
    if (!_shai) {
        _shai = [[TypeView alloc] initWithFrame:CGRectMake(0, NavigationContentTopConstant + 50, SCREEN_WIDTH, 60)];
        _shai.titles = @[@"相同城市",@"全国范围",@"我的收藏"];
        _shai.selectedIndex = 0;
        _shai.hidden = YES;
        __weak typeof(self) weakself = self;
        _shai.choiseIndex = ^(NSInteger selectedIndex) {
            [weakself.parameter setObject:[NSNumber numberWithInteger:selectedIndex] forKey:@"type"];
            [weakself.collectionView.mj_header beginRefreshing];
        };
    }
    return _shai;
}

@end
