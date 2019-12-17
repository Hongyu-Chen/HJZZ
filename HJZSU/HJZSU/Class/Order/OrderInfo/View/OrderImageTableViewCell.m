//
//  OrderImageTableViewCell.m
//  HJZSU
//
//  Created by apple on 2019/3/13.
//  Copyright © 2019 apple. All rights reserved.
//

#import "OrderImageTableViewCell.h"
#import "SCPhotoView.h"

@interface OrderImageTableViewCell ()

@property (strong,nonatomic) UILabel *titleLab;
@property (strong,nonatomic) SCPhotoView *photo;

@end

@implementation OrderImageTableViewCell

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
        
        self.photo =  [[SCPhotoView alloc] initWithSCPhotoViewStyle:SCPhotoViewStyleShow];
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

- (void)setModel:(OrderModelInfo *)model{
    _model = model;
    if (_model) {
        NSMutableArray *photo = [NSMutableArray array];
        for (NSString *str in [_model.images componentsSeparatedByString:@";"]) {
            if (!IsNullString(str)) {
                [photo addObject:[NSURL URLWithString:str]];
            }
        }
        self.photo.photos = photo;
    }
}


@end
