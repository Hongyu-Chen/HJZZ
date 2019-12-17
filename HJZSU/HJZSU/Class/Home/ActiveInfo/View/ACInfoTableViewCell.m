//
//  ACInfoTableViewCell.m
//  HJZSS
//
//  Created by apple on 2019/2/27.
//  Copyright © 2019 apple. All rights reserved.
//

#import "ACInfoTableViewCell.h"
#import "SDCycleScrollView.h"

@interface ACInfoTableViewCell ()<SDCycleScrollViewDelegate>

@property (strong,nonatomic) SDCycleScrollView *scrollView;
@property (strong,nonatomic) UILabel *name;
@property (strong,nonatomic) UILabel *time;
@property (strong,nonatomic) UILabel *locaiton;

@end

@implementation ACInfoTableViewCell

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
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.scrollView];
        [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self).offset(0);
            make.height.offset(279);
        }];
        self.name = [LabelCreat creatLabelWith:@"活动名称" font:[UIFont boldSystemFontOfSize:15] color:UIColorMake(51, 51, 51) textAlignment:NSTextAlignmentLeft];
        self.time = [LabelCreat creatLabelWith:@"2019/09/22-2019/12/12" font:[UIFont systemFontOfSize:12] color:UIColorMake(137, 137, 137) textAlignment:NSTextAlignmentLeft];
        self.locaiton = [LabelCreat creatLabelWith:@"成都天府新区" font:[UIFont systemFontOfSize:12] color:UIColorMake(137, 137, 137) textAlignment:NSTextAlignmentLeft];
        
        
        UIView *timeView = [self tipViewWith:@"时间-小-灰色" and:self.time];
        UIView *locationView = [self tipViewWith:@"定位--小-灰色" and:self.locaiton];
        
        [self addSubview:self.name];
        [self addSubview:timeView];
        [self addSubview:locationView];
        
        [_name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.scrollView.mas_bottom).offset(0);
            make.left.equalTo(self).offset(13);
            make.right.equalTo(self).offset(-13);
            make.height.offset(50);
        }];
        
        [timeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.name.mas_bottom).offset(13);
            make.left.equalTo(self).offset(13);
            make.right.equalTo(self).offset(-13);
            make.height.offset(25.0);
        }];
        
        [locationView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(timeView.mas_bottom).offset(0);
            make.left.equalTo(self).offset(13);
            make.right.bottom.equalTo(self).offset(-22);
            make.height.offset(25.5);
        }];
        
        UIView *line  = [[UIView alloc] init];
        line.backgroundColor = UIColorMake(239, 239, 239);
        [self addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.equalTo(self).offset(0);
            make.height.offset(13);
        }];
        
        UIView *line1  = [[UIView alloc] init];
        line1.backgroundColor = UIColorMake(239, 239, 239);
        [self addSubview:line1];
        [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.name.mas_bottom).offset(0);
            make.left.right.equalTo(self).offset(0);
            make.height.offset(1);
        }];
        
    }
    return self;
}

- (SDCycleScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200) delegate:self placeholderImage:PLACEHOLDERIMAGE];
        _scrollView.delegate = self;
        _scrollView.imageURLStringsGroup = @[@"",@"",@""];
        _scrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
    }
    return _scrollView;
}

/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    
}

- (UIView *)tipViewWith:(NSString *)image and:(UILabel *)label{
    UIView *view = [[UIView alloc] init];
    UIImageView *icon = [[UIImageView alloc] init];
    icon.contentMode = UIViewContentModeScaleAspectFit;
    icon.image = [UIImage imageNamed:image];
    
    [view addSubview:icon];
    [view addSubview:label];
    
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(view).offset(0);
        make.width.offset(15);
    }];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.top.right.equalTo(view).offset(0);
        make.left.equalTo(icon.mas_right).offset(10);
    }];
    return view;
}

- (void)setActiviteInfo:(NSDictionary *)activiteInfo{
    _activiteInfo = activiteInfo;
    if (_activiteInfo) {
        NSString *images = _activiteInfo[@"images"];
        _name.text = [NSString stringWithFormat:@"%@    订单编号：%@",_activiteInfo[@"typeName"],_activiteInfo[@"orderNo"]];
        _time.text = [NSString setTImeWithStartTime:_activiteInfo[@"start_time"] endTime:_activiteInfo[@"end_time"]];
        _locaiton.text = _activiteInfo[@"address"];
        NSMutableArray *urls = [NSMutableArray array];
        for (NSString *str in [images componentsSeparatedByString:@";"]) {
            if (!IsNullString(str)) {
                [urls addObject:[NSURL URLWithString:str]];
            }
        }
        _scrollView.imageURLStringsGroup = urls;
    }
}


@end
