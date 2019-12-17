//
//  YDTableViewCell.m
//  HJZSS
//
//  Created by apple on 2019/2/26.
//  Copyright © 2019 apple. All rights reserved.
//

#import "YDTableViewCell.h"

@interface YDTableViewCell ()

@property (strong,nonatomic) UIImageView *headerImage;
@property (strong,nonatomic) UILabel *value;

@end

@implementation YDTableViewCell

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
        self.backgroundColor = UIColorMake(239, 239, 239);
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIView *bgImage = [[UIView alloc] init];
        bgImage.backgroundColor = [UIColor whiteColor];
        bgImage.layer.cornerRadius = 6;
        [self addSubview:bgImage];
        
        [bgImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self).offset(0);
            make.bottom.equalTo(self).offset(-10);
        }];
        
        

        
       
        
        UILabel *indexTip = [LabelCreat creatLabelWith:@"1" font:[UIFont systemFontOfSize:19] color:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter];
        indexTip.backgroundColor = UIColorMake(251, 80, 0);
        indexTip.clipsToBounds = YES;
        UILabel *step = [LabelCreat creatLabelWith:@"step" font:[UIFont systemFontOfSize:19] color:UIColorMake(51, 51, 51) textAlignment:NSTextAlignmentLeft];
        self.value = [LabelCreat creatLabelWith:@"step" font:[UIFont systemFontOfSize:14] color:UIColorMake(51, 51, 51) textAlignment:NSTextAlignmentLeft];
        
        [self addSubview:indexTip];
        [self addSubview:step];
        [self addSubview:self.value];
        
        [self addSubview:self.headerImage];
        
        [indexTip mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(11);
            make.left.equalTo(self).offset(16);
            make.width.height.offset(28);
        }];
        indexTip.layer.cornerRadius = 14;
        
        [step mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(11);
            make.left.equalTo(indexTip.mas_right).offset(10);
            make.height.equalTo(indexTip);
        }];
        
        [_value mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(11);
            make.left.equalTo(step.mas_right).offset(10);
//            make.right.equalTo(self).offset(-16);
            make.height.equalTo(indexTip);
        }];
        
        [_headerImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(60);
            make.left.equalTo(self).offset(13);
            make.bottom.right.equalTo(bgImage).offset(-13);
        }];
       
        
    }
    return self;
}

- (UIImageView *)headerImage{
    if (!_headerImage) {
        _headerImage = [[UIImageView alloc] init];
        _headerImage.contentMode = UIViewContentModeScaleAspectFit;
        _headerImage.clipsToBounds = YES;
        _headerImage.layer.cornerRadius = 5;
//        _headerImage.backgroundColor = [UIColor grayColor];
        _headerImage.backgroundColor = [UIColor whiteColor];
        _headerImage.image = PLACEHOLDERIMAGE;
    }
    return _headerImage;
}

- (void)setImageContent:(id)imageContent{
    _imageContent = imageContent;
    
    if ([_imageContent isKindOfClass:[NSString class]]) {
        _headerImage.image = [UIImage imageNamed:_imageContent];
    }
}

- (void)setValueStr:(NSString *)valueStr{
    _valueStr = valueStr;
    if (_valueStr) {
        _value.text = _valueStr;
    }
}




@end
