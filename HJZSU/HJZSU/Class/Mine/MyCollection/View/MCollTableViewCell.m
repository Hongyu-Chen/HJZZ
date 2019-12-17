//
//  MCollTableViewCell.m
//  HJZSU
//
//  Created by apple on 2019/3/14.
//  Copyright © 2019 apple. All rights reserved.
//

#import "MCollTableViewCell.h"
#import "StartView.h"

@interface MCollTableViewCell ()

@property (strong,nonatomic) UIImageView *header;
@property (strong,nonatomic) UILabel *name;
@property (strong,nonatomic) StartView *start;
@property (strong,nonatomic) UIButton *canel;

@end

@implementation MCollTableViewCell

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
        self.name = [LabelCreat creatLabelWith:@"团队名称xxxx" font:[UIFont boldSystemFontOfSize:15] color:UIColorMake(34, 34, 34) textAlignment:NSTextAlignmentLeft];
        [self addSubview:self.header];
        [self addSubview:self.name];
        [self addSubview:self.start];
        [self addSubview:self.canel];
        
        [_header mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.equalTo(self).offset(13);
            make.width.offset(119);
            make.height.offset(152);
            make.bottom.equalTo(self).offset(-26);
        }];
        
        [_name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(13);
            make.left.equalTo(self.header.mas_right).offset(13);
            make.right.equalTo(self).offset(-13);
        }];
        
        [_start mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.name.mas_bottom).offset(27);
            make.left.equalTo(self.header.mas_right).offset(13);
            make.right.equalTo(self).offset(-13);
            make.height.offset(20);
        }];
        
        [_canel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.start.mas_bottom).offset(27);
            make.left.equalTo(self.header.mas_right).offset(13);
            make.height.offset(30);
            make.width.offset(90);
        }];
        
        UIView *line2 = [[UIView alloc] init];
        line2.backgroundColor = UIColorMake(239, 239, 239);
        [self addSubview:line2];
        [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.equalTo(self).offset(0);
            make.height.offset(13);
        }];
    }
    return self;
}

- (StartView *)start{
    if (!_start) {
        _start = [[StartView alloc] init];
        _start.margin = 14;
        _start.color = UIColorMake(137, 137, 137);
        _start.number = 4.0;
    }
    return _start;
}

- (UIImageView *)header{
    if (!_header) {
        _header = [[UIImageView alloc] init];
        _header.contentMode = UIViewContentModeScaleAspectFill;
        _header.layer.cornerRadius = 5;
        _header.clipsToBounds = YES;
        _header.backgroundColor = [UIColor whiteColor];
        _header.image = PLACEHOLDERIMAGE;
    }
    return _header;
}

- (UIButton *)canel{
    if (!_canel) {
        _canel = [[UIButton alloc] init];
        [_canel setTitle:@"取消关注" forState:UIControlStateNormal];
        [_canel setTitleColor:UIColorMake(51, 51, 51) forState:UIControlStateNormal];
        _canel.layer.cornerRadius = 15;
        _canel.layer.borderWidth = 1.0;
        _canel.layer.borderColor = UIColorMake(137, 137, 137).CGColor;
        _canel.titleLabel.font = [UIFont systemFontOfSize:15];
        [_canel addTarget:self action:@selector(canelTeameCollection) forControlEvents:UIControlEventTouchUpInside];
    }
    return _canel;
}

- (void)setModel:(TeamListModel *)model{
    _model = model;
    if (_model) {
        [_header sd_setImageWithURL:[NSURL URLWithString:_model.logo] placeholderImage:PLACEHOLDERIMAGE];
        _name.text = _model.name;
        _start.number = _model.start;
    }
}

- (void)canelTeameCollection{
    __weak typeof(self) weakself = self;
    [self addDeleteTeamCollec:_model.id type:1 success:^(id  _Nonnull result) {
        [QMUITips showSucceed:@"取消成功"];
        if (weakself.deleteCell) {
            weakself.deleteCell(weakself.model);
        }
    } failed:^(NSString * _Nonnull reson) {
        [QMUITips showError:reson];
    }];
}

@end
