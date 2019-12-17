//
//  TeameCollectionCell.m
//  HJZSU
//
//  Created by apple on 2019/3/11.
//  Copyright © 2019 apple. All rights reserved.
//

#import "TeameCollectionCell.h"
#import "StartView.h"

@interface TeameCollectionCell ()

@property (strong,nonatomic) UIImageView *bgImage;
@property (strong,nonatomic) UIView *infoView;
@property (strong,nonatomic) UILabel *name;
@property (strong,nonatomic) StartView *start;
@property (strong,nonatomic) UIView *maskView;
@property (strong,nonatomic) UIImageView *selectedImage;

@end

@implementation TeameCollectionCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.bgImage];
        [self addSubview:self.infoView];
        self.layer.cornerRadius = 5.0;
        [self addSubview:self.maskView];
        [self addSubview:self.selectedImage];
        self.clipsToBounds = YES;
        
        [_bgImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.right.equalTo(self).offset(0);
        }];
        
        [_infoView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.equalTo(self).offset(0);
        }];
        
        [_maskView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self).offset(0);
            make.bottom.equalTo(self.infoView.mas_top).offset(0);
        }];
        
        [_selectedImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(13);
            make.right.equalTo(self).offset(-13);
        }];
    }
    return self;
}

- (UIImageView *)bgImage{
    if (!_bgImage) {
        _bgImage = [[UIImageView alloc] init];
        _bgImage.contentMode = UIViewContentModeScaleAspectFill;
        _bgImage.backgroundColor = [UIColor whiteColor];
        _bgImage.image = PLACEHOLDERIMAGE;
    }
    return _bgImage;
}

- (UIView *)maskView{
    if (!_maskView) {
        _maskView = [[UIView alloc] init];
        _maskView.backgroundColor = UIColorMakeWithRGBA(255, 80, 0, 0.2);
    }
    return _maskView;
}

- (UIImageView *)selectedImage{
    if (!_selectedImage) {
        _selectedImage = [[UIImageView alloc] init];
        _selectedImage.contentMode = UIViewContentModeScaleAspectFit;
        _selectedImage.image = [UIImage imageNamed:@"勾选-选中-圆圈"];
    }
    return _selectedImage;
}

- (UIView *)infoView{
    if (!_infoView) {
        _infoView = [[UIView alloc] init];
        _infoView.backgroundColor = UIColorMakeWithRGBA(14, 14, 14,0.3);
        self.name = [LabelCreat creatLabelWith:@"团队名称xxx" font:[UIFont systemFontOfSize:15] color:[UIColor whiteColor] textAlignment:NSTextAlignmentLeft];
        [_infoView addSubview:self.name];
        [_infoView addSubview:self.start];
        
        [_name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.infoView).offset(10);
            make.left.equalTo(self.infoView).offset(10);
            make.right.equalTo(self.infoView).offset(-10);
        }];
        
        [_start mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.name.mas_bottom).offset(10);
            make.bottom.equalTo(self.infoView).offset(-10);
            make.left.equalTo(self.infoView).offset(10);
            make.right.equalTo(self.infoView).offset(-10);
            make.height.equalTo(self.name);
        }];
        _start.number = 5.0;
    }
    return _infoView;
}

- (StartView *)start{
    if (!_start) {
        _start = [[StartView alloc] init];
        _start.widthS = 13;
        _start.margin = 3;
        _start.color = [UIColor whiteColor];
    }
    return _start;
}

- (void)setModel:(TeamListModel *)model{
    _model = model;
    if (_model) {
        self.name.text = _model.name;
        [self.bgImage sd_setImageWithURL:[NSURL URLWithString:_model.logo] placeholderImage:PLACEHOLDERIMAGE];
        self.start.number = _model.start;
        self.maskView.hidden = !_model.isSelected;
        self.selectedImage.hidden = !_model.isSelected;
    }
}

@end
