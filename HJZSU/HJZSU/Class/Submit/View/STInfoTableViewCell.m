//
//  STInfoTableViewCell.m
//  HJZSU
//
//  Created by apple on 2019/3/11.
//  Copyright © 2019 apple. All rights reserved.
//

#import "STInfoTableViewCell.h"

@interface STInfoTableViewCell ()

@property (strong,nonatomic) FormatLabel *tip1;
@property (strong,nonatomic) FormatLabel *tip2;
@property (strong,nonatomic) UIImageView *tipBg;
@property (strong,nonatomic) UIButton *add;
@property (strong,nonatomic) UIButton *jian;
@property (strong,nonatomic) UILabel *numberLab;
@property (strong,nonatomic) UILabel *peixunTip;

@end

@implementation STInfoTableViewCell

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
        
        self.peixunTip = [LabelCreat creatLabelWith:@"课时为8小时/天" font:[UIFont systemFontOfSize:13] color:UIColorMake(137, 137, 137) textAlignment:NSTextAlignmentLeft];
        [self addSubview:self.tip1];
        [self addSubview:self.tip2];
        [self addSubview:self.tipBg];
        [self addSubview:self.peixunTip];
        
        [_tip1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(0);
            make.left.equalTo(self).offset(13);
            make.right.equalTo(self).offset(-13);
            make.height.offset(50);
        }];
        
        [_tip2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.tip1.mas_bottom).offset(0);
            make.left.equalTo(self).offset(13);
            make.right.equalTo(self).offset(-13);
            make.height.equalTo(self.tip1);
        }];
        
        [_peixunTip mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.tip2.mas_bottom).offset(0);
            make.left.equalTo(self).offset(13);
            make.right.equalTo(self).offset(-13);
            make.bottom.equalTo(self).offset(-10);
            make.height.offset(12);
        }];
        
        [_tipBg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.tip1.mas_bottom).offset(5);
            make.right.equalTo(self).offset(-13);
            make.height.offset(40);
            make.width.offset(168);
        }];
        
    }
    return self;
}

- (FormatLabel *)tip1{
    if (!_tip1) {
        _tip1 = [[FormatLabel alloc] init];
        _tip1.textColor = UIColorMake(137, 137, 137);
        _tip1.font = [UIFont systemFontOfSize:15];
        _tip1.text = @"主控      ¥1000";
        [_tip1 setHeightLightWords:@[@"¥1000"] heightLightColors:@[UIColorMake(34, 34, 34)] htightLightFont:@[[UIFont systemFontOfSize:15]]];
    }
    return _tip1;
}

- (FormatLabel *)tip2{
    if (!_tip2) {
        _tip2 = [[FormatLabel alloc] init];
        _tip2.textColor = UIColorMake(137, 137, 137);
        _tip2.font = [UIFont systemFontOfSize:15];
        _tip2.text = @"督导      ¥ 1000 / 名";
        [_tip2 setHeightLightWords:@[@"¥ 1000 / 名"] heightLightColors:@[UIColorMake(34, 34, 34)] htightLightFont:@[[UIFont systemFontOfSize:15]]];
    }
    return _tip2;
}

- (UIImageView *)tipBg{
    if (!_tipBg) {
        _tipBg = [[UIImageView alloc] init];
        _tipBg.contentMode = UIViewContentModeScaleAspectFit;
        _tipBg.image = [UIImage imageNamed:@"加减"];
        _tipBg.backgroundColor = UIColorMake(239, 239, 239);
        _tipBg.userInteractionEnabled = YES;
        [_tipBg addSubview:self.add];
        [_tipBg addSubview:self.jian];
        self.numberLab = [LabelCreat creatLabelWith:@"1" font:[UIFont systemFontOfSize:15] color:UIColorMake(34, 34, 34) textAlignment:NSTextAlignmentCenter];
        [_tipBg addSubview:_numberLab];
        
        [_add mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.bottom.equalTo(self.tipBg).offset(0);
            make.width.offset(40);
        }];
        
        [_jian mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.equalTo(self.tipBg).offset(0);
            make.width.offset(40);
        }];
        
        [_numberLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.tipBg).offset(0);
            make.left.equalTo(self.tipBg).offset(40);
            make.right.equalTo(self.tipBg).offset(-40);
        }];
        
    }
    return _tipBg;
}

