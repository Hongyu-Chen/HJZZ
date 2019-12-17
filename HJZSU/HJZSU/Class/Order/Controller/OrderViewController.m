//
//  OrderViewController.m
//  呼叫战神
//
//  Created by apple on 2019/2/25.
//  Copyright © 2019 apple. All rights reserved.
//

#import "OrderViewController.h"
#import "OrderListViewController.h"
#import "MessageViewController.h"


@interface OrderViewController ()<SPPageMenuDelegate,UIPageViewControllerDelegate,UIPageViewControllerDataSource>

@property (strong,nonatomic) SPPageMenu *pageMenu;
@property (strong,nonatomic) UIPageViewController *pageViewController;
@property (strong,nonatomic) NSMutableArray *dataSource;
@property (assign,nonatomic) NSInteger currentIndex;
@property (strong,nonatomic) NSArray *titles;

@end

@implementation OrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.leftItem.hidden = YES;
    self.rightBtn.hidden = NO;
    [self.rightBtn setImage:[UIImage imageNamed:@"消息"] forState:UIControlStateNormal];
    self.titleLab.text = @"我的发布";
    [self.view addSubview:self.pageMenu];
    [self pageViewController];
    
    NSAssert(self.dataSource.count > 0, @"Must have one childController at least");
    UIViewController *vc = [self.dataSource objectAtIndex:0];
    [self.pageViewController setViewControllers:@[vc] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:^(BOOL finished) {
        
    }];
}

- (void)righttemButtenPressed:(UIButton *)sender{
    [self.navigationController pushViewController:[[MessageListViewController alloc] init] animated:YES];
}

- (SPPageMenu *)pageMenu{
    if (!_pageMenu) {
        _pageMenu = [[SPPageMenu alloc] initWithFrame:CGRectMake(0, NavigationContentTopConstant, SCREEN_WIDTH, 50) trackerStyle:SPPageMenuTrackerStyleLine];
        _pageMenu.permutationWay = SPPageMenuPermutationWayNotScrollEqualWidths;
        [_pageMenu setItems:self.titles selectedItemIndex:0];
        _pageMenu.selectedItemTitleColor = UIColorMake(255, 80, 0);
        _pageMenu.unSelectedItemTitleColor = UIColorMake(51, 51, 51);
        _pageMenu.selectedItemTitleFont = [UIFont boldSystemFontOfSize:13];
        _pageMenu.unSelectedItemTitleFont = [UIFont systemFontOfSize:13];
        _pageMenu.dividingLine.backgroundColor = UIColorMake(255, 255, 255);
        [_pageMenu setTrackerHeight:4 cornerRadius:2];
        _pageMenu.tracker.backgroundColor = UIColorMake(255, 80, 0);
        _pageMenu.trackerWidth = 20;
        _pageMenu.delegate = self;
    }
    return _pageMenu;
}

- (NSArray *)titles{
    if (!_titles) {
        _titles = [[NSArray alloc] initWithObjects:@"全部订单",@"待接单",@"待支付",@"进行中",@"已完成", nil];
    }
    return _titles;
}

- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [[NSMutableArray array] init];
        for (int i = 0; i < self.titles.count; i++) {
            OrderListViewController *vc = [[OrderListViewController alloc] init];
            vc.orderType = i;
            vc.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - NavigationContentTopConstant - 50 - TabBarHeight);
            [_dataSource addObject:vc];
        }
    }
    return _dataSource;
}

- (void)pageMenu:(SPPageMenu *)pageMenu itemSelectedFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex{
    OrderListViewController *vc = (OrderListViewController *)[self.dataSource objectAtIndex:toIndex];
    [vc reloadViewDataWithTableiew];
    if (toIndex > _currentIndex) {
        
        [self.pageViewController setViewControllers:@[vc] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:^(BOOL finished) {
            
        }];
    } else {
        
        [self.pageViewController setViewControllers:@[vc] direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:^(BOOL finished) {
            
        }];
    }
    
    _currentIndex = toIndex;
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
}

- (UIPageViewController *)pageViewController {
    if (_pageViewController == nil) {
        NSDictionary *option = [NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:10] forKey:UIPageViewControllerOptionInterPageSpacingKey];
        _pageViewController = [[UIPageViewController alloc]initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:option];
        _pageViewController.delegate = self;
        _pageViewController.dataSource = self;
        _pageViewController.view.frame = CGRectMake(0, NavigationContentTopConstant + 50, SCREEN_WIDTH, SCREEN_HEIGHT - NavigationContentTopConstant - 50);
        [self addChildViewController:_pageViewController];
        [self.view addSubview:_pageViewController.view];
    }
    
    return _pageViewController;
}


- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    NSInteger index = [self.dataSource indexOfObject:viewController];
    
    if (index == 0 || (index == NSNotFound)) {
        
        return nil;
    }
    
    index--;
    
    OrderListViewController *tmp = (OrderListViewController *)[self.dataSource objectAtIndex:index];
    [tmp reloadViewDataWithTableiew];
    return tmp;
}

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    NSInteger index = [self.dataSource indexOfObject:viewController];
    
    if (index == self.dataSource.count - 1 || (index == NSNotFound)) {
        
        return nil;
    }
    
    index++;
    
    OrderListViewController *tmp = (OrderListViewController *)[self.dataSource objectAtIndex:index];
    [tmp reloadViewDataWithTableiew];
    return tmp;
}

- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers {
    
    UIViewController *nextVC = [pendingViewControllers firstObject];
    NSInteger index = [self.dataSource indexOfObject:nextVC];
    _currentIndex = index;
    self.pageMenu.selectedItemIndex = _currentIndex;
}


@end
