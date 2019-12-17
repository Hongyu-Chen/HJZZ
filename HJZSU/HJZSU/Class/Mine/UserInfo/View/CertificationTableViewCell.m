//
//  CertificationTableViewCell.m
//  HJZSS
//
//  Created by apple on 2019/3/1.
//  Copyright © 2019 apple. All rights reserved.
//

#import "CertificationTableViewCell.h"
#import <Photos/Photos.h>

@interface CertificationTableViewCell ()<TZImagePickerControllerDelegate>

@property (strong,nonatomic) UIImageView *caredZ;

@end

@implementation CertificationTableViewCell

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
        self.backgroundColor = UIColorMakeWithRGBA(239, 239, 239, 1.0);
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIView *bgView = [[UIView alloc] init];
        bgView.backgroundColor = [UIColor whiteColor];
        [self addSubview:bgView];
        bgView.layer.cornerRadius = 5.0;
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(13);
            make.left.equalTo(self).offset(13);
            make.right.equalTo(self).offset(-13);
            make.bottom.equalTo(self).offset(0);
        }];
        
        UILabel *tip1 = [LabelCreat creatLabelWith:@"营业执照" font:[UIFont boldSystemFontOfSize:15] color:UIColorMake(51, 51, 51) textAlignment:NSTextAlignmentLeft];
        
        [bgView addSubview:tip1];
        [bgView addSubview:self.caredZ];
        
        [tip1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(bgView).offset(0);
            make.left.equalTo(bgView).offset(10);
            make.height.offset(40);
        }];
        
        [_caredZ mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(tip1.mas_bottom).offset(0);
            make.left.equalTo(bgView).offset(10);
            make.right.equalTo(bgView).offset(-10);
            make.height.offset(150);
        }];
    }
    return self;
}

- (UIImageView *)caredZ{
    if (!_caredZ) {
        _caredZ = [[UIImageView alloc] init];
        _caredZ.contentMode = UIViewContentModeScaleAspectFit;
        _caredZ.backgroundColor = UIColorMake(234, 234, 234);
        _caredZ.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(choiseImagecareZ:)];
        [_caredZ addGestureRecognizer:tap];
    }
    return _caredZ;
}
- (void)setModel:(AuthModel *)model{
    _model = model;
    if (_model) {
        [self setImageTo:self.caredZ andImage:_model.yinye];
    }
}

- (void)setImageTo:(UIImageView *)imageView andImage:(id)content{
    __block UIImageView *blockImage = imageView;
    if ([content isKindOfClass:[NSString class]]) {
        imageView.image = [UIImage imageNamed:content];
    }
    else if ([content isKindOfClass:[NSURL class]]){
        [imageView sd_setImageWithURL:content placeholderImage:PLACEHOLDERIMAGE];
    }
    else if ([content isKindOfClass:[UIImage class]]){
        imageView.image = content;
    }
    else if ([content isKindOfClass:[PHAsset class]]){
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [ProjectTool fetchImageWithAsset:content imageBlock:^(UIImage *iamge) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    blockImage.image = iamge;
                });
            }];
        });
    }
}

- (void)choiseImagecareZ:(UITapGestureRecognizer *)sender{
    TZImagePickerController *imagePicker = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
    imagePicker.allowPickingOriginalPhoto = NO;
    imagePicker.allowPickingVideo = NO;
    imagePicker.allowPickingImage = YES;
    imagePicker.showSelectBtn = NO;
    [[ProjectTool getCurrentViewController] presentViewController:imagePicker animated:YES completion:nil];
}

-(void)imagePickerController:(TZImagePickerController *)picker
      didFinishPickingPhotos:(NSArray<UIImage *> *)photos
                sourceAssets:(NSArray *)assets
       isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto{
    self.model.yinye = [assets firstObject];
    self.model = _model;
}

@end
