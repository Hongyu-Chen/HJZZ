//
//  SlistTableViewCell.m
//  HJZSU
//
//  Created by apple on 2019/3/7.
//  Copyright © 2019 apple. All rights reserved.
//

#import "SlistTableViewCell.h"
#import "RankImage.h"
#import "RankView.h"

@interface SlistTableViewCell ()

@property (strong,nonatomic) RankView *rankView;
@property (strong,nonatomic) RankImage *headerImage;
@property (strong,nonatomic) UILabel *name;
@property (strong,nonatomic) UILabel *detail;
@end

@implementation SlistTableViewCell

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
        self.name = [LabelCreat creatLabelWith:@"JSon" font:[UIFont boldSystemFontOfSize:15] color:UIColorMake(51, 51, 51) textAlignment:NSTextAlignmentCenter];
        self.detail = [LabelCreat creatLabelWith:@"获取100钻石" font:[UIFont systemFontOfSize:15] color:UIColorMake(137, 137, 137) textAlignment:NSTextAlignmentLeft];
        self.detail.hidden = YES;
        [self addSubview:self.rankView];
        [self addSubview:self.headerImage];
        [self addSubview:self.name];
        [self addSubview:self.detail];
        
        [_rankView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.left.equalTo(self).offset(0);
            make.width.offset(36);
        }];
        
        [_headerImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(5);
            make.left.equalTo(self.rankView.mas_right).offset(0);
            make.bottom.equalTo(self).offset(-5);
            make.width.height.offset(40);
        }];
        
        [_name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self).offset(0);
            make.left.equalTo(self.headerImage.mas_right).offset(13);
        }];
        
        [_detail mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.top.equalTo(self).offset(0);
            make.right.equalTo(self).offset(-13);
        }];
        
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = UIColorMake(239, 239, 239);
        [self addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self).offset(0);
            make.left.equalTo(self.rankView.mas_right).offset(0);
            make.right.equalTo(self).offset(-13);
            make.height.offset(1);
        }];
    }
    return self;
}

- (RankView *)rankView{
    if (!_rankView) {
        _rankView = [[RankView alloc] init];
    }
    return _rankView;
}

- (RankImage *)headerImage{
    if (!_headerImage) {
        _headerImage = [[RankImage alloc] init];
    }
    return _headerImage;
}

- (void)setIndexPath:(NSIndexPath *)indexPath{
    _indexPath = indexPath;
    if (_indexPath) {
        _rankView.rank = _indexPath.row + 1;
        
        if (_indexPath.row < 3) {
            self.headerImage.headerTip.image = [UIImage imageNamed:@[@"第一头像",@"第二头像",@"第三头像"][indexPath.row]];
        }
    }
}

- (void)setModel:(RankModel *)model{
    _model = model;
    if (_model) {
        [self.headerImage.header sd_setImageWithURL:[NSURL URLWithString:_model.logo] placeholderImage:PLACEHOLDERIMAGE];
        _name.text = _model.name;
    }
}

@end
