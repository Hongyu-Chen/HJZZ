//
//  SubPhysicianVC.m
//  HJZSU
//
//  Created by apple on 2019/3/12.
//  Copyright © 2019 apple. All rights reserved.
//

#import "SubPhysicianVC.h"

@interface SubPhysicianVC ()<SCPhotoViewDelegate,TZImagePickerControllerDelegate,AMapLocationManagerDelegate,AMapGeoFenceManagerDelegate>

@property (strong,nonatomic) UIView *topView;
@property (strong,nonatomic) UIView *bottomView;
@property (strong,nonatomic) QMUITextView *textView;
@property (strong,nonatomic) QMUITextView *locationTextView;
@property (strong,nonatomic) UIButton *submit;
@property (strong,nonatomic) NSMutableArray *photoAsset;
@property (strong,nonatomic) SCPhotoView *photo;
@property (strong,nonatomic) AMapLocationManager *locationManager;
@property (strong,nonatomic) CLLocation *locationR;

@end

@implementation SubPhysicianVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleLab.text = @"发布问诊";
    [self.view addSubview:self.topView];
    [self.view addSubview:self.bottomView];
    [self.view addSubview:self.submit];
    
    [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(NavigationContentTopConstant);
        make.left.right.equalTo(self.view).offset(0);
    }];
    
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topView.mas_bottom).offset(13);
        make.left.right.equalTo(self.view).offset(0);
    }];
    
    [_submit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-SafeAreaInsetsConstantForDeviceWithNotch.bottom - 50);
        make.left.equalTo(self.view).offset((SCREEN_WIDTH - 320)/2);
        make.height.offset(50);
        make.width.offset(320);
    }];
    
    self.photo =  [[SCPhotoView alloc] initWithSCPhotoViewStyle:SCPhotoViewStyleAddInLast];
    self.photo.delegate = self;
    self.photo.showDelete = YES;
    self.photo.showPreviewPicture = NO;
    self.photo.photos = self.photoAsset;
    [self.topView addSubview:self.photo];
    [self.photo mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topView).offset(100);
        make.left.equalTo(self.topView).offset(13);
        make.right.bottom.equalTo(self.topView).offset(-13);
    }];
    
    self.locationManager = [[AMapLocationManager alloc] init];
    self.locationManager.delegate = self;
    [self.locationManager startUpdatingLocation];
    
}

- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location reGeocode:(AMapLocationReGeocode *)reGeocode
{
    self.locationR = location;
    NSLog(@"location:{lat:%f; lon:%f; accuracy:%f}", location.coordinate.latitude, location.coordinate.longitude, location.horizontalAccuracy);
    if (reGeocode)
    {
        NSLog(@"reGeocode:%@", reGeocode);
        [self.locationManager stopUpdatingLocation];
    }
}

- (UIView *)topView{
    if (!_topView) {
        _topView = [[UIView alloc] init];
        _topView.backgroundColor = [UIColor whiteColor];
        
        [_topView addSubview:self.textView];
        [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.topView).offset(13);
            make.left.equalTo(self.topView).offset(13);
            make.right.equalTo(self.topView).offset(-13);
            make.height.offset(95);
        }];
    }
    return _topView;
}

- (QMUITextView *)textView{
    if (!_textView) {
        _textView = [[QMUITextView alloc] init];
        _textView.font = [UIFont systemFontOfSize:13];
        _textView.textColor = UIColorMake(34, 34, 34);
        _textView.placeholder = @"请输入文字...";
        _textView.placeholderColor = UIColorMake(51, 51, 51);
    }
    return _textView;
}

