//
//  DetailTableViewCell.m
//  HJZSS
//
//  Created by apple on 2019/3/4.
//  Copyright © 2019 apple. All rights reserved.
//

#import "DetailTableViewCell.h"

@interface DetailTableViewCell ()

@property (strong,nonatomic) UILabel *type;
@property (strong,nonatomic) UILabel *time;
@property (strong,nonatomic) UILabel *number;

@end

@implementation DetailTableViewCell

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
        
        self.type = [LabelCreat creatLabelWith:@"提现" font:[UIFont systemFontOfSize:12] color:UIColorMake(137, 137, 137) textAlignment:NSTextAlignmentCenter];
        self.time = [LabelCreat creatLabelWith:@"2018-09-09 08:22" font:[UIFont systemFontOfSize:12] color:UIColorMake(137, 137, 137) textAlignment:NSTextAlignmentCenter];
        self.number = [LabelCreat creatLabelWith:@"+299.00" font:[UIFont systemFontOfSize:12] color:UIColorMake(137, 137, 137) textAlignment:NSTextAlignmentCenter];
        
        [self addSubview:self.type];
        [self addSubview:self.time];
        [self addSubview:self.number];
        
        [_type mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self).offset(0);
            make.left.equalTo(self).offset(0);
        }];
        
        [_time mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self).offset(0);
            make.left.equalTo(self.type.mas_right).offset(0);
            make.width.equalTo(self.type);
        }];
        
        [_number mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.right.equalTo(self).offset(0);
            make.left.equalTo(self.time.mas_right).offset(0);
            make.width.equalTo(self.time);
        }];
        
        UIView *lien = [[UIView alloc] init];
        lien.backgroundColor = UIColorMake(239, 239, 239);
        [self addSubview:lien];
        [lien mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(0);
            make.right.equalTo(self).offset(0);
            make.bottom.equalTo(self).offset(0);
            make.height.offset(1);
        }];
        
    }
    return self;
}

- (void)setCellInfo:(MoneyDetail *)cellInfo{
    _cellInfo = cellInfo;
    if (_cellInfo) {
//        NSLog(@"%@",_cellInfo);
        /*create_time": 1551146934000, //时间
         "money": 100,//金额 单位分
         "type": 1// 0-充值  1-提现 2-提成  3-发布活动 4-购买砝码  5-退款 */
        
        self.type.text = @[@"充值",@"提现",@"提成",@"发布活动",@"购买砝码",@"退款"][_cellInfo.type];
        self.time.text = [NSString hoursTimeWith:_cellInfo.create_time];
        self.number.text = [NSString stringWithFormat:@"%@%.2f",_cellInfo.type == 0 || _cellInfo.type == 2 ? @"+" : @"-",_cellInfo.money/100];
    }
}


@end
