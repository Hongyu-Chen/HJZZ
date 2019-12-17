//
//  TCommentTableViewCell.m
//  HJZSU
//
//  Created by apple on 2019/3/13.
//  Copyright © 2019 apple. All rights reserved.
//

#import "TCommentTableViewCell.h"
#import "StartView.h"

@interface TCommentTableViewCell ()<SCPhotoViewDelegate>

@property (strong,nonatomic) UIImageView *headerImage;
@property (strong,nonatomic) UILabel *name;
@property (strong,nonatomic) UILabel *time;
@property (strong,nonatomic) StartView *start;
@property (strong,nonatomic) UILabel *contentLab;
@property (strong,nonatomic) SCPhotoView *photo;

@end

@implementation TCommentTableViewCell

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
        self.name = [LabelCreat creatLabelWith:@"卡特琳啦" font:[UIFont systemFontOfSize:15] color:UIColorMake(73, 73, 73) textAlignment:NSTextAlignmentLeft];
        self.time = [LabelCreat creatLabelWith:@"2019-12-22" font:[UIFont systemFontOfSize:12] color:UIColorMake(153, 153, 153) textAlignment:NSTextAlignmentLeft];
        self.contentLab = [LabelCreat creatLabelWith:@"评价内容评价内容评价内容评价内容评价内容评价内容评价内容评价内容评价内容评价内容评价内容评价内容" font:[UIFont systemFontOfSize:12] color:UIColorMake(153, 153, 153) textAlignment:NSTextAlignmentLeft];
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
            make.right.equalTo(self).offset(-13);
        }];
        
        self.photo =  [[SCPhotoView alloc] initWithSCPhotoViewStyle:SCPhotoViewStyleShow];
        self.photo.contentWidth = SCREEN_WIDTH - 66;
        self.photo.delegate = self;
        self.photo.showDelete = NO;
        self.photo.showPreviewPicture = YES;
        [self addSubview:self.photo];
        [self.photo mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentLab.mas_bottom).offset(13);
            make.left.equalTo(self.headerImage.mas_right).offset(10);
            make.right.bottom.equalTo(self).offset(-13);
        }];
        
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = UIColorMake(239, 239, 239);
        [self addSubview:line];
        
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.left.right.equalTo(self).offset(0);
            make.height.offset(1);
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
        _headerImage.image = PLACEHOLDERIMAGE;
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

- (void)setInfo:(NSDictionary *)info{
    _info = info;
    if (_info) {
        [_headerImage sd_setImageWithURL:[NSURL URLWithString:IsNullString(_info[@"userHead"]) ? @"" : _info[@"userHead"]] placeholderImage:PLACEHOLDERIMAGE];
        _name.text = _info[@"userName"];
        _contentLab.text = _info[@"content"];
        _start.number = [_info[@"score"] floatValue];
        _time.text = [NSString stringWithFormat:@"%@",_info[@"createTime"]];
        
        NSMutableArray *photos = [NSMutableArray array];
        for (NSString *str in [_info[@"images"] componentsSeparatedByString:@";"]) {
            if (!IsNullString(str)) {
                [photos addObject:[NSURL URLWithString:str]];
            }
        }
        _photo.photos = photos;
    }
}


@end
