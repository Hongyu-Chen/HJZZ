//
//  SInfoTableViewCell.m
//  HJZSU
//
//  Created by apple on 2019/3/7.
//  Copyright © 2019 apple. All rights reserved.
//

#import "SInfoTableViewCell.h"

@interface SInfoTableViewCell ()

@property (strong,nonatomic) UIImageView *topImage;
@property (strong,nonatomic) FormatLabel *contentLab;

@end

@implementation SInfoTableViewCell

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
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self addSubview:self.topImage];
        [self addSubview:self.contentLab];
        
        [_topImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.equalTo(self).offset(13);
            make.right.equalTo(self).offset(-13);
//            make.height.offset((SCREEN_WIDTH - 26)*384/698.0);
            make.height.offset(0);
        }];
        
        [_contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.topImage.mas_bottom).offset(20);
            make.left.equalTo(self).offset(13);
            make.right.equalTo(self).offset(-13);
        }];
        
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = UIColorMake(239, 239, 239);
        [self addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentLab.mas_bottom).offset(20);
            make.bottom.equalTo(self).offset(0);
            make.left.equalTo(self).offset(0);
            make.right.equalTo(self).offset(0);
            make.height.offset(13);
        }];
        
    }
    return self;
}

- (UIImageView *)topImage{
    if (!_topImage) {
        _topImage = [[UIImageView alloc] init];
        _topImage.contentMode = UIViewContentModeScaleAspectFit;
        _topImage.backgroundColor = [UIColor whiteColor];
        _topImage.image = PLACEHOLDERIMAGE;
        _topImage.layer.cornerRadius = 10;
    }
    return _topImage;
}

-(FormatLabel *)contentLab{
    if (!_contentLab) {
        _contentLab = [[FormatLabel alloc] init];
        _contentLab.textColor = UIColorMake(51, 51, 51);
        _contentLab.font = [UIFont systemFontOfSize:14];
        _contentLab.numberOfLines = 0;
        _contentLab.wordSpace = 1.5;
        _contentLab.lineSpcae = 5.0;
        
        [self getSystemAblutsuccess:^(id  _Nonnull result) {
            NSAttributedString *attributeString = [[NSAttributedString alloc] initWithData:[result[@"content"] dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
            self.contentLab.attributedText = attributeString;
        } failed:^(NSString * _Nonnull reson) {
            
        }];
    }
    return _contentLab;
}

@end
