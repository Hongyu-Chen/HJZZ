//
//  STTipTableViewCell.m
//  HJZSU
//
//  Created by apple on 2019/3/11.
//  Copyright © 2019 apple. All rights reserved.
//

#import "STTipTableViewCell.h"

@interface STTipTableViewCell ()

@property (strong,nonatomic) QMUIButton *selectedBtn;
@property (strong,nonatomic) UILabel *monenyLab;

@end

@implementation STTipTableViewCell

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
        self.monenyLab = [LabelCreat creatLabelWith:@"任务：金额达到40万" font:[UIFont systemFontOfSize:15] color:UIColorMake(137, 137, 137) textAlignment:NSTextAlignmentRight];
        [self addSubview:self.selectedBtn];
        [self addSubview:self.monenyLab];
        
        [_selectedBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self).offset(0);
            make.left.equalTo(self).offset(13);
            make.height.offset(50);
        }];
        
        [_monenyLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self).offset(0);
            make.right.equalTo(self).offset(-13);
            make.height.equalTo(self.selectedBtn);
        }];
        
        
    }
    return self;
}

- (QMUIButton *)selectedBtn{
    if (!_selectedBtn) {
        _selectedBtn = [[QMUIButton alloc] init];
        [_selectedBtn setImage:[UIImage imageNamed:@"勾选-未选中"] forState:UIControlStateNormal];
        [_selectedBtn setImage:[UIImage imageNamed:@"勾选-选中-圆圈"] forState:UIControlStateSelected];
        [_selectedBtn setTitle:@"套餐A" forState:UIControlStateNormal];
        _selectedBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_selectedBtn setTitleColor:UIColorMake(34, 34, 34) forState:UIControlStateNormal];
        _selectedBtn.imagePosition = QMUIButtonImagePositionLeft;
        _selectedBtn.spacingBetweenImageAndTitle = 15;
        [_selectedBtn addTarget:self action:@selector(selectionSection:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectedBtn;
}

- (void)setModel:(PlanModel *)model{
    _model = model;
    if (_model) {
        [_selectedBtn setTitle:_model.planName forState:UIControlStateNormal];
        _monenyLab.text = _model.mission;
        _selectedBtn.selected = _model.selected;
        
        if (_subMitModel.activityType == 5) {
            _monenyLab.hidden = YES;
        }
        else if (_subMitModel.activityType == 2){
            _monenyLab.hidden = NO;
            _monenyLab.text = [NSString stringWithFormat:@"任务:%@单",_model.task];
        }
        else if (_subMitModel.activityType == 3){
            _monenyLab.hidden = NO;
            _monenyLab.text = [NSString stringWithFormat:@"任务:%ld个品牌%ld单",_subMitModel.pin_num,(_subMitModel.pin_num - 10) * [YYCacheManager shareYYCacheManager].taskNumer + [_model.task integerValue]];
        }
        else if (_subMitModel.activityType == 4){
            _monenyLab.hidden = NO;
            _monenyLab.text = [NSString stringWithFormat:@"任务:%ld个商家%ld单",_model.supervision_number + [YYCacheManager shareYYCacheManager].arciveNumer,[_model.task integerValue] + _model.supervision_number * [YYCacheManager shareYYCacheManager].taskNumer];
        }
        else{
            _monenyLab.hidden = NO;
        }
    }
}

- (void)selectionSection:(QMUIButton *)sender{
    sender.selected = !sender.selected;
    self.model.selected = sender.selected;
    if (self.selectionBlock) {
        self.selectionBlock(self.model,sender.selected);
    }
}


@end
