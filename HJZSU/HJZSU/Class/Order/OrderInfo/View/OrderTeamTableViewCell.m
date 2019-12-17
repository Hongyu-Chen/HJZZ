//
//  OrderTeamTableViewCell.m
//  HJZSU
//
//  Created by apple on 2019/3/13.
//  Copyright © 2019 apple. All rights reserved.
//

#import "OrderTeamTableViewCell.h"

@interface OrderTeamTableViewCell ()

@property (strong,nonatomic) UIView *bottomView;
@property (strong,nonatomic) UIImageView *headerImage;
@property (strong,nonatomic) FormatLabel *name;
@property (strong,nonatomic) FormatLabel *teameLev;
@property (strong,nonatomic) FormatLabel *teamNumber;
@property (strong,nonatomic) FormatLabel *teameTimes;
@property (strong,nonatomic) UIButton *linkBtn;

@end

@implementation OrderTeamTableViewCell

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
        
        [self addSubview:self.bottomView];
        [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(0);
            make.left.right.bottom.equalTo(self).offset(0);
            make.height.offset(145);
        }];
        
        
    }
    return self;
}

- (UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
        _bottomView.backgroundColor = [UIColor whiteColor];
        
        [_bottomView addSubview:self.headerImage];
        [_bottomView addSubview:self.name];
        [_bottomView addSubview:self.teameLev];
        [_bottomView addSubview:self.teamNumber];
        [_bottomView addSubview:self.teameTimes];
        [_bottomView addSubview:self.linkBtn];
        
        [_headerImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.bottomView).offset(13);
            make.left.equalTo(self.bottomView).offset(13);
            make.bottom.equalTo(self.bottomView).offset(-13);
            make.width.offset(119);
        }];
        
        [_name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.bottomView).offset(13);
            make.left.equalTo(self.headerImage.mas_right).offset(13);
            make.right.equalTo(self.bottomView).offset(-13);
        }];
        
        [_teameLev mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.name.mas_bottom).offset(0);
            make.left.equalTo(self.headerImage.mas_right).offset(13);
            make.right.equalTo(self.bottomView).offset(-13);
            make.height.equalTo(self.name);
        }];
        
        [_teamNumber mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.teameLev.mas_bottom).offset(0);
            make.left.equalTo(self.headerImage.mas_right).offset(13);
            make.right.equalTo(self.bottomView).offset(-13);
            make.height.equalTo(self.teameLev);
        }];
        
        [_teameTimes mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.teamNumber.mas_bottom).offset(0);
            make.left.equalTo(self.headerImage.mas_right).offset(13);
            make.right.equalTo(self.bottomView).offset(-13);
            make.height.equalTo(self.teamNumber);
            make.bottom.equalTo(self.bottomView).offset(-13);
        }];
        
        [_linkBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.teameLev.mas_bottom).offset(0);
            make.left.equalTo(self.headerImage.mas_right).offset(13);
            make.height.equalTo(self.name);
        }];
    }
    return _bottomView;
}

- (UIImageView *)headerImage{
    if (!_headerImage) {
        _headerImage = [[UIImageView alloc] init];
        _headerImage.contentMode = UIViewContentModeScaleAspectFill;
        _headerImage.layer.cornerRadius = 5;
        _headerImage.clipsToBounds = YES;
        _headerImage.backgroundColor = [UIColor whiteColor];
    }
    return _headerImage;
}

- (FormatLabel *)name{
    if (!_name) {
        _name = [[FormatLabel alloc] init];
        _name.font = [UIFont boldSystemFontOfSize:15];
        _name.textColor = UIColorMake(51, 51, 51);
        _name.text = @"团队名称";
    }
    return _name;
}

- (FormatLabel *)teameLev{
    if (!_teameLev) {
        _teameLev = [[FormatLabel alloc] init];
        _teameLev.font = [UIFont systemFontOfSize:15];
        _teameLev.textColor = UIColorMake(137, 137, 137);
        _teameLev.text = @"联系电话";
        [_teameLev setHeightLightWords:@[@"高级战神"] heightLightColors:@[UIColorMake(51, 51, 51)] htightLightFont:@[[UIFont boldSystemFontOfSize:15]]];
    }
    return _teameLev;
}

- (FormatLabel *)teamNumber{
    if (!_teamNumber) {
        _teamNumber = [[FormatLabel alloc] init];
        _teamNumber.font = [UIFont systemFontOfSize:15];
        _teamNumber.textColor = UIColorMake(137, 137, 137);
        _teamNumber.text = @"";
//        [_teamNumber setHeightLightWords:@[@"5人"] heightLightColors:@[UIColorMake(51, 51, 51)] htightLightFont:@[[UIFont boldSystemFontOfSize:15]]];
    }
    return _teamNumber;
}

- (FormatLabel *)teameTimes{
    if (!_teameTimes) {
        _teameTimes = [[FormatLabel alloc] init];
        _teameTimes.font = [UIFont systemFontOfSize:15];
        _teameTimes.textColor = UIColorMake(137, 137, 137);
        _teameTimes.text = @"";
//        [_teameTimes setHeightLightWords:@[@"21次"] heightLightColors:@[UIColorMake(51, 51, 51)] htightLightFont:@[[UIFont boldSystemFontOfSize:15]]];
    }
    return _teameTimes;
}

- (UIButton *)linkBtn{
    if (!_linkBtn) {
        _linkBtn = [[UIButton alloc] init];
        [_linkBtn setImage:[UIImage imageNamed:@"联系客户"] forState:UIControlStateNormal];
        _linkBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [_linkBtn addTarget:self action:@selector(linkBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _linkBtn;
}

- (void)linkBtnPressed:(UIButton *)sender{
    ChatViewController *chat = [[ChatViewController alloc] initWithConversationChatter:[NSString stringWithFormat:@"team%@",_model.teamId] conversationType:EMConversationTypeChat];
    [EMUserInfo saveToUserInfo:[NSString stringWithFormat:@"team%@",_model.teamId] name:_model.teamName avatarURLPath:IsNullString(_model.teamLogo) ? IsNullString(_model.teamHead) ? @"" : _model.teamHead : _model.teamLogo];
    chat.toUserName = _model.teamName;
    chat.toUserHeader = IsNullString(_model.teamLogo) ? IsNullString(_model.teamHead) ? @"" : _model.teamHead : _model.teamLogo;
    [[ProjectTool getCurrentViewController].navigationController pushViewController:chat animated:YES];
}

- (void)setModel:(OrderModelInfo *)model{
    _model = model;
    if (_model) {
        self.name.text = _model.teamName;
        if (!IsNullString(_model.teamLogo)) {
            [self.headerImage sd_setImageWithURL:[NSURL URLWithString:[_model.teamLogo componentsSeparatedByString:@";"].firstObject] placeholderImage:PLACEHOLDERIMAGE];
        }
        else if (!IsNullString(_model.teamHead)){
            [self.headerImage sd_setImageWithURL:[NSURL URLWithString:[_model.teamHead componentsSeparatedByString:@";"].firstObject] placeholderImage:PLACEHOLDERIMAGE];
        }
        
        _teameLev.text = [NSString stringWithFormat:@"联系电话   %@",_model.teamPhone];
        [_teameLev setHeightLightWords:@[IsNullString(_model.teamPhone) ? @"" : _model.teamPhone] heightLightColors:@[UIColorMake(51, 51, 51)] htightLightFont:@[[UIFont boldSystemFontOfSize:15]]];
    }
}

@end
