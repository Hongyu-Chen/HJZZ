//
//  PVTableViewCell.m
//  HJZSU
//
//  Created by apple on 2019/3/7.
//  Copyright © 2019 apple. All rights reserved.
//

#import "PVTableViewCell.h"
#import "SDCycleScrollView.h"
#import "CommentViewController.h"
//#import ""
@interface PVTableViewCell ()<SDCycleScrollViewDelegate>


@property (strong,nonatomic) UIImageView *headerImage;
@property (strong,nonatomic) UILabel *name;
@property (strong,nonatomic) UILabel *time;
@property (strong,nonatomic) FormatLabel *location;
@property (strong,nonatomic) FormatLabel *recommCount;
@property (strong,nonatomic) UIButton *check;
@property (strong,nonatomic) UILabel *titleLab;
@property (strong,nonatomic) SDCycleScrollView *scrollView;
@property (strong,nonatomic) UIButton *deleteBtn;

@end

@implementation PVTableViewCell

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
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.name = [LabelCreat creatLabelWith:@"JSON" font:[UIFont boldSystemFontOfSize:18] color:UIColorMake(51, 51, 51) textAlignment:NSTextAlignmentLeft];
        self.time = [LabelCreat creatLabelWith:@"3小时前" font:[UIFont systemFontOfSize:12] color:UIColorMake(137, 137, 137) textAlignment:NSTextAlignmentLeft];
        self.titleLab = [LabelCreat creatLabelWith:@"标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题" font:[UIFont systemFontOfSize:17] color:UIColorMake(51, 51, 51) textAlignment:NSTextAlignmentLeft];
        self.titleLab.numberOfLines = 2;
        [self addSubview:self.headerImage];
        [self addSubview:self.name];
        [self addSubview:self.time];
        [self addSubview:self.scrollView];
        [self addSubview:self.location];
        [self addSubview:self.recommCount];
        [self addSubview:self.check];
        [self addSubview:self.titleLab];
        [self addSubview:self.deleteBtn];
        
        [_headerImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(13);
            make.left.equalTo(self).offset(13);
            make.width.height.offset(50);
        }];
        
        [_name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(13);
            make.left.equalTo(self.headerImage.mas_right).offset(13);
            make.height.equalTo(self.headerImage);
        }];
        
        [_time mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(13);
            make.right.equalTo(self).offset(-13);
            make.height.equalTo(self.headerImage);
        }];
        
        [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.headerImage.mas_bottom).offset(13);
            make.left.right.equalTo(self).offset(0);
            make.height.offset(SCREEN_WIDTH * 480.0/750.0);
        }];
        
        [_location mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.scrollView.mas_bottom).offset(13);
            make.left.equalTo(self).offset(13);
        }];
        
        [_deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.scrollView.mas_bottom).offset(13);
            make.right.equalTo(self).offset(-13);
            make.height.equalTo(self.location);
        }];
        
        [_check mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.scrollView.mas_bottom).offset(13);
            make.right.equalTo(self.deleteBtn.mas_left).offset(-13);
            make.height.equalTo(self.location);
        }];
        
        [_recommCount mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.scrollView.mas_bottom).offset(13);
            make.right.equalTo(self.check.mas_left).offset(-13);
            make.height.equalTo(self.location);
        }];
        
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.location.mas_bottom).offset(13);
            make.left.equalTo(self).offset(13);
            make.right.equalTo(self).offset(-13);
            make.bottom.equalTo(self).offset(-19);
        }];
        
        UIView *line  = [[UIView alloc] init];
        line.backgroundColor = UIColorMake(239, 239, 239);
        [self addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.equalTo(self).offset(0);
            make.height.offset(6.0);
        }];
        
    }
    return self;
}

- (UIImageView *)headerImage{
    if (!_headerImage) {
        _headerImage = [[UIImageView alloc] init];
        _headerImage.contentMode = UIViewContentModeScaleAspectFill;
        _headerImage.clipsToBounds = YES;
        _headerImage.layer.cornerRadius = 25;
        _headerImage.backgroundColor = [UIColor whiteColor];
        _headerImage.image = PLACEHOLDERIMAGE;
    }
    return _headerImage;
}

- (FormatLabel *)location{
    if (!_location) {
        _location = [[FormatLabel alloc] init];
        _location.textColor = UIColorMake(137, 137, 137);
        _location.font = [UIFont systemFontOfSize:13];
        _location.text = @"   成都市 高新区天府三街";
        [_location setImage:[UIImage imageNamed:@"定位--小-灰色"] toIndex:0 imageFrame:CGRectMake(0, -2, 14, 14)];
    }
    return _location;
}

