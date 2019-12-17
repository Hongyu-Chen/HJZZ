//
//  CommentStartVC.m
//  HJZSU
//
//  Created by apple on 2019/3/14.
//  Copyright © 2019 apple. All rights reserved.
//

#import "CommentStartVC.h"
#import "SCPhotoView.h"

@interface CommentStartVC ()<SCPhotoViewDelegate,TZImagePickerControllerDelegate>

@property (strong,nonatomic) UILabel *source;
@property (strong,nonatomic) QMUITextView *textView;
@property (strong,nonatomic) UIButton *sureButton;
@property (strong,nonatomic) SCPhotoView *photo;
@property (strong,nonatomic) NSMutableArray *photos;
@property (assign,nonatomic) NSInteger sourceNumber;

@end

@implementation CommentStartVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleLab.text = @"星评";
    [self topStartView];
    [self addbottomView];
    [self.view addSubview:self.sureButton];
}

- (void)topStartView{
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(13, NavigationContentTopConstant + 13, SCREEN_WIDTH - 26, 119)];
    topView.backgroundColor = [UIColor whiteColor];
    topView.layer.cornerRadius = 5;
    [self.view addSubview:topView];
    
    UILabel *tip = [LabelCreat creatLabelWith:@"请对这次订单给团队一个星评" font:[UIFont systemFontOfSize:15] color:UIColorMake(73, 73, 73) textAlignment:NSTextAlignmentLeft];
    [topView addSubview:tip];
    [tip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(topView).offset(13);
    }];
    
    for (int i = 0; i< 5; i++) {
        UIButton *button = [[UIButton alloc] init];
        [button setImage:[UIImage imageNamed:@"星-大-未选中"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"星-大-选中"] forState:UIControlStateSelected];
        button.imageView.contentMode = UIViewContentModeScaleAspectFit;
        button.imageEdgeInsets = UIEdgeInsetsMake(11, 0, 11, 0);
        button.tag = 100 + i;
        [button addTarget:self action:@selector(startButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [topView addSubview:button];
        CGFloat width = 36;
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(tip.mas_bottom).offset(11);
            make.left.equalTo(topView).offset((SCREEN_WIDTH - 26 - width * 5)/2 + width * i);
            make.width.height.offset(width);
        }];
        [topView addSubview:button];
    }
    self.source = [LabelCreat creatLabelWith:@"0.0" font:[UIFont systemFontOfSize:14] color:UIColorMake(220, 29, 36) textAlignment:NSTextAlignmentCenter];
    [topView addSubview:self.source];
    [_source mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tip.mas_bottom).offset(36 + 22);
        make.left.right.equalTo(topView).offset(0);
    }];
}

- (void)startButtonPressed:(UIButton *)sender{
    for (int i = 0; i <5; i++) {
        UIButton *tmp = [self.view viewWithTag:100 + i];
        if (i <= (sender.tag - 100)) {
            tmp.selected = YES;
            self.source.text = [NSString stringWithFormat:@"%d.0分",i + 1];
            self.sourceNumber = i + 1;
        }
        else{
            tmp.selected = NO;
        }
    }
}

- (void)addbottomView{
    UIView *topView = [[UIView alloc] init];
    topView.backgroundColor = [UIColor whiteColor];
    topView.layer.cornerRadius = 5;
    [self.view addSubview:topView];
    
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(NavigationContentTopConstant + 142);
        make.left.equalTo(self.view).offset(13);
        make.right.equalTo(self.view).offset(-13);
    }];
    
    [topView addSubview:self.textView];
    
    self.photo =  [[SCPhotoView alloc] initWithSCPhotoViewStyle:SCPhotoViewStyleAddInFirst];
    self.photo.contentWidth = SCREEN_WIDTH - 52;
    self.photo.delegate = self;
    self.photo.showDelete = YES;
    self.photo.showPreviewPicture = NO;
    self.photo.photos = [NSMutableArray array];
    [topView addSubview:self.photo];
    [self.photo mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textView.mas_bottom).offset(0);
        make.left.equalTo(topView).offset(13);
        make.right.equalTo(topView).offset(-13);
        make.bottom.equalTo(topView).offset(-13);
    }];
}

