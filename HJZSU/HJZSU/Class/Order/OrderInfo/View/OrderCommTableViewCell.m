//
//  OrderCommTableViewCell.m
//  HJZSU
//
//  Created by apple on 2019/4/11.
//  Copyright © 2019 apple. All rights reserved.
//

#import "OrderCommTableViewCell.h"
#import "StartView.h"
#import "SCPhotoView.h"

@interface OrderCommTableViewCell ()<SCPhotoViewDelegate>

@property (strong,nonatomic) UIImageView *headerImage;
@property (strong,nonatomic) UILabel *name;
@property (strong,nonatomic) UILabel *time;
@property (strong,nonatomic) StartView *start;
@property (strong,nonatomic) UILabel *contentLab;
@property (strong,nonatomic) SCPhotoView *photo;



@end

@implementation OrderCommTableViewCell

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
        self.name = [LabelCreat creatLabelWith:@" " font:[UIFont systemFontOfSize:15] color:UIColorMake(73, 73, 73) textAlignment:NSTextAlignmentLeft];
        self.time = [LabelCreat creatLabelWith:@" " font:[UIFont systemFontOfSize:12] color:UIColorMake(153, 153, 153) textAlignment:NSTextAlignmentLeft];
        self.contentLab = [LabelCreat creatLabelWith:@" " font:[UIFont systemFontOfSize:12] color:UIColorMake(153, 153, 153) textAlignment:NSTextAlignmentLeft];
        self.contentLab.numberOfLines = 0;
        [self addSubview:self.headerImage];
        [self addSubview:self.name];
        [self addSubview:self.time];
        [self addSubview:self.start];
        [self addSubview:self.contentLab];
        
        [_headerImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.equalTo(self).offset(13);
            make.width.height.offset(40);
        }];
        
        [_name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(13);
            make.left.equalTo(self.headerImage.mas_right).offset(10);
        }];
        
        [_time mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.name.mas_bottom).offset(0);
            make.left.equalTo(self.headerImage.mas_right).offset(10);
            make.bottom.equalTo(self.headerImage.mas_bottom).offset(0);
            make.height.equalTo(self.name);
        }];
        
        [_start mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(13);
            make.right.equalTo(self).offset(-13);
            make.height.equalTo(self.headerImage);
        }];
        
        [_contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.headerImage.mas_bottom).offset(12);
            make.left.equalTo(self.headerImage.mas_right).offset(10);
        }];
        
        self.photo =  [[SCPhotoView alloc] initWithSCPhotoViewStyle:SCPhotoViewStyleShow];
        self.photo.contentWidth = SCREEN_WIDTH - 79;
        self.photo.showDelete = NO;
        self.photo.showPreviewPicture = YES;
        self.photo.photos = [NSMutableArray array];
        [self addSubview:self.photo];
        [self.photo mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentLab.mas_bottom).offset(13);
            make.left.equalTo(self.headerImage.mas_right).offset(13);
            make.right.equalTo(self).offset(-13);
            make.bottom.equalTo(self).offset(-13);
        }];
    }
    return self;
}

- (UIImageView *)headerImage{
    if (!_headerImage) {
        _headerImage = [[UIImageView alloc] init];
        _headerImage.clipsToBounds = YES;
        _headerImage.contentMode = UIViewContentModeScaleAspectFill;
        _headerImage.backgroundColor = [UIColor whiteColor];
        _headerImage.layer.cornerRadius = 20;
    }
    return _headerImage;
}

- (StartView *)start{
    if (!_start) {
        _start = [[StartView alloc] init];
        _start.number = 4.0;
    }
    return _start;
}
- (void)setModel:(UserOderCommModel *)model{
    _model = model;
    if (_model) {
        [_headerImage sd_setImageWithURL:[NSURL URLWithString:_model.teamHead] placeholderImage:PLACEHOLDERIMAGE];
        _name.text = _model.teamName;
        _time.text = [NSString hoursTimeWith:_model.createTime];
        _contentLab.text = _model.content;
        _start.number = [_model.score floatValue];
        NSMutableArray *urls = [NSMutableArray array];
        for (NSString *str in [_model.images componentsSeparatedByString:@";"]) {
            if (!IsNullString(str)) {
                [urls addObject:[NSURL URLWithString:str]];
            }
        }
        self.photo.photos = urls;
    }
}

@end
