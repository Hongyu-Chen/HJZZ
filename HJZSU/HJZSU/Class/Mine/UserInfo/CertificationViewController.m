//
//  CertificationViewController.m
//  HJZSS
//
//  Created by apple on 2019/3/1.
//  Copyright © 2019 apple. All rights reserved.
//

#import "CertificationViewController.h"
#import "CertificationTableViewCell.h"
#import "CaredTableViewCell.h"
#import "CertificationLocationCell.h"
#import "GYZChooseCityController.h"


@interface CertificationViewController ()<UITableViewDelegate,UITableViewDataSource,GYZChooseCityDelegate>

@property (strong,nonatomic) UITableView *tableView;
@property (strong,nonatomic) UIButton *sendBtn;
@property (strong,nonatomic) AuthModel *model;

@end

@implementation CertificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.model = [[AuthModel alloc] init];
    [self.view addSubview:self.tableView];
    self.titleLab.text = @"认证中心";
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NavigationContentTopConstant, SCREEN_WIDTH, SCREEN_HEIGHT - NavigationContentTopConstant)];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = self.view.backgroundColor;
        [_tableView registerClass:[CaredTableViewCell class] forCellReuseIdentifier:NSStringFromClass([CaredTableViewCell class])];
        [_tableView registerClass:[CertificationTableViewCell class] forCellReuseIdentifier:NSStringFromClass([CertificationTableViewCell class])];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
        [_tableView registerClass:[CertificationLocationCell class] forCellReuseIdentifier:NSStringFromClass([CertificationLocationCell class])];
    }
    return _tableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 2;
    }
    else{
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 786/2 + 13;
        }
        else{
            return 213;
        }
    }
    else if(indexPath.section == 1){
        return 63;
    }
    else{
        return 120;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            CaredTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CaredTableViewCell class])];
            cell.model = self.model;
            return cell;
        }
        else{
            CertificationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CertificationTableViewCell class])];
            cell.model = self.model;
            return cell;
        }
    }
    else if (indexPath.section == 1){
        CertificationLocationCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CertificationLocationCell class])];
        cell.model = self.model;
        return cell;
    }
    else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
        cell.backgroundColor = UIColorMakeWithRGBA(239, 239, 239, 1.0);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (![cell viewWithTag:100]) {
            UILabel *label = [LabelCreat creatLabelWith:@"提交审核" font:[UIFont boldSystemFontOfSize:15] color:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter];
            label.layer.cornerRadius =5;
            label.clipsToBounds = YES;
            label.backgroundColor = UIColorMake(255, 80, 0);
            label.tag = 100;
            [cell addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(cell).offset(0);
                make.left.equalTo(cell).offset(13);
                make.right.equalTo(cell).offset(-13);
                make.height.offset(50);
            }];
        }
        
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 2) {
        if (!self.model.careZ) {
            [QMUITips showError:@"请选择身份证正面"];
            return;
        }
        
        if (!self.model.careF) {
            [QMUITips showError:@"请选择身份证反面"];
            return;
        }
        
        if (!self.model.yinye) {
            [QMUITips showError:@"请选择营业执照"];
            return;
        }
        
        if (IsNullString(self.model.city)) {
            [QMUITips showError:@"请选择城市"];
            return;
        }
        __weak typeof(self) weakself = self;
        [QMUITips showLoadingInView:self.view];
        [self upImageWith:@"user" data:@[self.model.careZ,self.model.careF,self.model.yinye] success:^(id  _Nonnull result) {
            NSArray *tmp = [result[@"fileUrl"] componentsSeparatedByString:@";"];
            NSMutableDictionary *input = [NSMutableDictionary dictionary];
            [input setObject:tmp[0] forKey:@"positive"];
            [input setObject:tmp[1] forKey:@"negative"];
            [input setObject:tmp[2] forKey:@"business"];
            [input setObject:weakself.model.city forKey:@"city"];
            [weakself userAuthWIth:input success:^(id  _Nonnull result) {
                [QMUITips hideAllTips];
                [QMUITips showSucceed:@"认证提交成功"];
                [weakself.navigationController popViewControllerAnimated:YES];
            } failed:^(NSString * _Nonnull reson) {
                [QMUITips hideAllTips];
                [QMUITips showError:reson];
            }];
        } failed:^(NSString * _Nonnull reson) {
            [QMUITips hideAllTips];
            [QMUITips showError:reson];
        }];
        
    }
    else if (indexPath.section == 1){
        GYZChooseCityController *cityPickerVC = [[GYZChooseCityController alloc] init];
        [cityPickerVC setDelegate:self];
        [self presentViewController:[[UINavigationController alloc] initWithRootViewController:cityPickerVC] animated:YES completion:^{
            
        }];
    }
    
}

- (void) cityPickerController:(GYZChooseCityController *)chooseCityController
                didSelectCity:(GYZCity *)city{
    self.model.city = city.cityName;
    [self.tableView reloadData];
    [chooseCityController dismissViewControllerAnimated:YES completion:^{
        
    }];
    
}
- (void) cityPickerControllerDidCancel:(GYZChooseCityController *)chooseCityController{
    [chooseCityController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

@end
