//
//  UserInfoViewController.m
//  HJZSS
//
//  Created by apple on 2019/2/28.
//  Copyright © 2019 apple. All rights reserved.
//

#import "UserInfoViewController.h"
#import "CertificationViewController.h"
#import "CPViewController.h"

@interface UserInfoViewController ()<UITableViewDelegate,UITableViewDataSource,TZImagePickerControllerDelegate,UITextFieldDelegate>

@property (strong,nonatomic) UITableView *tableView;
@property (strong,nonatomic) UIImageView *headerImage;
@property (strong,nonatomic) UITextField *nameText;

@end

@implementation UserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.tableView];
    self.titleLab.text = @"个人资料";
    [self.tableView reloadData];
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self reloadSelfViewData];
}

- (void)reloadSelfViewData{
    __weak typeof(self) weakself = self;
    [self getUserInfoSuccess:^(id  _Nonnull result) {
        [weakself setModel:result];
        [weakself.headerImage sd_setImageWithURL:[NSURL URLWithString:weakself.model.head] placeholderImage:PLACEHOLDERIMAGE];
        weakself.nameText.text = self.model.name;
        [[YYCacheManager shareYYCacheManager] uploadUserInfoWith:@{@"auth":[NSNumber numberWithInteger:weakself.model.auth]}];
        [weakself.tableView reloadData];
    } failed:^(NSString * _Nonnull reson) {
        [QMUITips showError:reson];
    }];
}

- (UITableView *)tableView{
    if (!_tableView ) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NavigationContentTopConstant, SCREEN_WIDTH, SCREEN_HEIGHT - NavigationContentTopConstant)];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = self.view.backgroundColor;
    }
    return _tableView;
}

- (UITextField *)nameText{
    if (!_nameText) {
        _nameText = [[UITextField alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 200, 0, 169.5, 50)];
        _nameText.textAlignment = NSTextAlignmentRight;
        _nameText.font = [UIFont systemFontOfSize:15];
        _nameText.textColor = UIColorMake(137, 137, 137);
        _nameText.delegate = self;
//        _nameText.backgroundColor = [UIColor redColor];
    }
    return _nameText;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 13;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = self.view.backgroundColor;
    return view;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 3;
    }
    else{
        return 1;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && indexPath.row == 0) {
        return 75;
    }
    else{
        return 50;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellInfo"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cellInfo"];
        cell.textLabel.textColor = UIColorMake(51, 51, 51);
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.detailTextLabel.textColor = UIColorMake(51, 51, 51);
        cell.detailTextLabel.font = [UIFont systemFontOfSize:15];
        
        if (indexPath.section == 0 && indexPath.row == 0) {
            [cell addSubview:self.headerImage];
            [_headerImage mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(cell).offset(7.5);
                make.left.equalTo(cell).offset(13);
                make.width.height.offset(60);
            }];
        }
        if (indexPath.section == 0 && indexPath.row == 1) {
            [cell addSubview:self.nameText];
        }
        
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
        [cell addSubview:next];
        [next mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(cell).offset(0);
            make.right.equalTo(cell).offset(-13);
            make.width.offset(7.5);
        }];
        
        UILabel *value = [LabelCreat creatLabelWith:@"" font:[UIFont systemFontOfSize:15] color:UIColorMake(137, 137, 137) textAlignment:NSTextAlignmentRight];
        value.tag = 100;
        [cell addSubview:value];
        [value mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(next.mas_left).offset(-10);
            make.bottom.top.equalTo(cell).offset(0);
            make.left.equalTo(cell).offset(100);
        }];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    UILabel *tmp = [cell viewWithTag:100];
    cell.textLabel.text = @[@[@"",@"昵称",@"手机号"],@[@"认证"]][indexPath.section][indexPath.row];
    tmp.text = @[@[@"更换头像",
                   @"",
                   self.model ? self.model.phone ? self.model.phone : @"" : @""],
                 @[@[@"未认证",@"认证中",@"认证通过",@"认证未通过"][self.model ? self.model.auth : 0]]][indexPath.section][indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [_nameText resignFirstResponder];
    if (indexPath.section == 0 && indexPath.row == 0) {
        //MaxImagesCount  可以选着的最大条目数
        TZImagePickerController *imagePicker = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
        // 是否显示可选原图按钮
        imagePicker.allowPickingOriginalPhoto = NO;
        // 是否允许显示视频
        imagePicker.allowPickingVideo = NO;
        // 是否允许显示图片
        imagePicker.allowPickingImage = YES;
        imagePicker.showSelectBtn = NO;
        imagePicker.allowCrop = YES;
        imagePicker.needCircleCrop = YES;
        imagePicker.circleCropRadius = SCREEN_WIDTH/2;
        [self presentViewController:imagePicker animated:YES completion:nil];
        
    }
    else if (indexPath.section == 1){
        if (self.model.auth == 0 || self.model.auth == 3) {
            [self.navigationController pushViewController:[[CertificationViewController alloc] init] animated:YES];
        }
    }
    else if (indexPath.section == 3){
//        [self.navigationController pushViewController:[[TeamViewController alloc] init] animated:YES];
    }
    else if (indexPath.section == 0 && indexPath.row == 2){
        [self.navigationController pushViewController:[[CPViewController alloc] init] animated:YES];
    }
}

// 选择照片的回调
-(void)imagePickerController:(TZImagePickerController *)picker
      didFinishPickingPhotos:(NSArray<UIImage *> *)photos
                sourceAssets:(NSArray *)assets
       isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto{
    [QMUITips showLoadingInView:self.view];
    __weak typeof(self) weakself = self;
    [self upImageWith:@"user" data:photos success:^(id  _Nonnull result) {
        weakself.model.head = [[result[@"fileUrl"] componentsSeparatedByString:@";"] firstObject];
        [weakself uploadUserInfo:@{@"head":[[result[@"fileUrl"] componentsSeparatedByString:@";"] firstObject]} success:^(id  _Nonnull result) {
            [QMUITips hideAllTips];
            [weakself.headerImage sd_setImageWithURL:[NSURL URLWithString:weakself.model.head] placeholderImage:PLACEHOLDERIMAGE];
            [QMUITips showSucceed:@"更新成功"];
        } failed:^(NSString * _Nonnull reson) {
            [QMUITips hideAllTips];
            [QMUITips showError:reson];
        }];
        
    } failed:^(NSString * _Nonnull reson) {
        [QMUITips hideAllTips];
        [QMUITips showError:reson];
    }];
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (!IsNullString(textField.text)) {
        __weak typeof(self) weakself = self;
        [self uploadUserInfo:@{@"name":textField.text} success:^(id  _Nonnull result) {
            [QMUITips hideAllTips];
            [QMUITips showSucceed:@"更新成功"];
            weakself.nameText.text = textField.text;
            weakself.model.name = textField.text;
        } failed:^(NSString * _Nonnull reson) {
            [QMUITips hideAllTips];
            [QMUITips showError:reson];
        }];
    }
}

- (UIImageView *)headerImage{
    if (!_headerImage) {
        _headerImage = [[UIImageView alloc] init];
        _headerImage.layer.cornerRadius = 30.0;
        _headerImage.clipsToBounds = YES;
        _headerImage.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _headerImage;
}

@end
