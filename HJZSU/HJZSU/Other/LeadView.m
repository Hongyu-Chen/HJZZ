//
//  LeadView.m
//  youyijia
//
//  Created by apple on 2017/7/7.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "LeadView.h"
#import "HYCollectionViewCell.h"

@interface LeadView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (strong,nonatomic) UICollectionView *collection;

@property (strong,nonatomic) NSArray *dataCollection;

@property (strong,nonatomic) UIButton *button;

@property (strong,nonatomic) UIButton *showNow;

@property (strong,nonatomic) UIPageControl *pageControl;

@end



@implementation LeadView

- (instancetype)initWithFrame:(CGRect)frame withData:(NSArray *)data{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        _dataCollection = data;
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(self.frame.size.width, self.frame.size.height);
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        _collection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) collectionViewLayout:layout];
        _collection.delegate = self;
        _collection.dataSource = self;
        _collection.pagingEnabled = YES;
        _collection.showsHorizontalScrollIndicator = NO;
        // 取消弹簧效果
        _collection.bounces = NO;
        
        [self addSubview:_collection];
        [_collection registerClass:[HYCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([HYCollectionViewCell class])];
        
        
        _button = [[UIButton alloc] init];
        [_button setTitle:@"跳过" forState:UIControlStateNormal];
        _button.titleLabel.font = [UIFont systemFontOfSize:13];
        [_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _button.layer.cornerRadius = 5.0;
        _button.layer.borderColor = [UIColor whiteColor].CGColor;
        _button.layer.borderWidth = 0.5;
        [_button addTarget:self action:@selector(skipScrollView) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_button];
        [_button mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(20);
            make.right.equalTo(self).offset(-15);
            make.width.offset(70);
            make.height.offset(30);
        }];
        
//        _pageControl = [[UIPageControl alloc] init];
//        _pageControl.frame = CGRectMake(0, self.frame.size.height - 60, self.frame.size.width, 20);//指定位置大小
//        _pageControl.numberOfPages = data.count;//指定页面个数
//        _pageControl.currentPage = 0;//指定pagecontroll的值，默认选中的小白点（第一个）
//        //添加委托方法，当点击小白点就执行此方法
//        _pageControl.pageIndicatorTintColor = UIColorMake(255, 80, 0);// 设置非选中页的圆点颜色
//        _pageControl.currentPageIndicatorTintColor = UIColorMake(239, 239, 239); // 设置选中页的圆点颜色
//        [self addSubview:_pageControl];
        
        
        _showNow = [[UIButton alloc] init];
        [_showNow setTitle:@"立即体验" forState:UIControlStateNormal];
        _showNow.titleLabel.font = [UIFont systemFontOfSize:13];
        [_showNow setTitleColor:UIColorMake(255, 80, 0) forState:UIControlStateNormal];
        _showNow.layer.cornerRadius = 5.0;
        _showNow.layer.borderColor = UIColorMake(239, 239, 239).CGColor;
        _showNow.layer.borderWidth = 0.5;
        [_showNow addTarget:self action:@selector(skipScrollView) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_showNow];
        [_showNow mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self).offset(-80);
            make.right.equalTo(self).offset(-100);
            make.left.equalTo(self).offset(100);
            make.height.offset(30);
        }];
        _showNow.hidden = YES;
        
    }
    return self;
}

#pragma mark <UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _dataCollection ? _dataCollection.count : 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    HYCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([HYCollectionViewCell class]) forIndexPath:indexPath];
    cell.locationImageName = _dataCollection ? _dataCollection[indexPath.row] : nil;
    cell.showImageTitle = NO;
    return cell;
}



#pragma mark - <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"------%zd", indexPath.item);
    
    if (indexPath.item == (_dataCollection.count - 1)) {
//        [self removeFromSuperview];
    }
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.x == (_dataCollection.count-1) * self.frame.size.width) {
        _button.hidden = YES;
        _showNow.hidden = NO;
    }
    else{
        _button.hidden = NO;
        _showNow.hidden = YES;
    }
    
    _pageControl.currentPage = scrollView.contentOffset.x/scrollView.frame.size.width;
}

- (void)skipScrollView{
    [self removeFromSuperview];
}


- (void)show
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    self.frame = window.bounds;
    [window addObserver:self forKeyPath:@"frame" options:0 context:nil];
    [window addSubview:self];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(UIView *)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"frame"]) {
        self.frame = object.bounds;
//        HYCollectionViewCell *currentImageView = _collection.subviews[0];
//        if ([currentImageView isKindOfClass:[HYCollectionViewCell class]]) {
//            [currentImageView clear];
//        }
    }
}

- (void)dealloc
{
    [[UIApplication sharedApplication].keyWindow removeObserver:self forKeyPath:@"frame"];
}


@end
