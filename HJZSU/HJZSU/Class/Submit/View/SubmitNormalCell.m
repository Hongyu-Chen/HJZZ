//
//  SubmitNormalCell.m
//  HJZSU
//
//  Created by apple on 2019/3/9.
//  Copyright © 2019 apple. All rights reserved.
//

#import "SubmitNormalCell.h"

@interface SubmitNormalCell ()

@property (strong,nonatomic) UILabel *titleLab;
@property (strong,nonatomic) CHYTextField *input;
@property (strong,nonatomic) UIImageView *next;

@property (strong,nonatomic) UILabel *name;
@property (strong,nonatomic) UILabel *value1;
@property (strong,nonatomic) UILabel *value2;

@end

@implementation SubmitNormalCell

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
        self.titleLab = [LabelCreat creatLabelWith:@"标题" font:[UIFont systemFontOfSize:14] color:UIColorMake(51, 51, 51) textAlignment:NSTextAlignmentLeft];
        [self addSubview:self.titleLab];
        [self addSubview:self.input];
        [self addSubview:self.next];
        
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self).offset(0);
            make.left.equalTo(self).offset(13);
            make.height.offset(50);
        }];
        
        [_next mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self).offset(0);
            make.right.equalTo(self).offset(-13);
            make.width.offset(7.5);
        }];
        
        [_input mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(5);
            make.bottom.equalTo(self).offset(-5);
            make.right.equalTo(self.next.mas_left).offset(-10);
            make.width.offset(SCREEN_WIDTH * 0.5);
        }];
        
        UIView *lien = [[UIView alloc] init];
        lien.backgroundColor = UIColorMake(239, 239, 239);
        [self addSubview:lien];
        [lien mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-13);
            make.bottom.equalTo(self).offset(0);
            make.left.equalTo(self).offset(13);
            make.height.offset(1);
        }];
        
        self.name = [LabelCreat creatLabelWith:@"值" font:[UIFont systemFontOfSize:14] color:UIColorMake(137, 137, 137) textAlignment:NSTextAlignmentCenter];
        self.value1 = [LabelCreat creatLabelWith:@"值" font:[UIFont systemFontOfSize:14] color:UIColorMake(137, 137, 137) textAlignment:NSTextAlignmentCenter];
        self.value2 = [LabelCreat creatLabelWith:@"值" font:[UIFont systemFontOfSize:14] color:UIColorMake(137, 137, 137) textAlignment:NSTextAlignmentCenter];
        self.name.hidden = YES;
        self.value1.hidden = YES;
        self.value1.hidden = YES;
        [self addSubview:self.name];
        [self addSubview:self.value2];
        [self addSubview:self.value1];
        
        [_name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self).offset(0);
            make.left.equalTo(self).offset(13);
            make.height.offset(50);
        }];
        
        [_value1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self).offset(0);
            make.left.equalTo(self.name.mas_right).offset(0);
            make.width.equalTo(self.name);
        }];
        
        [_value2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self).offset(0);
            make.left.equalTo(self.value1.mas_right).offset(0);
            make.right.equalTo(self).offset(-13);
            make.width.equalTo(self.value1);
        }];
        
    }
    return self;
}

- (CHYTextField *)input{
    if (!_input) {
        _input = [[CHYTextField alloc] init];
        _input.placeholder = @"请输入信息";
        _input.font = [UIFont systemFontOfSize:14];
        _input.textColor = UIColorMake(137, 137, 137);
        _input.layer.borderWidth = 0.0;
        _input.layer.borderColor = UIColorMake(255, 80, 0).CGColor;
        _input.textAlignment = NSTextAlignmentRight;
        __weak typeof(self) weakself = self;
        _input.inputTextBlock = ^(NSString * _Nonnull inputText) {
            if (weakself.indexPath.section == 0 && weakself.indexPath.row == 0) {
                weakself.model.headPeo = inputText;
            }
            else if (weakself.indexPath.section == 0 && weakself.indexPath.row == 1){
                weakself.model.phone = inputText;
            }
        };
    }
    return _input;
}

