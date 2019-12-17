//
//  OrderListTableViewCell.m
//  HJZSU
//
//  Created by apple on 2019/3/13.
//  Copyright © 2019 apple. All rights reserved.
//

#import "OrderListTableViewCell.h"

@interface OrderListTableViewCell ()

@property (strong,nonatomic) UIImageView *headerImage;
@property (strong,nonatomic) UILabel *name;
@property (strong,nonatomic) UILabel *orderNumber;
@property (strong,nonatomic) UILabel *time;
@property (strong,nonatomic) UILabel *location;
@property (strong,nonatomic) UILabel *state;

@end

@implementation OrderListTableViewCell

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
        self.state = [LabelCreat creatLabelWith:@"状态" font:[UIFont systemFontOfSize:15] color:UIColorMake(51, 51, 51) textAlignment:NSTextAlignmentLeft];
        [self addSubview:self.headerImage];
        [self addSubview:self.name];
        [self addSubview:self.state];
        
        [_headerImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(self).offset(26);
            make.bottom.equalTo(self).offset(-13);
            make.width.offset(80);
        }];
        
        [_name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(26);
            make.left.equalTo(self.headerImage.mas_right).offset(13);
            make.right.equalTo(self).offset(-13);
        }];
        
        [_state mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(26);
            make.right.equalTo(self).offset(-13);
        }];
        
        self.time = [LabelCreat creatLabelWith:@"" font:[UIFont systemFontOfSize:12] color:UIColorMake(137, 137, 137) textAlignment:NSTextAlignmentLeft];
        self.location = [LabelCreat creatLabelWith:@"" font:[UIFont systemFontOfSize:12] color:UIColorMake(137, 137, 137) textAlignment:NSTextAlignmentLeft];
        self.orderNumber = [LabelCreat creatLabelWith:@"" font:[UIFont systemFontOfSize:12] color:UIColorMake(137, 137, 137) textAlignment:NSTextAlignmentLeft];
        
        
        [self addSubview:self.orderNumber];
        [self addSubview:self.time];
        [self addSubview:self.location];
        
        [_orderNumber mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.name.mas_bottom).offset(0);
            make.left.equalTo(self.headerImage.mas_right).offset(13);
            make.right.equalTo(self).offset(-13);
            make.height.equalTo(self.name);
        }];
        
        [_time mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.orderNumber.mas_bottom).offset(0);
            make.left.equalTo(self.headerImage.mas_right).offset(13);
            make.right.equalTo(self).offset(-13);
            make.height.equalTo(self.orderNumber);
        }];
        
        [_location mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.time.mas_bottom).offset(0);
            make.left.equalTo(self.headerImage.mas_right).offset(13);
            make.right.equalTo(self).offset(-13);
            make.height.equalTo(self.time);
            make.bottom.equalTo(self).offset(-13);
        }];
        
        
        UIView *line  = [[UIView alloc] init];
        line.backgroundColor = UIColorMake(239, 239, 239);
        [self addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(self).offset(0);
            make.height.offset(13);
        }];
        
    }
    return self;
}

- (UIImageView *)headerImage{
    if (!_headerImage) {
        _headerImage = [[UIImageView alloc] init];
        _headerImage.backgroundColor = [UIColor whiteColor];
        _headerImage.layer.cornerRadius = 5;
        _headerImage.clipsToBounds = YES;
    }
    return _headerImage;
}

- (void)setCellinfoWithModel:(OrderModel *)model{
    if (!model) {
        return;
    }
    
    [_headerImage sd_setImageWithURL:[NSURL URLWithString:[model.images componentsSeparatedByString:@";"].firstObject] placeholderImage:PLACEHOLDERIMAGE];
    _name.text = model.typeName;
    _orderNumber.text = [NSString stringWithFormat:@"订单编号：%@",model.order_no];
    _time.text = [NSString stringWithFormat:@"下单时间：%@",[ProjectTool dateTimerConversionWithTimeStampNew:model.create_time]];
    _location.text = [NSString stringWithFormat:@"地点：%@",model.address];
    if (model.status == 1) {
        if (IsNullString(model.teamId)) {
            _state.text = @"待接单";
        }
        else{
            _state.text = @"待确认";
        }
    }
    else if (model.status == 2){
        _state.text = @"待支付";
    }
    else if (model.status == 3){
        _state.text = @"进行中";
    }
    else if (model.status == 4){
        _state.text = @"已完成";
    }else if (model.status == 5){
        _state.text = @"已取消";
    }
    else if (model.status == 6){
        _state.text = @"申诉改派";
    }
}



@end
