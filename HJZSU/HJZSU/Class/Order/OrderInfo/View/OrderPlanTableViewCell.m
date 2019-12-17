//
//  OrderPlanTableViewCell.m
//  HJZSU
//
//  Created by apple on 2019/3/13.
//  Copyright © 2019 apple. All rights reserved.
//

#import "OrderPlanTableViewCell.h"

@interface OrderPlanTableViewCell ()

@property (strong,nonatomic) UILabel *name;
@property (strong,nonatomic) UILabel *value1;
@property (strong,nonatomic) UILabel *value2;

@end

@implementation OrderPlanTableViewCell

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
        self.name = [LabelCreat creatLabelWith:@"方案" font:[UIFont systemFontOfSize:14] color:UIColorMake(137, 137, 137) textAlignment:NSTextAlignmentCenter];
        self.value1 = [LabelCreat creatLabelWith:@"主控1名" font:[UIFont systemFontOfSize:14] color:UIColorMake(137, 137, 137) textAlignment:NSTextAlignmentCenter];
        self.value2 = [LabelCreat creatLabelWith:@"督导" font:[UIFont systemFontOfSize:14] color:UIColorMake(137, 137, 137) textAlignment:NSTextAlignmentCenter];
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

- (void)setModel:(OrderModelInfo *)model{
    _model = model;
    if (_model) {
        _name.text = _model.packageName;
        
        if ([_model.activityType integerValue] == 5) {
            _value1.text = @"";
            _value2.text = [NSString stringWithFormat:@"%ld天",(long)_model.branch_num];
        }
        else if ([_model.activityType integerValue] == 4){
            _value1.text = @"";
            _value2.text = [NSString stringWithFormat:@"%ld个商家",(long)_model.branch_num];
        }
        else{
            _value1.text = @"主控1名";
            _value2.text = [NSString stringWithFormat:@"督导%ld名",(long)_model.branch_num];
        }
    }
}

@end
