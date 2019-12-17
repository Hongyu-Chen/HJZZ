//
//  TTopInfoTableViewCell.m
//  HJZSU
//
//  Created by apple on 2019/3/13.
//  Copyright © 2019 apple. All rights reserved.
//

#import "TTopInfoTableViewCell.h"

@interface TTopInfoTableViewCell ()

@property (strong,nonatomic) UIImageView *bgImageView;
@property (strong,nonatomic) UIImageView *headerImage;
@property (strong,nonatomic) FormatLabel *name;
@property (strong,nonatomic) FormatLabel *teameLev;
@property (strong,nonatomic) FormatLabel *teamNumber;
@property (strong,nonatomic) FormatLabel *teameTimes;

@property (strong,nonatomic) UIImageView *iconImage;
@property (strong,nonatomic) UILabel *tip;
@property (strong,nonatomic) UIView *bottomView;
@property (strong,nonatomic) UILabel *teamTip;

@end

@implementation TTopInfoTableViewCell

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
        self.tip = [LabelCreat creatLabelWith:@"团队格言" font:[UIFont systemFontOfSize:15] color:UIColorMake(34, 34, 34) textAlignment:NSTextAlignmentLeft];
        self.teamTip = [LabelCreat creatLabelWith:@"不求最好，只求更好！" font:[UIFont boldSystemFontOfSize:15] color:UIColorMake(34, 34, 34) textAlignment:NSTextAlignmentCenter];
        [self addSubview:self.bgImageView];
        [self addSubview:self.iconImage];
        [self addSubview:self.tip];
        [self addSubview:self.bottomView];
        [self addSubview:self.teamTip];
        
        [_bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(0);
            make.left.right.equalTo(self).offset(0);
            make.bottom.equalTo(self).offset(-90);
            make.height.offset(176 + NavigationContentTopConstant);
        }];
        
        [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(NavigationContentTopConstant);
            make.left.right.equalTo(self).offset(0);
            make.height.offset(176);
        }];
        
        [_iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.bottomView.mas_bottom).offset(0);
            make.left.equalTo(self).offset(13);
            make.height.offset(50);
            make.width.offset(7.5);
        }];
        
        [_tip mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.bottomView.mas_bottom).offset(0);
            make.left.equalTo(self.iconImage.mas_right).offset(10);
            make.right.equalTo(self).offset(-13);
            make.height.offset(50);
        }];
        
        [_teamTip mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.tip.mas_bottom).offset(0);
            make.left.right.equalTo(self).offset(0);
            make.height.offset(40);
        }];
        
        
    }
    return self;
}

- (UIImageView *)bgImageView{
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc] init];
        _bgImageView.contentMode = UIViewContentModeScaleAspectFill;
        _bgImageView.clipsToBounds = YES;
        _bgImageView.image = [UIImage imageNamed:@"明星团队底图"];
        _bgImageView.backgroundColor = [UIColor redColor];
    }
    return _bgImageView;
}

- (UIImageView *)iconImage{
    if (!_iconImage) {
        _iconImage = [[UIImageView alloc] init];
        _iconImage.contentMode = UIViewContentModeScaleAspectFit;
        _iconImage.image = [UIImage imageNamed:@"装饰"];
    }
    return _iconImage;
}

- (UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
        _bottomView.backgroundColor = [UIColor clearColor];
        
        [_bottomView addSubview:self.headerImage];
        [_bottomView addSubview:self.name];
        [_bottomView addSubview:self.teameLev];
        [_bottomView addSubview:self.teamNumber];
        [_bottomView addSubview:self.teameTimes];
        
        [_headerImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.bottomView).offset(13);
            make.left.equalTo(self.bottomView).offset(13);
            make.bottom.equalTo(self.bottomView).offset(-13);
            make.width.offset(119);
        }];
        
        [_name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.bottomView).offset(13);
            make.left.equalTo(self.headerImage.mas_right).offset(13);
            make.right.equalTo(self.bottomView).offset(-13);
        }];
        
        [_teameLev mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.name.mas_bottom).offset(0);
            make.left.equalTo(self.headerImage.mas_right).offset(13);
            make.right.equalTo(self.bottomView).offset(-13);
            make.height.equalTo(self.name);
        }];
        
        [_teamNumber mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.teameLev.mas_bottom).offset(0);
            make.left.equalTo(self.headerImage.mas_right).offset(13);
            make.right.equalTo(self.bottomView).offset(-13);
            make.height.equalTo(self.teameLev);
        }];
        
        [_teameTimes mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.teamNumber.mas_bottom).offset(0);
            make.left.equalTo(self.headerImage.mas_right).offset(13);
            make.right.equalTo(self.bottomView).offset(-13);
            make.height.equalTo(self.teamNumber);
            make.bottom.equalTo(self.bottomView).offset(-13);
        }];
    }
    return _bottomView;
}

