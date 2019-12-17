//
//  SBImageTableViewCell.m
//  HJZSU
//
//  Created by apple on 2019/3/9.
//  Copyright © 2019 apple. All rights reserved.
//

#import "SBImageTableViewCell.h"
#import "SCPhotoView.h"

@interface SBImageTableViewCell ()<SCPhotoViewDelegate>

@property (strong,nonatomic) UILabel *titleLab;
@property (strong,nonatomic) SCPhotoView *photo;


@end

@implementation SBImageTableViewCell

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
        
        self.titleLab = [LabelCreat creatLabelWith:@"上传图片" font:[UIFont systemFontOfSize:14] color:UIColorMake(51, 51, 51) textAlignment:NSTextAlignmentLeft];
        [self addSubview:self.titleLab];
        
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(0);
            make.left.equalTo(self).offset(13);
            make.height.offset(50);
        }];
        
        self.photo =  [[SCPhotoView alloc] initWithSCPhotoViewStyle:SCPhotoViewStyleAddInFirst];
        self.photo.delegate = self;
        self.photo.showDelete = NO;
        self.photo.showPreviewPicture = YES;
        [self addSubview:self.photo];
        [self.photo mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLab.mas_bottom).offset(0);
            make.left.equalTo(self).offset(13);
            make.right.bottom.equalTo(self).offset(-13);
        }];
    }
    return self;
}

- (void)setImagesContent:(NSMutableArray *)imagesContent{
    _imagesContent = imagesContent;
    if (_imagesContent) {
        self.photo.photos = _imagesContent;
        
        if (self.photo.style != SCPhotoViewStyleShow) {
            if (self.model.images.count == 9) {
                self.photo.style = SCPhotoViewStyleShow;
            }
            else{
                self.photo.style = SCPhotoViewStyleAddInFirst;
            }
        }
    }
}

- (void)userPressedAddImage{
    [self userShouldChanedImagewith:0 type:1];
}

- (void)userDeleteItem:(NSInteger)index{
    [self userShouldChanedImagewith:index type:0];
}

- (void)userShouldChanedImagewith:(NSInteger)index type:(NSInteger)type{
    if (self.delegate) {
        [_delegate userShouldChanedImagewith:index type:type];
    }
}

- (void)setOnlyShow:(BOOL)onlyShow{
    _onlyShow = onlyShow;
    if (_onlyShow) {
        self.photo.style = SCPhotoViewStyleShow;
    }
}

@end