- (UIButton *)add{
    if (!_add) {
        _add = [[UIButton alloc] init];
        _add.tag = 100;
        [_add addTarget:self action:@selector(changedNumber:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _add;
}

- (UIButton *)jian{
    if (!_jian) {
        _jian = [[UIButton alloc] init];
        _jian.tag = 101;
        [_jian addTarget:self action:@selector(changedNumber:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _jian;
}

- (void)changedNumber:(UIButton *)sender{
    if (sender.tag == 100) {
        _numberLab.text = [NSString stringWithFormat:@"%ld",[_numberLab.text integerValue] + 1];
        self.model.supervision_number = [_numberLab.text integerValue];
    }
    else if (sender.tag == 101){
        NSInteger count = [_numberLab.text integerValue] - 1;
        if (_submitModel.activityType == 4) {
            if (count <= 0) {
                count = 0;
            }
        }
        else{
            if (count <= 0) {
                count = 1;
            }
        }
        _numberLab.text = [NSString stringWithFormat:@"%ld",count];
        self.model.supervision_number = [_numberLab.text integerValue];
    }
    
    if (self.numberChangedBlock) {
        self.numberChangedBlock(YES);
    }
}

- (void)setModel:(PlanModel *)model{
    _model = model;
    if (_model) {
        
        if (_submitModel.activityType == 5) {
            _tip1.text = [NSString stringWithFormat:@"活动      ¥%.0f(不含食宿差旅，场地商家自备。)",_model.price_controller < 1 ? 1.0 : _model.price_controller];
            [_tip1 setHeightLightWords:@[[NSString stringWithFormat:@"¥%.0f",_model.price_controller < 1   ? 1.0 : _model.price_controller]] heightLightColors:@[UIColorMake(34, 34, 34)] htightLightFont:@[[UIFont systemFontOfSize:15]]];
            _tip2.text = [NSString stringWithFormat:@"天数      ¥ %.0f / 天",_model.price_controller < 1 ? 1.0 : _model.price_controller];
            [_tip2 setHeightLightWords:@[[NSString stringWithFormat:@"¥ %.0f / 天",_model.price_controller < 1 ? 1.0 : _model.price_controller]] heightLightColors:@[UIColorMake(34, 34, 34)] htightLightFont:@[[UIFont systemFontOfSize:15]]];
            _peixunTip.text = @"课时为8小时/天";
            [_peixunTip mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.offset(12);
            }];
        }
        else if (_submitModel.activityType == 4){
            _tip1.text = [NSString stringWithFormat:@"团队价格      ¥%.0f(仅为执行及食宿差旅费用)",_model.price_controller < 1 ? 1.0 : _model.price_controller];
            [_tip1 setHeightLightWords:@[[NSString stringWithFormat:@"¥%.0f",_model.price_controller < 1   ? 1.0 : _model.price_controller]] heightLightColors:@[UIColorMake(34, 34, 34)] htightLightFont:@[[UIFont systemFontOfSize:15]]];
            _tip2.text = [NSString stringWithFormat:@"商家      %ld",[YYCacheManager shareYYCacheManager].arciveNumer + _model.supervision_number];
            [_tip2 setHeightLightWords:@[[NSString stringWithFormat:@"%ld",[YYCacheManager shareYYCacheManager].arciveNumer + _model.supervision_number]] heightLightColors:@[UIColorMake(34, 34, 34)] htightLightFont:@[[UIFont systemFontOfSize:15]]];
            _peixunTip.text = @"每增加一个商家，任务数增加15单";
            _peixunTip.textColor = UIColorMake(250, 80, 0);
            [_peixunTip mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.offset(12);
            }];
        }
        else{
            _tip1.text = [NSString stringWithFormat:@"主控      ¥%.0f",_model.price_controller < 1 ? 1.0 : _model.price_controller];
            [_tip1 setHeightLightWords:@[[NSString stringWithFormat:@"¥%.0f",_model.price_controller < 1   ? 1.0 : _model.price_controller]] heightLightColors:@[UIColorMake(34, 34, 34)] htightLightFont:@[[UIFont systemFontOfSize:15]]];
            _tip2.text = [NSString stringWithFormat:@"督导      ¥ %.0f / 名",_model.price_supervision < 1 ? 1.0 : _model.price_supervision];
            [_tip2 setHeightLightWords:@[[NSString stringWithFormat:@"¥ %.0f / 名",_model.price_supervision < 1 ? 1.0 : _model.price_supervision]] heightLightColors:@[UIColorMake(34, 34, 34)] htightLightFont:@[[UIFont systemFontOfSize:15]]];
            [_peixunTip mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.offset(0);
            }];
        }
        _numberLab.text = [NSString stringWithFormat:@"%ld",model.supervision_number];
        
    }
}



@end
