//
//  MSTableViewCell.m
//  HJZSU
//
//  Created by apple on 2019/3/14.
//  Copyright © 2019 apple. All rights reserved.
//

#import "MSTableViewCell.h"

@interface MSTableViewCell ()

@property (strong,nonatomic) UIImageView *headerImage;
@property (strong,nonatomic) UILabel *name;
@property (strong,nonatomic) UILabel *time;
@property (strong,nonatomic) UILabel *location;
@property (strong,nonatomic) UILabel *startTip;
@property (strong,nonatomic) UILabel *stratNumber;

@end

@implementation MSTableViewCell

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
        
        self.name = [LabelCreat creatLabelWith:@"活动名称" font:[UIFont systemFontOfSize:15] color:UIColorMake(51, 51, 51) textAlignment:NSTextAlignmentLeft];
        [self addSubview:self.headerImage];
        [self addSubview:self.name];
        
        [_headerImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(self).offset(13);
            make.bottom.equalTo(self).offset(-13);
            make.width.offset(88);
        }];
        
        [_name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(13);
            make.left.equalTo(self.headerImage.mas_right).offset(13);
            make.right.equalTo(self).offset(-13);
        }];
        
        
        self.time = [LabelCreat creatLabelWith:@"2019/09/22-2019/12/12" font:[UIFont systemFontOfSize:12] color:UIColorMake(137, 137, 137) textAlignment:NSTextAlignmentLeft];
        self.location = [LabelCreat creatLabelWith:@"成都天府新区" font:[UIFont systemFontOfSize:12] color:UIColorMake(137, 137, 137) textAlignment:NSTextAlignmentLeft];
        
        UIView *timeView = [self tipViewWith:@"时间-小-灰色" and:self.time];
        UIView *locationView = [self tipViewWith:@"定位--小-灰色" and:self.location];
        
        
        [self addSubview:timeView];
        [self addSubview:locationView];
        
        [timeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.name.mas_bottom).offset(5);
            make.left.equalTo(self.headerImage.mas_right).offset(13);
            make.right.equalTo(self).offset(-13);
        }];
        
        [locationView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(timeView.mas_bottom).offset(5);
            make.left.equalTo(self.headerImage.mas_right).offset(13);
            make.right.equalTo(self).offset(-13);
        }];
        
        self.startTip = [LabelCreat creatLabelWith:@"用户星评" font:[UIFont systemFontOfSize:12] color:UIColorMake(137, 137, 137) textAlignment:NSTextAlignmentLeft];
        [self addSubview:self.startTip];
        [_startTip mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self).offset(-13);
            make.left.equalTo(self.headerImage.mas_right).offset(13);
        }];
        
        [self addStart];
        
        self.stratNumber = [LabelCreat creatLabelWith:@"5.0" font:[UIFont systemFontOfSize:12] color:UIColorMake(137, 137, 137) textAlignment:NSTextAlignmentLeft];
        [self addSubview:self.stratNumber];
        [_stratNumber mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self).offset(-13);
            make.left.equalTo(self.startTip.mas_right).offset(20 +  19 * 5);
        }];
        
        UIView *line  = [[UIView alloc] init];
        line.backgroundColor = UIColorMake(239, 239, 239);
        [self addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.equalTo(self).offset(0);
            make.height.offset(1.0);
        }];
        
    }
    return self;
}

- (UIImageView *)headerImage{
    if (!_headerImage) {
        _headerImage = [[UIImageView alloc] init];
        _headerImage.backgroundColor = [UIColor whiteColor];
        _headerImage.image = PLACEHOLDERIMAGE;
        _headerImage.layer.cornerRadius = 5;
        _headerImage.clipsToBounds = YES;
    }
    return _headerImage;
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

- (void)addStart{
    for (int i = 0; i < 5; i++) {
        UIImageView *start = [[UIImageView alloc] init];
        start.image = [UIImage imageNamed:@"星-大-未选中"];
        start.contentMode = UIViewContentModeScaleAspectFit;
        start.tag = 100 + i;
        [self addSubview:start];
        
        [start mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self).offset(-13);
            make.left.equalTo(self.startTip.mas_right).offset(10 + (19) * i);
            make.width.height.offset(15);
        }];
    }
}

- (void)setModel:(SubHisModel *)model{
    _model = model;
    if (_model) {
        _name.text = _model.name;
        _time.text = [NSString stringWithFormat:@"%@-%@",[ProjectTool dateTimerConversionWithTimeStamp:_model.start_time],[ProjectTool dateTimerConversionWithTimeStamp:_model.end_time]];
        _location.text = _model.address;
        [_headerImage sd_setImageWithURL:[NSURL URLWithString:[_model.images componentsSeparatedByString:@";"].firstObject] placeholderImage:PLACEHOLDERIMAGE];
        for (int i = 0; i < 5; i++) {
            UIImageView *start = [self viewWithTag:100 + i];
            if (i < _model.score) {
                start.image = [UIImage imageNamed:@"星-大-未选中"];
            }
            else{
                start.image = [UIImage imageNamed:@"星-大-选中"];
            }
        }
    }
}


@end
