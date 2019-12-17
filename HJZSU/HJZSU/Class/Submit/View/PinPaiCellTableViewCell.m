//
//  PinPaiCellTableViewCell.m
//  HJZSU
//
//  Created by apple on 2019/5/17.
//  Copyright © 2019 apple. All rights reserved.
//

#import "PinPaiCellTableViewCell.h"

@interface PinPaiCellTableViewCell ()

@property (strong,nonatomic) FormatLabel *tip1;
@property (strong,nonatomic) UIImageView *tipBg;
@property (strong,nonatomic) UIButton *add;
@property (strong,nonatomic) UIButton *jian;
@property (strong,nonatomic) UILabel *numberLab;
@property (strong,nonatomic) UILabel *peixunTip;

@end

@implementation PinPaiCellTableViewCell

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
        
        [self addSubview:self.tip1];
        [self addSubview:self.tipBg];
        self.peixunTip = [LabelCreat creatLabelWith:@"每增加一个品牌增加15单" font:[UIFont systemFontOfSize:13] color:UIColorMake(250, 80, 0) textAlignment:NSTextAlignmentLeft];
        [self addSubview:self.peixunTip];
        
        [_tip1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(0);
            make.left.equalTo(self).offset(13);
            make.right.equalTo(self).offset(-13);
            make.height.offset(50);
        }];
        
        [_peixunTip mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.tip1.mas_bottom).offset(5);
            make.left.equalTo(self).offset(13);
            make.right.equalTo(self).offset(-13);
            make.bottom.equalTo(self).offset(-10);
            make.height.offset(12);
        }];
        
        [_tipBg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(5);
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
        _tip1.text = [NSString stringWithFormat:@"品牌 价格¥%.0f/个",[YYCacheManager shareYYCacheManager].pingpaiPrice];
        [_tip1 setHeightLightWords:@[[NSString stringWithFormat:@"价格¥%.0f/个",[YYCacheManager shareYYCacheManager].pingpaiPrice]] heightLightColors:@[UIColorMake(34, 34, 34)] htightLightFont:@[[UIFont systemFontOfSize:15]]];
    }
    return _tip1;
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
        self.numberLab = [LabelCreat creatLabelWith:@"0" font:[UIFont systemFontOfSize:15] color:UIColorMake(34, 34, 34) textAlignment:NSTextAlignmentCenter];
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
        self.submitModel.pin_num = [_numberLab.text integerValue] + 10;
    }
    else if (sender.tag == 101){
        NSInteger count = [_numberLab.text integerValue] - 1;
        if (count <= 0) {
            count = 0;
        }
        _numberLab.text = [NSString stringWithFormat:@"%ld",count];
        self.submitModel.pin_num = [_numberLab.text integerValue] + 10;
    }
    
    if (self.numberChangedBlock) {
        self.numberChangedBlock(YES);
    }
}

- (void)setSubmitModel:(SubmitModel *)submitModel{
    _submitModel = submitModel;
    if (_submitModel) {
        _numberLab.text = [NSString stringWithFormat:@"%ld",_submitModel.pin_num - 10];
    }
}



@end
