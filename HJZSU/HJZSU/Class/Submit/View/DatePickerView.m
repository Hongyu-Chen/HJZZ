//
//  DatePickerView.m
//  HJZSU
//
//  Created by apple on 2019/3/9.
//  Copyright © 2019 apple. All rights reserved.
//



#import "DatePickerView.h"

@interface DatePickerView ()

@property (strong,nonatomic) UIButton *canel;
@property (strong,nonatomic) UIButton *sure;
@property (strong,nonatomic) UIDatePicker *datePicker;

@end

@implementation DatePickerView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentFrame = CGRectMake(0, self.frame.size.height, self.frame.size.width, 255);
        self.contentView.backgroundColor = UIColorMake(239, 239, 239);
        
        [self.contentView addSubview:self.canel];
        [self.contentView addSubview:self.sure];
        [self.contentView addSubview:self.datePicker];
        
        [_canel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).offset(0);
            make.left.equalTo(self.contentView).offset(13);
            make.height.offset(44);
        }];
        
        [_sure mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).offset(0);
            make.right.equalTo(self.contentView).offset(-13);
            make.height.offset(44);
        }];
        
        [_datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.canel.mas_bottom).offset(0);
            make.left.right.bottom.equalTo(self.contentView).offset(0);
        }];
        
    }
    return self;
}

- (UIButton *)canel{
    if (!_canel) {
        _canel = [[UIButton alloc] init];
        [_canel setTitle:@"取消" forState:UIControlStateNormal];
        [_canel setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        _canel.tag = 100;
        _canel.titleLabel.font = [UIFont systemFontOfSize:14];
        [_canel addTarget:self action:@selector(typeViewButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _canel;
}

- (UIButton *)sure{
    if (!_sure) {
        _sure = [[UIButton alloc] init];
        [_sure setTitle:@"确定" forState:UIControlStateNormal];
        [_sure setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        _sure.tag = 101;
        _sure.titleLabel.font = [UIFont systemFontOfSize:14];
        [_sure addTarget:self action:@selector(typeViewButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sure;
}

- (UIDatePicker *)datePicker{
    if (!_datePicker) {
        UIDatePicker *datePicker = [[UIDatePicker alloc] init];
        
        datePicker.backgroundColor = [UIColor whiteColor];
        //设置地区: zh-中国
        datePicker.locale = [NSLocale localeWithLocaleIdentifier:@"zh"];
        
        //设置日期模式(Displays month, day, and year depending on the locale setting)
        datePicker.datePickerMode = UIDatePickerModeDate;
        // 设置当前显示时间
        [datePicker setDate:[NSDate date] animated:YES];
        // 设置显示最大时间（此处为当前时间）
        [datePicker setMinimumDate:[NSDate date]];
        
//        datePicker.dat
        //设置时间格式
        //监听DataPicker的滚动
//        [datePicker addTarget:self action:@selector(dateChange:) forControlEvents:UIControlEventValueChanged];
        
        self.datePicker = datePicker;
    }
    return _datePicker;
}
- (void)typeViewButtonPressed:(UIButton *)sender{
    if (self.viewButtonPressedBlock) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyy/MM/dd hh:mm";
        NSString *dateStr = [formatter  stringFromDate:self.datePicker.date];
        self.viewButtonPressedBlock(sender.tag - 100,dateStr);
    }
}



@end
