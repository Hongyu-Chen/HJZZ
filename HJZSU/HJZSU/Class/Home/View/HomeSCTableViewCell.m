//
//  HomeSCTableViewCell.m
//  HJZSU
//
//  Created by apple on 2019/3/6.
//  Copyright © 2019 apple. All rights reserved.
//

#import "HomeSCTableViewCell.h"
#import "SDCycleScrollView.h"
#import "YDViewController.h"
#import "ServerViewController.h"
#import "ListViewController.h"
#import "PhysicianVisitsVC.h"
#import <SafariServices/SafariServices.h>

@interface HomeSCTableViewCell ()<SDCycleScrollViewDelegate>

@property (strong,nonatomic) SDCycleScrollView *scrollView;
@property (strong,nonatomic) UIView *centerView;
@property (strong,nonatomic) UIView *sectionView;
@property (strong,nonatomic) QMUIButton *more;

@end

@implementation HomeSCTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = UIColorMake(239, 239, 239);
//        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addSubview:self.scrollView];
        [self addSubview:self.centerView];
        [self addSubview:self.sectionView];
        
    }
    return self;
}

- (SDCycleScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200) delegate:self placeholderImage:PLACEHOLDERIMAGE];
        _scrollView.delegate = self;
        _scrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
    }
    return _scrollView;
}

/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    NSString *url = self.bannerData[index][@"url"];
    if (IsNullString(url)) {
        [QMUITips showWithText:@"跳转链接为空"];
        return;
    }
    SFSafariViewController *safariVc = [[SFSafariViewController alloc] initWithURL:[NSURL URLWithString:url]];
    [[ProjectTool getCurrentViewController] presentViewController:safariVc animated:YES completion:nil];
}

- (UIView *)centerView{
    if (!_centerView) {
        _centerView = [[UIView alloc] initWithFrame:CGRectMake(0, 200, SCREEN_WIDTH, 150)];
//        _centerView.backgroundColor = UIColorMake(255, 80, 0);
        _centerView.backgroundColor = [UIColor whiteColor];
        CGFloat width = SCREEN_WIDTH/4;
        CGFloat height = 75;
        
        for (int i = 0; i < 2; i++) {
            for (int j = 0; j < 4; j++) {
                QMUIButton *button = [[QMUIButton alloc] initWithFrame:CGRectMake(j * width, (1 - i)*height, width, height)];
                [button setTitle:@[@"单店爆破",@"商场促销",@"联盟活动",@"品牌联动",@"终端问诊",@"实战培训",@"操作指引",@"战神榜"][i * 4 + j] forState:UIControlStateNormal];
//                [button setImage:[UIImage imageNamed:@[@"单店爆破",@"商场促销",@"联盟活动",@"品牌联动",@"终端问诊",@"实战培训",@"操作指引",@"服务流程"][i * 4 + j]] forState:UIControlStateNormal];
                UIImage *image = [UIImage imageNamed:@[@"单店爆破",@"商场促销",@"联盟活动",@"品牌联动",@"终端问诊",@"实战培训",@"操作指引",@"服务流程"][i * 4 + j]];
                [button setImage:[image qmui_imageWithTintColor:UIColorMake(255, 80, 0)] forState:UIControlStateNormal];
                button.imagePosition = QMUIButtonImagePositionTop;
                button.titleLabel.font = [UIFont systemFontOfSize:12];
                [button setTitleColor:UIColorMake(255, 80, 0) forState:UIControlStateNormal];
                button.tag = 100 + i * 4 + j;
                button.spacingBetweenImageAndTitle = 5.0;
                button.imageView.contentMode = UIViewContentModeScaleAspectFit;
                button.imageEdgeInsets = UIEdgeInsetsMake(0, (width - 20)/2, 0, (width - 20)/2);
                [button addTarget:self action:@selector(centerButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                [_centerView addSubview:button];
            }
        }
    }
    return _centerView;
}

- (UIView *)sectionView{
    if (!_sectionView) {
        _sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 359, SCREEN_WIDTH, 50)];
        _sectionView.backgroundColor = [UIColor whiteColor];
        _sectionView.userInteractionEnabled = YES;
        UIImageView *iconImage = [[UIImageView alloc] init];
        iconImage.contentMode = UIViewContentModeScaleAspectFit;
        iconImage.image = [UIImage imageNamed:@"装饰"];
        UILabel *tip = [LabelCreat creatLabelWith:@"最新活动" font:[UIFont systemFontOfSize:15] color:UIColorMake(34, 34, 34) textAlignment:NSTextAlignmentLeft];
        
        [_sectionView addSubview:iconImage];
        [_sectionView addSubview:tip];
        [_sectionView addSubview:self.more];
        
        [iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.sectionView).offset(0);
            make.left.equalTo(self.sectionView).offset(13);
            make.height.offset(50);
            make.width.offset(7.5);
            make.bottom.equalTo(self.sectionView).offset(0);
        }];
        
        [tip mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.sectionView).offset(0);
            make.left.equalTo(iconImage.mas_right).offset(10);
            make.right.equalTo(self.sectionView).offset(-13);
            make.height.offset(50);
            make.bottom.equalTo(self.sectionView).offset(0);
        }];
        
        [_more mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.sectionView).offset(0);
            make.right.equalTo(self.sectionView).offset(-13);
        }];
        
    }
    return _sectionView;
}

- (QMUIButton *)more{
    if (!_more) {
        _more = [[QMUIButton alloc] init];
        [_more setTitle:@"查看更多" forState:UIControlStateNormal];
        [_more setImage:[UIImage imageNamed:@"箭头-向右"] forState:UIControlStateNormal];
        _more.contentMode = UIViewContentModeScaleAspectFit;
        _more.imagePosition = QMUIButtonImagePositionRight;
        [_more setTitleColor:UIColorMake(137, 137, 137) forState:UIControlStateNormal];
        _more.titleLabel.font = [UIFont systemFontOfSize:15];
        _more.imageEdgeInsets = UIEdgeInsetsMake(0, 7.5, 0, 0);
        [_more addTarget:self action:@selector(moreList) forControlEvents:UIControlEventTouchUpInside];
    }
    return _more;
}

- (void)centerButtonPressed:(UIButton *)sender{
    if (sender.tag == 106) {
        [[ProjectTool getCurrentViewController].navigationController pushViewController:[[YDViewController alloc] init] animated:YES];
    }
    else if (sender.tag == 107){
        [[ProjectTool getCurrentViewController].navigationController pushViewController:[[ServerViewController alloc] init] animated:YES];
    }
    else if ((sender.tag >= 100 && sender.tag <= 103) || sender.tag == 105){
        ListViewController *list = [[ListViewController alloc] init];
        list.type = sender.tag == 105 ? 5 : sender.tag - 99;
        [[ProjectTool getCurrentViewController].navigationController pushViewController:list animated:YES];
    }
    else if (sender.tag == 104){
        [[ProjectTool getCurrentViewController].navigationController pushViewController:[[PhysicianVisitsVC alloc] init] animated:YES];
    }
}

- (void)moreList{
    ListViewController *list = [[ListViewController alloc] init];
    list.type = 0;
    [[ProjectTool getCurrentViewController].navigationController pushViewController:list animated:YES];
}

- (void)setBannerData:(NSArray *)bannerData{
    _bannerData = bannerData;
    if (_bannerData) {
        NSMutableArray *tmp = [NSMutableArray array];
        for (NSDictionary *info in _bannerData) {
            [tmp addObject:info[@"image"]];
        }
        self.scrollView.imageURLStringsGroup = tmp;
    }
}

@end