- (UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
        _bottomView.backgroundColor = [UIColor whiteColor];
        QMUIButton *location = [[QMUIButton alloc] init];
        [location setImage:[UIImage imageNamed:@"定位--小-灰色"] forState:UIControlStateNormal];
        [location setTitle:@"店面地址" forState:UIControlStateNormal];
        [location setTitleColor:UIColorMake(51, 51, 51) forState:UIControlStateNormal];
        location.titleLabel.font = [UIFont systemFontOfSize:13];
        location.imagePosition = QMUIButtonImagePositionLeft;
        location.spacingBetweenImageAndTitle = 13;
        [_bottomView addSubview:location];
        [location mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.bottomView).offset(0);
            make.left.equalTo(self.bottomView).offset(13);
            make.height.offset(50);
        }];
        [_bottomView addSubview:self.locationTextView];
        [_locationTextView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(location.mas_bottom).offset(0);
            make.left.equalTo(self.bottomView).offset(13);
            make.right.equalTo(self.bottomView).offset(-13);
            make.bottom.equalTo(self.bottomView).offset(-13);
            make.height.offset(96);
        }];
    }
    return _bottomView;
}

- (QMUITextView *)locationTextView{
    if (!_locationTextView) {
        _locationTextView = [[QMUITextView alloc] init];
        _locationTextView.textColor = UIColorMake(34, 34, 34);
        _locationTextView.font = [UIFont systemFontOfSize:13];
        _locationTextView.backgroundColor = UIColorMake(242, 242, 242);
    }
    return _locationTextView;
}

- (UIButton *)submit{
    if (!_submit) {
        _submit = [[UIButton alloc] init];
        [_submit setTitle:@"发布" forState:UIControlStateNormal];
        _submit.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        [_submit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _submit.layer.cornerRadius = 5;
        _submit.backgroundColor = UIColorMake(255, 80, 0);
        [_submit addTarget:self action:@selector(submitArticle) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submit;
}

- (NSMutableArray *)photoAsset{
    if (!_photoAsset) {
        _photoAsset = [[NSMutableArray alloc] init];
    }
    return _photoAsset;
}

- (void)userPressedAddImage{
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:9 delegate:self];
    imagePickerVc.sortAscendingByModificationDate = NO;
    imagePickerVc.allowPickingOriginalPhoto = YES;
    imagePickerVc.selectedAssets = self.photoAsset;
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}

- (void)userDeleteItem:(NSInteger)index{
    [self.photoAsset removeObjectAtIndex:index];
    self.photo.style = SCPhotoViewStyleAddInFirst;
    self.photo.photos = self.photoAsset;
}
#pragma mark - <TZImagePickerControllerDelegate>

- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto {
    self.photoAsset = [assets mutableCopy];
    if (self.photoAsset.count == 9) {
        self.photo.style = SCPhotoViewStyleShow;
    }
    else{
        self.photo.style = SCPhotoViewStyleAddInLast;
    }
    self.photo.photos = self.photoAsset;
    [self.view layoutIfNeeded];
}

- (void)submitArticle{
    if (IsNullString(_textView.text)) {
        [QMUITips showError:@"请输入文字"];
        return;
    }
    
    if (!self.photoAsset || self.photoAsset.count == 0) {
        [QMUITips showError:@"请选择图片"];
        return;
    }
    
    if (IsNullString(_locationTextView.text)) {
        [QMUITips showError:@"请输入地址"];
        return;
    }
    
    if (!self.locationR) {
        [QMUITips showError:@"未能获取到定位"];
        return;
    }
    
    __weak typeof(self) weakself = self;
    [QMUITips showLoadingInView:self.view];
    [self upImageWith:@"activity" data:self.photoAsset success:^(id  _Nonnull result) {
        NSMutableDictionary *parmatetr = [NSMutableDictionary dictionary];
        [parmatetr setObject:weakself.textView.text forKey:@"content"];
        [parmatetr setObject:result[@"fileUrl"] forKey:@"images"];
        [parmatetr setObject:weakself.locationTextView.text forKey:@"address"];
        [parmatetr setObject:[NSNumber numberWithFloat:self.locationR.coordinate.longitude] forKey:@"lng"];
        [parmatetr setObject:[NSNumber numberWithFloat:self.locationR.coordinate.latitude] forKey:@"lat"];
        [self submitArticleWith:parmatetr success:^(id  _Nonnull result) {
            [QMUITips hideAllTips];
            [QMUITips showSucceed:@"发布成功"];
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

@end