- (FormatLabel *)recommCount{
    if (!_recommCount) {
        _recommCount = [[FormatLabel alloc] init];
        _recommCount.textColor = UIColorMake(137, 137, 137);
        _recommCount.font = [UIFont systemFontOfSize:13];
        _recommCount.text = @"   0";
        [_recommCount setImage:[UIImage imageNamed:@"终端问诊评论"] toIndex:0 imageFrame:CGRectMake(0, -2, 14, 14)];
    }
    return _recommCount;
}

-(UIButton *)check{
    if (!_check) {
        _check = [[UIButton alloc] init];
        [_check setTitle:@"查看评论" forState:UIControlStateNormal];
        [_check setTitleColor:UIColorMake(51, 51, 51) forState:UIControlStateNormal];
        _check.titleLabel.font = [UIFont boldSystemFontOfSize:13];
        [_check addTarget:self action:@selector(checkButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    }
    return _check;
}

- (SDCycleScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 76, SCREEN_WIDTH, SCREEN_WIDTH * 480.0/750.0) delegate:self placeholderImage:PLACEHOLDERIMAGE];
        _scrollView.delegate = self;
        _scrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
    }
    return _scrollView;
}

- (UIButton *)deleteBtn{
    if (!_deleteBtn) {
        _deleteBtn  = [[UIButton alloc] init];
        [_deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
        [_deleteBtn setTitleColor:UIColorMake(250, 80, 0) forState:UIControlStateNormal];
        _deleteBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_deleteBtn addTarget:self action:@selector(deletePhusicianVisitsVC) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteBtn;
}

/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    
}

- (void)checkButtonPressed{
    CommentViewController *commentVC = [[CommentViewController alloc] init];
    commentVC.articleId = [self.cellInfo[@"id"] integerValue];
    [[ProjectTool getCurrentViewController].navigationController pushViewController:commentVC animated:YES];
}

- (void)deletePhusicianVisitsVC{
    [QMUITips showLoadingInView:[UIApplication sharedApplication].keyWindow];
    [self deleteProjectWith:self.cellInfo[@"id"] success:^(id  _Nonnull result) {
        [QMUITips hideAllTips];
        if (self.userDeleteSuccess) {
            self.userDeleteSuccess();
        }
    } failed:^(NSString * _Nonnull reson) {
        [QMUITips hideAllTips];
        [QMUITips showWithText:reson];
    }];
}

- (void)setCellInfo:(NSDictionary *)cellInfo{
    _cellInfo = cellInfo;
    if (_cellInfo) {
        [_headerImage sd_setImageWithURL:[NSURL URLWithString:_cellInfo[@"userHead"]] placeholderImage:PLACEHOLDERIMAGE];
        _name.text = _cellInfo[@"userName"];
        _time.text = [NSString returnTimeWith:_cellInfo[@"create_time"]];
        _location.text = IsNullString(_cellInfo[@"address"]) ? @"暂无地址" : _cellInfo[@"address"];
        NSMutableArray *urls = [NSMutableArray array];
        for (NSString *str in [_cellInfo[@"images"] componentsSeparatedByString:@";"]) {
            if (!IsNullString(str)) {
                [urls addObject:[NSURL URLWithString:str]];
            }
        }
        _scrollView.imageURLStringsGroup = urls;
        [_location setImage:[UIImage imageNamed:@"定位--小-灰色"] toIndex:0 imageFrame:CGRectMake(0, -2, 14, 14)];
        NSString *num = [NSString stringWithFormat:@"   %@",_cellInfo[@"levelOne"]];
        _recommCount.text = num;
        [_recommCount setImage:[UIImage imageNamed:@"终端问诊评论"] toIndex:0 imageFrame:CGRectMake(0, -2, 14, 14)];
        _titleLab.text = _cellInfo[@"content"];
        
        if ([[NSString stringWithFormat:@"%@",_cellInfo[@"userId"]] isEqualToString:[[YYCacheManager shareYYCacheManager] uid]]) {
            self.deleteBtn.hidden = NO;
            [self.deleteBtn mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.offset(30);
            }];
            [self.check mas_updateConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self.deleteBtn.mas_left).offset(-13);
            }];
        }
        else{
            self.deleteBtn.hidden = YES;
            [self.deleteBtn mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.offset(0);
            }];
            [self.check mas_updateConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self.deleteBtn.mas_left).offset(0);
            }];
        }
        
    }
}

@end