- (UIImageView *)headerImage{
    if (!_headerImage) {
        _headerImage = [[UIImageView alloc] init];
        _headerImage.contentMode = UIViewContentModeScaleAspectFill;
        _headerImage.layer.cornerRadius = 5;
        _headerImage.clipsToBounds = YES;
        _headerImage.backgroundColor = [UIColor whiteColor];
        _headerImage.image = PLACEHOLDERIMAGE;
    }
    return _headerImage;
}

- (FormatLabel *)name{
    if (!_name) {
        _name = [[FormatLabel alloc] init];
        _name.font = [UIFont boldSystemFontOfSize:15];
        _name.textColor = [UIColor whiteColor];
        _name.text = @"团队名称";
    }
    return _name;
}

- (FormatLabel *)teameLev{
    if (!_teameLev) {
        _teameLev = [[FormatLabel alloc] init];
        _teameLev.font = [UIFont systemFontOfSize:15];
        _teameLev.textColor = UIColorMake(137, 137, 137);
        _teameLev.text = @"团队等级     高级战神";
        [_teameLev setHeightLightWords:@[@"高级战神"] heightLightColors:@[[UIColor whiteColor]] htightLightFont:@[[UIFont boldSystemFontOfSize:15]]];
    }
    return _teameLev;
}

- (FormatLabel *)teamNumber{
    if (!_teamNumber) {
        _teamNumber = [[FormatLabel alloc] init];
        _teamNumber.font = [UIFont systemFontOfSize:15];
        _teamNumber.textColor = UIColorMake(137, 137, 137);
        _teamNumber.text = @"团队人数     5人";
        [_teamNumber setHeightLightWords:@[@"5人"] heightLightColors:@[[UIColor whiteColor]] htightLightFont:@[[UIFont boldSystemFontOfSize:15]]];
    }
    return _teamNumber;
}

- (FormatLabel *)teameTimes{
    if (!_teameTimes) {
        _teameTimes = [[FormatLabel alloc] init];
        _teameTimes.font = [UIFont systemFontOfSize:15];
        _teameTimes.textColor = UIColorMake(137, 137, 137);
        _teameTimes.text = @"执行场次      21次";
        [_teameTimes setHeightLightWords:@[@"21次"] heightLightColors:@[[UIColor whiteColor]] htightLightFont:@[[UIFont boldSystemFontOfSize:15]]];
    }
    return _teameTimes;
}

- (void)setInfo:(NSDictionary *)info{
    _info = info;
    if (_info) {
        _name.text = _info[@"name"];
        _teamNumber.text = [NSString stringWithFormat:@"团队人数     %@人",_info[@"members"]];
        [_teamNumber setHeightLightWords:@[[NSString stringWithFormat:@"%@人",_info[@"members"]]] heightLightColors:@[[UIColor whiteColor]] htightLightFont:@[[UIFont boldSystemFontOfSize:15]]];
        _teameTimes.text = [NSString stringWithFormat:@"执行场次      %@次",_info[@"num"]];
        [_teameTimes setHeightLightWords:@[[NSString stringWithFormat:@"%@次",_info[@"num"]]] heightLightColors:@[[UIColor whiteColor]] htightLightFont:@[[UIFont boldSystemFontOfSize:15]]];
        [_headerImage sd_setImageWithURL:[NSURL URLWithString:[[_info[@"teamLogo"] componentsSeparatedByString:@";"] firstObject]] placeholderImage:PLACEHOLDERIMAGE];
        _teamTip.text = _info[@"motto"];
    }
}


@end
