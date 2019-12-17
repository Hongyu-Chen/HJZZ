//
//  IsDoneSelectedView.m
//  HJZSU
//
//  Created by apple on 2019/5/25.
//  Copyright © 2019 apple. All rights reserved.
//

#import "IsDoneSelectedView.h"

@interface IsDoneSelectedView ()<UIPickerViewDelegate,UIPickerViewDataSource>

@property (strong,nonatomic) UIPickerView *pickerView;
@property (strong,nonatomic) UIButton *canel;
@property (strong,nonatomic) UIButton *sure;
@property (strong,nonatomic) NSString *selectedStr;


@end

@implementation IsDoneSelectedView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.selectedStr = @"已完成";
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.type = BasePopupMenuAnimationTypeNormal;
        self.contentView.frame = CGRectMake(0, self.frame.size.height, self.frame.size.width, 240 + SafeAreaInsetsConstantForDeviceWithNotch.bottom);
        //        self.userInteractionEnabled = NO;
        
        UILabel *title = [LabelCreat creatLabelWith:@"支付" font:[UIFont boldSystemFontOfSize:23] color:UIColorMake(34, 34, 34) textAlignment:NSTextAlignmentCenter];
        title.frame = CGRectMake(0, 0, self.frame.size.width, 50);
        
        [self.contentView addSubview:self.sure];
        [self.contentView addSubview:self.canel];
        [self.contentView addSubview:self.pickerView];
        
        
    }
    return self;
}

- (UIPickerView *)pickerView{
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 40, self.frame.size.width, 200)];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
    }
    return _pickerView;
}

- (UIButton *)canel{
    if (!_canel) {
        _canel = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 60, 30)];
        [_canel setTitle:@"取消" forState:UIControlStateNormal];
        [_canel setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _canel.titleLabel.font = [UIFont systemFontOfSize:13];
        _canel.layer.cornerRadius = 5;
        _canel.layer.borderWidth = 1.0;
        _canel.layer.borderColor = [UIColor blackColor].CGColor;
        _canel.tag = 100;
        [_canel addTarget:self action:@selector(typeViewButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _canel;
}

- (UIButton *)sure{
    if (!_sure) {
        _sure = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width - 70, 10, 60, 30)];
        [_sure setTitle:@"确认" forState:UIControlStateNormal];
        [_sure setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _sure.titleLabel.font = [UIFont systemFontOfSize:13];
        _sure.layer.cornerRadius = 5;
        _sure.layer.borderWidth = 1.0;
        _sure.layer.borderColor = [UIColor blackColor].CGColor;
        _sure.tag = 101;
        [_sure addTarget:self action:@selector(typeViewButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sure;
}

- (void)typeViewButtonPressed:(UIButton *)sender{
    self.viewButtonPressedBlock(sender.tag - 100,[self.selectedStr isEqualToString:@"已完成"] ? @(2) : @(1));
    
}

- (void)resonButtonPressed:(QMUIButton *)sender{
    for (int i = 0; i < 3; i++) {
        QMUIButton *tmp = [self viewWithTag:200 + i];
        if (sender.tag == (i + 200)) {
            tmp.selected = YES;
        }
        else{
            tmp.selected = NO;
        }
    }
}

+ (void)showView:(NSString *)className info:(NSDictionary *)info userBlock:(void(^)(NSInteger index,id value))userPressedBlock{
    
    id obj = [[NSClassFromString(className) alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    IsDoneSelectedView *View = (IsDoneSelectedView *)obj;
    __weak typeof(View) weakself = View;
    View.viewButtonPressedBlock = ^(NSInteger index,id value) {
        [weakself hiddenView];
        userPressedBlock(index,value);
    };
    View.tag = 10010;
    [[UIApplication sharedApplication].keyWindow addSubview:View];
    [View showView];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView*)pickerView
{
    return 1; // 返回1表明该控件只包含1列
}

//UIPickerViewDataSource中定义的方法，该方法的返回值决定该控件指定列包含多少个列表项
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    // 由于该控件只包含一列，因此无须理会列序号参数component
    // 该方法返回teams.count，表明teams包含多少个元素，该控件就包含多少行
    return 2;
}


// UIPickerViewDelegate中定义的方法，该方法返回的NSString将作为UIPickerView
// 中指定列和列表项的标题文本
- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    // 由于该控件只包含一列，因此无须理会列序号参数component
    // 该方法根据row参数返回teams中的元素，row参数代表列表项的编号，
    // 因此该方法表示第几个列表项，就使用teams中的第几个元素
    
    return [@[@"已完成",@"未完成"] objectAtIndex:row];
}

// 当用户选中UIPickerViewDataSource中指定列和列表项时激发该方法
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:
(NSInteger)row inComponent:(NSInteger)component
{
    self.selectedStr = [@[@"已完成",@"未完成"] objectAtIndex:row];
}


@end