- (UIImageView *)next{
    if (!_next) {
        _next = [[UIImageView alloc] init];
        _next.image = [UIImage imageNamed:@"箭头-向右"];
        _next.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _next;
}

- (void)setIndexPath:(NSIndexPath *)indexPath{
    _indexPath = indexPath;
    if (_indexPath.section == 0) {
        [_next mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.offset(0);
        }];
        
        [_input mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.next.mas_left).offset(0);
        }];
    }
    else{
        [_next mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.offset(7.5);
        }];
        
        [_input mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.next.mas_left).offset(-10);
        }];
    }
    
    if (_indexPath.section == 5) {
        _input.hidden = YES;
    }
    else{
        _input.hidden = NO;
    }
    
    if (indexPath.section == 0) {
        _input.userInteractionEnabled = YES;
    }
    else{
        _input.userInteractionEnabled = NO;
    }
    
    if (_indexPath.section == 0) {
        _titleLab.text = @[@"活动负责人",@"联系方式"][indexPath.row];
        _input.placeholder = @[@"请输入活动负责人",@"请输入联系方式"][indexPath.row];
    }
    else if (_indexPath.section == 1){
         _titleLab.text = @[@"启动时间",@"落地时间",@"预计结束时间"][indexPath.row];
        _input.placeholder = @"";
        _input.text = [NSString stringWithFormat:@"%@",[NSDate date]];
    }
    else if (_indexPath.section == 2){
        _input.placeholder = @"";
         _titleLab.text = @[@"地址"][indexPath.row];
    }
    else if (_indexPath.section == 5){
        _input.placeholder = @"";
         _titleLab.text = @[@"是否指定意向团队"][indexPath.row];
    }
}

- (void)setDoenIndexPath:(NSIndexPath *)doenIndexPath{
    _doenIndexPath = doenIndexPath;
    if (_doenIndexPath) {
        [_next mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.offset(0);
        }];
        
        [_input mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.next.mas_left).offset(0);
        }];
        _input.userInteractionEnabled = NO;
        _input.placeholder = @"";
        if (_doenIndexPath.section == 0) {
            _titleLab.text = @[@"活动负责人",@"联系方式",@"启动时间",@"落地时间",@"",@"地址"][doenIndexPath.row];
            _input.text = @[@"",@"",@"",@"",@"",@""][doenIndexPath.row];
        }
        else if (_doenIndexPath.section == 1){
            _titleLab.text = @[@"指定团队"][doenIndexPath.row];
            _input.text = @[@""][doenIndexPath.row];
        }
        else if (_doenIndexPath.section == 3){
            _titleLab.text = @[@"方案",@"套餐",@"砝码1"][doenIndexPath.row];
            _input.text = @[@"",@"",@""][doenIndexPath.row];
        }
        else if (_doenIndexPath.section == 4){
            _titleLab.text = @[@"活动金额"][doenIndexPath.row];
            _input.text = @[@""][doenIndexPath.row];
        }
        
    }
    
}