- (QMUITextView *)textView{
    if (!_textView) {
        _textView = [[QMUITextView alloc] initWithFrame:CGRectMake(5, 5, SCREEN_WIDTH - 36, 150)];
        _textView.placeholder = @"请输入评价";
        _textView.font = [UIFont systemFontOfSize:12];
        _textView.placeholderColor = UIColorMake(137, 137, 137);
        _textView.textColor = UIColorMake(34, 34, 34);
    }
    return _textView;
}

- (UIButton *)sureButton{
    if (!_sureButton) {
        _sureButton = [[UIButton alloc] initWithFrame:CGRectMake(13, NavigationContentTopConstant + 395 + 90, SCREEN_WIDTH - 26, 40)];
        [_sureButton setTitle:@"确定" forState:UIControlStateNormal];
        [_sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _sureButton.titleLabel.font = [UIFont systemFontOfSize:18];
        _sureButton.layer.cornerRadius = 5;
        _sureButton.backgroundColor = UIColorMake(255, 80, 0);
        [_sureButton addTarget:self action:@selector(submitComm) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureButton;
}

- (void)userPressedAddImage{
    if (self.photos.count >= 9) {
        return;
    }
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:9 delegate:self];
    imagePickerVc.sortAscendingByModificationDate = NO;
    imagePickerVc.selectedAssets = self.photos;
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}
- (void)userDeleteItem:(NSInteger)index{
    [self.photos removeObjectAtIndex:index];
    if (self.photos.count >= 9) {
        self.photo.style = SCPhotoViewStyleShow;
    }
    else{
        self.photo.style = SCPhotoViewStyleAddInFirst;
    }
    [self.photo setPhotos:self.photos];
}

#pragma mark - <TZImagePickerControllerDelegate>

- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto {
    self.photos = [assets mutableCopy];
    if (self.photos.count >= 9) {
        self.photo.style = SCPhotoViewStyleShow;
    }
    else{
        self.photo.style = SCPhotoViewStyleAddInFirst;
    }
    [self.photo setPhotos:self.photos];
}

- (void)submitComm{
    if (!self.sourceNumber) {
        [QMUITips showError:@"请选择星评"];
        return;
    }
    
    if (IsNullString(_textView.text)) {
        [QMUITips showError:@"请输入评价"];
        return;
    }
//    if (!self.photos || self.photos.count == 0) {
//        [QMUITips showError:@"请选择图片"];
//        return;
//    }
    
    if (self.photos && self.photos.count > 0) {
        __weak typeof(self) weakself = self;
        [QMUITips showLoadingInView:self.view];
        [self upImageWith:@"activity" data:self.photos success:^(id  _Nonnull result) {
            NSMutableDictionary *parmatetr = [NSMutableDictionary dictionary];
            [parmatetr setObject:[NSNumber numberWithInteger:weakself.sourceNumber] forKey:@"score"];
            [parmatetr setObject:weakself.textView.text forKey:@"content"];
            [parmatetr setObject:result[@"fileUrl"] forKey:@"images"];
            [parmatetr setObject:self.order_no forKey:@"orderNo"];
            [self submitReplyWithOrder:parmatetr success:^(id  _Nonnull result) {
                [QMUITips hideAllTips];
                [QMUITips showSucceed:@"评价成功"];
                [self.navigationController popViewControllerAnimated:YES];
            } failed:^(NSString * _Nonnull reson) {
                [QMUITips hideAllTips];
                [QMUITips showError:reson];
            }];
        } failed:^(NSString * _Nonnull reson) {
            [QMUITips hideAllTips];
            [QMUITips showError:reson];
        }];
    }
    else{
        __weak typeof(self) weakself = self;
        NSMutableDictionary *parmatetr = [NSMutableDictionary dictionary];
        [parmatetr setObject:[NSNumber numberWithInteger:weakself.sourceNumber] forKey:@"score"];
        [parmatetr setObject:weakself.textView.text forKey:@"content"];
        [parmatetr setObject:@"" forKey:@"images"];
        [parmatetr setObject:self.order_no forKey:@"orderNo"];
        [self submitReplyWithOrder:parmatetr success:^(id  _Nonnull result) {
            [QMUITips hideAllTips];
            [QMUITips showSucceed:@"评价成功"];
            [self.navigationController popViewControllerAnimated:YES];
        } failed:^(NSString * _Nonnull reson) {
            [QMUITips hideAllTips];
            [QMUITips showError:reson];
        }];
    }
    
}

@end
