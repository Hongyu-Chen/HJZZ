//
//  OrderShowTableViewCell.m
//  HJZSU
//
//  Created by apple on 2019/3/13.
//  Copyright © 2019 apple. All rights reserved.
//

#import "OrderShowTableViewCell.h"

@interface OrderShowTableViewCell ()

@property (strong,nonatomic) UILabel *titleLab;
@property (strong,nonatomic) UILabel *valueLab;
@property (strong,nonatomic) UIImageView *next;

@end

@implementation OrderShowTableViewCell

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
        self.valueLab = [LabelCreat creatLabelWith:@"值" font:[UIFont systemFontOfSize:14] color:UIColorMake(137, 137, 137) textAlignment:NSTextAlignmentRight];
        [self addSubview:self.titleLab];
        [self addSubview:self.valueLab];
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
        
        [_valueLab mas_makeConstraints:^(MASConstraintMaker *make) {
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
        
    }
    return self;
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
    
    if (indexPath.section == 7) {
        [_next mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.offset(7.5);
        }];
        
        [_valueLab mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.next.mas_left).offset(-10);
        }];
    }
    else{
        [_next mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.offset(0);
        }];
        
        [_valueLab mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.next.mas_left).offset(0);
        }];
    }
//    self.titleLab.text = @[@[@"订单编号",@"订单状态",@"下单时间"],@[@"活动负责人",@"联系方式",@"启动时间",@"落地时间",@"预计结束时间",@"特殊要求",@"地址"],@[@"图片"],@[@"方案",@""],@[@"安全砝码"],@[@"活动金额"],@[@"指定团队",@""],@[@"是否完成任务"]][indexPath.section][indexPath.row];
    self.titleLab.text = @[@[@"订单编号",@"订单状态",@"下单时间"],@[@"活动负责人",@"联系方式",@"启动时间",@"落地时间",@"取消原因",@"地址"],@[@"图片"],@[@"方案",@""],@[@"安全砝码"],@[@"活动金额"],@[@"指定团队",@""],@[@"是否完成任务"]][indexPath.section][indexPath.row];
    self.valueLab.text = @[@[@"订单编号",@"订单状态",@"下单时间"],@[@"活动负责人",@"联系方式",@"启动时间",@"落地时间",@"取消原因",@"地址"],@[@"图片"],@[@"方案",@""],@[@"安全砝码"],@[@"活动金额"],@[@"指定团队",@""],@[@"是否完成任务"]][indexPath.section][indexPath.row];
}

- (void)setModel:(OrderModelInfo *)model{
    _model = model;
    if (_model) {
        NSString *statusStr = @"";
        if (model.status == 1) {
            if (IsNullString(_model.teamId)) {
                statusStr = @"待接单";
            }
            else{
                statusStr = @"待确认";
            }
        }
        else if (model.status == 2){
            statusStr = @"待支付";
        }
        else if (model.status == 3){
            statusStr = @"进行中";
        }
        else if (model.status == 4){
            statusStr = @"已完成";
        }else if (model.status == 5){
            statusStr = @"已取消";
        }
        else if (model.status == 6){
            statusStr = @"申诉改派";
        }
        
        NSString *str = @"";
        if ([_model.activityType integerValue] == 5) {
            
        }
        else if ([_model.activityType integerValue] == 2){
            str = [NSString stringWithFormat:@"任务:%@单",_model.task];
        }
        else if ([_model.activityType integerValue] == 3){
            str = [NSString stringWithFormat:@"任务:%ld单",[_model.task integerValue]];
        }
        else if ([_model.activityType integerValue] == 4){
            str = [NSString stringWithFormat:@"任务:%@商家",_model.task];
        }
        else{
            str =  [NSString stringWithFormat:@"任务：金额达到%.2f",_model.task_money/100];
        }
        
        CGFloat pay = (_model.money - _model.weightsBuyMoney + _model.couponMoney - (_vocherModel ? _vocherModel.worth_money : 0)) * (1 + [YYCacheManager shareYYCacheManager].saleFloat);
        pay += (_model.weightsBuyMoney -_model.couponMoney);
        pay = pay/100;
        
        self.valueLab.text = @[@[IsNullString(_model.order_no) ? @"" : _model.order_no,
                                 statusStr,
                                 IsNullString(_model.create_time) ? @"" : [ProjectTool dateTimerConversionWithTimeStamp:_model.create_time]],
                               @[IsNullString(_model.contact_name) ? @"" : _model.contact_name,
                                 IsNullString(_model.contact_phone) ? @"" : _model.contact_phone,
                                 IsNullString(_model.create_time) ? @"" : [ProjectTool dateTimerConversionWithTimeStamp:_model.create_time],
                                 IsNullString(_model.start_time) ? @"" : [ProjectTool dateTimerConversionWithTimeStamp:_model.start_time],
//                                 IsNullString(_model.end_time) ? @"" : [ProjectTool dateTimerConversionWithTimeStamp:_model.end_time],
                                 IsNullString(_model.comment) ? @"" : _model.comment,
                                 IsNullString(_model.address) ? @"" : _model.address,],
                               @[@"图片"],
                               @[str,
                                 @""],
                               @[[NSString stringWithFormat:@"购买%.0f元-->可退%.0f元",_model.weightsBuyMoney/100,_model.weightsBackMoney/100]],
                               @[[NSString stringWithFormat:@"%.2f",pay]],
                               @[@"",@""],
                               @[_model.is_success ? @"已完成" : (self.model.status == 3) ? @"请选择" : @"未完成"]][_indexPath.section][_indexPath.row];
    }
}

- (void)setIsDone:(NSInteger)isDone{
    _isDone = isDone;
    if (_indexPath.section == 7 && _indexPath.row == 0 && self.model.status == 3 && !self.model.is_success) {
        self.valueLab.text = _isDone  == 0 ? @"请选择" : _isDone == 2 ? @"已完成" : @"未完成";
    }
}



@end