- (void)setModel:(SubmitModel *)model{
    _model = model;
    if (_model) {
        _input.text = @"";
        if (self.indexPath) {
            if (_indexPath.section == 0) {
                _input.text = @[IsNullString(_model.headPeo) ? @"" : _model.headPeo,IsNullString(_model.phone) ? @"" : _model.phone][self.indexPath.row];
            }
            else if (_indexPath.section == 1){
                _input.text = @[IsNullString(_model.startTime) ? @"" : _model.startTime,IsNullString(_model.loadingTime) ? @"" : _model.loadingTime,IsNullString(_model.endTime) ? @"" : _model.endTime][self.indexPath.row];
            }
            else if (_indexPath.section == 2){
                _input.text = @[IsNullString(_model.location) ? @"" : _model.location][self.indexPath.row];
            }
            self.name.hidden = YES;
            self.value1.hidden = YES;
            self.value2.hidden = YES;
            self.titleLab.hidden = NO;
        }
        else if (self.doenIndexPath){
            if (_doenIndexPath.section == 0) {
                self.name.hidden = YES;
                self.value1.hidden = YES;
                self.value2.hidden = YES;
                self.titleLab.hidden = NO;
//                _input.text = @[IsNullString(_model.headPeo) ? @"" : _model.headPeo,
//                                IsNullString(_model.phone) ? @"" : _model.phone,
//                                IsNullString(_model.startTime) ? @"" : _model.startTime,
//                                IsNullString(_model.loadingTime) ? @"" : _model.loadingTime,
//                                IsNullString(_model.endTime) ? @"" : _model.endTime,
//                                @"",
//                                IsNullString(_model.location) ? @"" : _model.location][self.doenIndexPath.row];
                _input.text = @[IsNullString(_model.headPeo) ? @"" : _model.headPeo,
                                IsNullString(_model.phone) ? @"" : _model.phone,
                                IsNullString(_model.startTime) ? @"" : _model.startTime,
                                IsNullString(_model.loadingTime) ? @"" : _model.loadingTime,
                                @"",
                                IsNullString(_model.location) ? @"" : _model.location][self.doenIndexPath.row];
            }
            else if (_doenIndexPath.section == 1){
                self.name.hidden = YES;
                self.value1.hidden = YES;
                self.value2.hidden = YES;
                self.titleLab.hidden = NO;
                _input.text = _model.team ? _model.team.teameName : @"";
            }
            else if (_doenIndexPath.section == 3){
                self.name.hidden = YES;
                self.value1.hidden = YES;
                self.value2.hidden = YES;
                self.titleLab.hidden = NO;
                if (_model.plan && _doenIndexPath.row == 0) {
                    if (_model.activityType == 5) {
                        _input.text = @"";
                    }
                    else if (_model.activityType == 2){
                        _input.text = [NSString stringWithFormat:@"任务:%@单",_model.plan.task];
                    }
                    else if (_model.activityType == 3){
                        _input.text = [NSString stringWithFormat:@"任务:%ld个品牌%ld单",_model.pin_num,(_model.pin_num - 10) * [YYCacheManager shareYYCacheManager].taskNumer + [_model.plan.task integerValue]];
                    }
                    else if (_model.activityType == 4){
                        _input.text = [NSString stringWithFormat:@"商家:%ld个任务%ld单",_model.plan.supervision_number + [YYCacheManager shareYYCacheManager].arciveNumer,[_model.plan.task integerValue] + _model.plan.supervision_number * [YYCacheManager shareYYCacheManager].taskNumer];
                    }
                    else{
                        _input.text =  _model.plan.mission;
                    }
                }
                else if (_model.plan && _doenIndexPath.row == 1) {
                    self.name.hidden = NO;
                    self.value1.hidden = NO;
                    self.value2.hidden = NO;
                    self.titleLab.hidden = YES;
                    _name.text = _model.plan.planName;
                    
                    if (_model.activityType == 5) {
                        _value1.text = @"";
                        _value2.text = [NSString stringWithFormat:@"%ld天",_model.plan.supervision_number];
                    }
                    else if (_model.activityType == 4){
                        _value1.text = @"";
                        _value2.text = [NSString stringWithFormat:@"%ld个商家",_model.plan.supervision_number + [YYCacheManager shareYYCacheManager].arciveNumer];
                    }
                    else{
                        _value1.text = @"主控1名";
                        _value2.text = [NSString stringWithFormat:@"督导%ld名",_model.plan.supervision_number];
                    }
                }
                else if (_doenIndexPath.row == 2) {
                    _titleLab.text = !_model.safe ? @"砝码" : _model.safe.name;
                    _input.text =  !_model.safe ? @"未选购砝码" : [NSString stringWithFormat:@"购买%.0f-->可退%.0f",_model.safe.buy_money,_model.safe.back_money];
                }
            }
            else if (_doenIndexPath.section == 4){
                CGFloat allmoney = _model.allMoneny - ((_model.safe ? _model.safe.buy_money : 0) - (_model.vocherModel ? _model.vocherModel.worth_money/100 : 0));
                _input.text = [NSString stringWithFormat:@"金额：%.2f元",_model.allMoneny + allmoney * [YYCacheManager shareYYCacheManager].saleFloat];
            }
        }
    }
}

@end
