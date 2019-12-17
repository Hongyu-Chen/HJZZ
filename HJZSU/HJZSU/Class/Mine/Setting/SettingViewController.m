//
//  SettingViewController.m
//  HJZSS
//
//  Created by apple on 2019/3/1.
//  Copyright © 2019 apple. All rights reserved.
//

#import "SettingViewController.h"
#import "FeadBackViewController.h"
#import "HelpViewController.h"
#import "LoginViewController.h"

@interface SettingViewController ()<UITableViewDelegate,UITableViewDataSource,TZImagePickerControllerDelegate>

@property (strong,nonatomic) UITableView *tableView;
@property (strong,nonatomic) UIButton *exitLogin;
@property (strong,nonatomic) UISwitch *switchView;

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleLab.text = @"设置";
    [self.view addSubview:self.tableView];
}

- (UISwitch *)switchView{
    if (!_switchView) {
        _switchView = [[UISwitch alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 80,10, 60, 30)];
        [_switchView addTarget:self action:@selector(changedPressed:) forControlEvents:UIControlEventValueChanged];
        [_switchView setOn:[[YYCacheManager shareYYCacheManager] getVoiceStyle] animated:YES];
    }
    return _switchView;
}

- (UITableView *)tableView{
    if (!_tableView ) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NavigationContentTopConstant, SCREEN_WIDTH, SCREEN_HEIGHT - NavigationContentTopConstant)];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = self.view.backgroundColor;
        [_tableView addSubview:self.exitLogin];
    }
    return _tableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 7;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 170;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 170)];
    view.backgroundColor = self.view.backgroundColor;
    [view addSubview:self.exitLogin];
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"settingCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"settingCell"];
        cell.textLabel.textColor = UIColorMake(51, 51, 51);
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.detailTextLabel.textColor = UIColorMake(51, 51, 51);
        cell.detailTextLabel.font = [UIFont systemFontOfSize:15];
        
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = self.view.backgroundColor;
        [cell addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(cell).offset(0);
            make.height.offset(1);
        }];
        
        UIImageView *next = [[UIImageView alloc] init];
        next.contentMode = UIViewContentModeScaleAspectFit;
        next.image = [UIImage imageNamed:@"箭头-向右"];
        next.tag = 101;
        [cell addSubview:next];
        [next mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(cell).offset(0);
            make.right.equalTo(cell).offset(-13);
            make.width.offset(7.5);
        }];
        
        UILabel *value = [LabelCreat creatLabelWith:@"" font:[UIFont systemFontOfSize:15] color:UIColorMake(51, 51, 51) textAlignment:NSTextAlignmentRight];
        value.tag = 100;
        [cell addSubview:value];
        [value mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(cell).offset(-13);
            make.bottom.top.equalTo(cell).offset(0);
            make.left.equalTo(cell).offset(100);
        }];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.row == 0) {
            [cell addSubview:self.switchView];
        }
    }
    
    
    UIImageView *tmpNex = [cell viewWithTag:101];
    if (indexPath.row == 1 || indexPath.row == 2 || indexPath.row == 3) {
        tmpNex.hidden = NO;
    }
    else{
        tmpNex.hidden = YES;
    }
    cell.textLabel.text = @[@"语音提示",@"常见问题",@"关于我们",@"问题反馈",@"联系客服服务",@"检查更新",@"清除缓存"][indexPath.row];
    UILabel *tmpLab = [cell viewWithTag:100];
    float tmpSize = [[SDImageCache sharedImageCache] getDiskCount];
    NSString *clearCacheName = tmpSize >= 1 ? [NSString stringWithFormat:@"%.2fM",tmpSize] : [NSString stringWithFormat:@"%.2fK",tmpSize * 1024];
    tmpLab.text = @[@"",@"",@"",@"",!IsNullString([[YYCacheManager shareYYCacheManager] getSaveInfo:SYSTEMCONFIG][@"contact"]) ? [[YYCacheManager shareYYCacheManager] getSaveInfo:SYSTEMCONFIG][@"contact"] : @"",@"V 1.0.1",clearCacheName][indexPath.row];
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 3) {
        [self.navigationController pushViewController:[[FeadBackViewController alloc] init] animated:YES];
    }
    else if (indexPath.row == 1){
        HelpViewController *help = [[HelpViewController alloc] init];
        help.type = HelpStatusQuestion;
        [self.navigationController pushViewController:help animated:YES];
    }
    else if (indexPath.row == 2){
        HelpViewController *help = [[HelpViewController alloc] init];
        help.type = HelpStatusAboutMe;
        [self.navigationController pushViewController:help animated:YES];
    }
    else if (indexPath.row == 6){
        float tmpSize = [[SDImageCache sharedImageCache] getDiskCount];
        NSString *clearCacheName = tmpSize >= 1 ? [NSString stringWithFormat:@"清理缓存(%.2fM)",tmpSize] : [NSString stringWithFormat:@"清理缓存(%.2fK)",tmpSize * 1024];
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"提示"message:clearCacheName preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
        {
            [[SDImageCache sharedImageCache] clearDisk];
            [self.tableView reloadData];
        }];
        [alert addAction:cancelAction];
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:^{
        }];
    }
}

- (UIButton *)exitLogin{
    if (!_exitLogin) {
        _exitLogin = [[UIButton alloc] initWithFrame:CGRectMake(13, 120,SCREEN_WIDTH - 26 , 50)];
        [_exitLogin setTitle:@"推出登录" forState:UIControlStateNormal];
        _exitLogin.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        [_exitLogin setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _exitLogin.backgroundColor = UIColorMake(255, 80, 0);
        _exitLogin.layer.cornerRadius = 5;
        [_exitLogin addTarget:self action:@selector(exitLoginButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    }
    return _exitLogin;
}

- (void)exitLoginButtonPressed{
    [[YYCacheManager shareYYCacheManager] removeCacheWithKey:LOGIN];
    [BANetManager sharedBANetManager].httpHeaderFieldDictionary = nil;
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate changedRootController];
    [[EMClient sharedClient] logout:YES completion:^(EMError *aError) {
        ;
    }];
}

- (void)changedPressed:(UISwitch *)sender{
    NSMutableDictionary *info = [[NSMutableDictionary alloc] init];
    [info setObject:sender.on ? @"1" : @"0" forKey:@"voice"];
    [[YYCacheManager shareYYCacheManager] saveDic:info forKey:VOICETYPE];
}

@end
