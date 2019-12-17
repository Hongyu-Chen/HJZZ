//
//  BPlanTableViewCell.m
//  HJZSU
//
//  Created by apple on 2019/3/14.
//  Copyright © 2019 apple. All rights reserved.
//

#import "BPlanTableViewCell.h"
#import "CanelOrderView.h"

@interface BPlanTableViewCell ()

@property (strong,nonatomic) UILabel *planNumber;
@property (strong,nonatomic) UIImageView *header;
@property (strong,nonatomic) UILabel *name;
@property (strong,nonatomic) UILabel *orderNumber;
@property (strong,nonatomic) UILabel *time;
@property (strong,nonatomic) UILabel *value;
@property (strong,nonatomic) UIButton *state;

@end

@implementation BPlanTableViewCell

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
    if(self){
        
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.planNumber = [LabelCreat creatLabelWith:@"砝码订单号：" font:[UIFont boldSystemFontOfSize:15] color:UIColorMake(34, 34, 34) textAlignment:NSTextAlignmentLeft];
        self.name = [LabelCreat creatLabelWith:@" " font:[UIFont systemFontOfSize:15] color:UIColorMake(34, 34, 34) textAlignment:NSTextAlignmentLeft];
        self.orderNumber = [LabelCreat creatLabelWith:@"订单编号： " font:[UIFont systemFontOfSize:15] color:UIColorMake(137, 137, 137) textAlignment:NSTextAlignmentLeft];
        self.time = [LabelCreat creatLabelWith:@"下单时间：" font:[UIFont systemFontOfSize:15] color:UIColorMake(137, 137, 137) textAlignment:NSTextAlignmentLeft];
        self.value = [LabelCreat creatLabelWith:@"购买0元->可退0元" font:[UIFont systemFontOfSize:15] color:UIColorMake(137, 137, 137) textAlignment:NSTextAlignmentLeft];
        [self addSubview:self.planNumber];
        [self addSubview:self.header];
        [self addSubview:self.name];
        [self addSubview:self.orderNumber];
        [self addSubview:self.time];
        [self addSubview:self.value];
        [self addSubview:self.state];
        
        [_planNumber mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(0);
            make.left.equalTo(self).offset(13);
            make.right.equalTo(self).offset(-13);
            make.height.offset(50);
        }];
        
        [_header mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.planNumber.mas_bottom).offset(15);
            make.left.equalTo(self).offset(13);
            make.width.offset(120);
            make.height.offset(100);
        }];
        
        [_name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.planNumber.mas_bottom).offset(15);
            make.left.equalTo(self.header.mas_right).offset(13);
            make.right.equalTo(self).offset(-13);
        }];
        
        [_orderNumber mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.name.mas_bottom).offset(15);
            make.left.equalTo(self.header.mas_right).offset(13);
            make.right.equalTo(self).offset(-13);
        }];
        
        [_time mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.orderNumber.mas_bottom).offset(15);
            make.left.equalTo(self.header.mas_right).offset(13);
            make.right.equalTo(self).offset(-13);
        }];
        
        [_value mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.header.mas_bottom).offset(13);
            make.left.equalTo(self).offset(13);
            make.bottom.equalTo(self).offset(-13);
            make.height.offset(50);
        }];
        
        [_state mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.header.mas_bottom).offset(23);
            make.right.equalTo(self).offset(-13);
            make.bottom.equalTo(self).offset(-23);
            make.height.offset(30);
            make.width.offset(100);
        }];
        
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = UIColorMake(239, 239, 239);
        [self addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.planNumber.mas_bottom).offset(0);
            make.left.right.equalTo(self).offset(0);
            make.height.offset(1);
        }];
        
        UIView *line1 = [[UIView alloc] init];
        line1.backgroundColor = UIColorMake(239, 239, 239);
        [self addSubview:line1];
        [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.header.mas_bottom).offset(13);
            make.left.right.equalTo(self).offset(0);
            make.height.offset(1);
        }];
        
        UIView *line2 = [[UIView alloc] init];
        line2.backgroundColor = UIColorMake(239, 239, 239);
        [self addSubview:line2];
        [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.equalTo(self).offset(0);
            make.height.offset(13);
        }];
        
    }
    return self;
}

- (UIImageView *)header{
    if (!_header) {
        _header = [[UIImageView alloc] init];
        _header.contentMode = UIViewContentModeScaleAspectFill;
        _header.layer.cornerRadius = 5;
        _header.clipsToBounds = YES;
        _header.backgroundColor = [UIColor whiteColor];
        _header.image = PLACEHOLDERIMAGE;
    }
    return _header;
}

- (UIButton *)state{
    if (!_state) {
        _state = [[UIButton alloc] init];
        [_state setTitle:@"申请返回" forState:UIControlStateNormal];
        [_state setTitleColor:UIColorMake(51, 51, 51) forState:UIControlStateNormal];
        _state.layer.cornerRadius = 5;
        _state.layer.borderWidth = 1.0;
        _state.layer.borderColor = UIColorMake(51, 51, 51).CGColor;
        _state.titleLabel.font = [UIFont systemFontOfSize:15];
        [_state addTarget:self action:@selector(reportBackSafe) forControlEvents:UIControlEventTouchUpInside];
    }
    return _state;
}

- (void)setModel:(BuySafe *)model{
    _model = model;
    if (_model) {
        self.planNumber.text = [NSString stringWithFormat:@"砝码订单号：%@",_model.order_no];
        self.name.text = _model.name;
        self.orderNumber.text = [NSString stringWithFormat:@"订单编号： %@",_model.order_no];
        self.time.text = [NSString hoursTimeWith:_model.create_time];
        self.value.text = [NSString stringWithFormat:@"购买%.0f元->可退%.0f元",_model.buy_money/100,_model.back_money/100];
        NSString *titleName = @[@"无效",@"申请返还",@"订单结束",@"申请已提交",@"返回成功",@"拒绝返还"][_model.status];
        [self.state setTitle:titleName forState:UIControlStateNormal];
        [_header sd_setImageWithURL:[NSURL URLWithString:[_model.images componentsSeparatedByString:@";"].firstObject] placeholderImage:PLACEHOLDERIMAGE];
    }
}

- (void)reportBackSafe{
    if (self.model.status == 1) {
        __weak typeof(self) weakself = self;
        CanelOrderView *order = [CanelOrderView showView:@"CanelOrderView" loadDataType:@"0" userBlock:^(NSInteger index, id value) {
            if (index == 1) {
                [weakself applySafeWith:weakself.model.order_no comment:IsNullString(value[@"other"]) ? @"" : value[@"other"] other:IsNullString(value[@"content"]) ? @"" : value[@"content"] success:^(id  _Nonnull result) {
                    [QMUITips showSucceed:@"申请已提交"];
                } failed:^(NSString * _Nonnull reson) {
                    [QMUITips showError:reson];
                }];
            }
        }];
        [order updateWithCanel:self.model];
        [order reloadResonList];
    }
    else{
        [QMUITips showError:@"当前状态无法申请返还"];
    }
}


@end
