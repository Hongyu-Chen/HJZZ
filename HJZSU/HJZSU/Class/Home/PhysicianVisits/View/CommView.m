//
//  CommView.m
//  HJZSU
//
//  Created by apple on 2019/3/12.
//  Copyright © 2019 apple. All rights reserved.
//

#import "CommView.h"

@interface CommView ()

@property (strong,nonatomic) UIImageView *headerImage;
@property (strong,nonatomic) UILabel *name;
@property (strong,nonatomic) UILabel *contentLab;
@property (strong,nonatomic) UIButton *replay;
@property (strong,nonatomic) UILabel *time;
@property (strong,nonatomic) PhyRecomModel *reModel;
@property (strong,nonatomic) PRComment *commModel;
@property (strong,nonatomic) UIButton *deleteBtn;


@end

@implementation CommView

- (instancetype)init{
    self = [super init];
    if (self) {
        self.name = [LabelCreat creatLabelWith:@"粉丝的微笑" font:[UIFont boldSystemFontOfSize:14] color:UIColorMake(73, 73, 73) textAlignment:NSTextAlignmentLeft];
        self.contentLab = [LabelCreat creatLabelWith:@"评论文字描述...评论文字描述...评论文字描述...评论文字描述...评论文字描述...评论文字描述...评论文字描述...评论文字描述...评论文字描述..." font:[UIFont systemFontOfSize:12] color:UIColorMake(137, 137, 137) textAlignment:NSTextAlignmentLeft];
        self.time = [LabelCreat creatLabelWith:@"今天 12:52" font:[UIFont systemFontOfSize:13] color:UIColorMake(137, 137, 137) textAlignment:NSTextAlignmentLeft];
        self.contentLab.numberOfLines = 0;
        
        [self addSubview:self.headerImage];
        [self addSubview:self.deleteBtn];
        [self addSubview:self.name];
        [self addSubview:self.contentLab];
        [self addSubview:self.time];
        [self addSubview:self.replay];
        
        [_headerImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.equalTo(self).offset(13);
            make.width.height.offset(40);
        }];
        [_name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(13);
            make.left.equalTo(self.headerImage.mas_right).offset(13);
            make.height.equalTo(self.headerImage);
            make.right.equalTo(self).offset(-40);
        }];
        
        [_deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(13);
            make.height.equalTo(self.headerImage);
            make.right.equalTo(self).offset(-13);
        }];
        
        [_contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.headerImage.mas_bottom).offset(15);
            make.left.equalTo(self.headerImage.mas_right).offset(13);
            make.right.equalTo(self).offset(-13);
        }];
        
        [_time mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentLab.mas_bottom).offset(13);
            make.left.equalTo(self.headerImage.mas_right).offset(13);
            make.bottom.equalTo(self).offset(-13);
        }];
        
        [_replay mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentLab.mas_bottom).offset(13);
            make.right.equalTo(self).offset(-13);
            make.bottom.equalTo(self).offset(-13);
        }];
    }
    return self;
}

- (UIButton *)deleteBtn{
    if (!_deleteBtn) {
        _deleteBtn  = [[UIButton alloc] init];
        [_deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
        [_deleteBtn setTitleColor:UIColorMake(255, 80, 0) forState:UIControlStateNormal];
        _deleteBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [_deleteBtn addTarget:self action:@selector(deleteBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteBtn;
}

- (UIImageView *)headerImage{
    if (!_headerImage) {
        _headerImage = [[UIImageView alloc] init];
        _headerImage.layer.cornerRadius = 20.0;
//        _headerImage.backgroundColor = UIColorMake(arc4random()%255, arc4random()%255, arc4random()%255);
        _headerImage.image = UIImageMake(@"Logo");
        _headerImage.contentMode = UIViewContentModeScaleAspectFill;
        _headerImage.clipsToBounds = YES;
    }
    return _headerImage;
}

- (UIButton *)replay{
    if (!_replay) {
        _replay = [[UIButton alloc] init];
        [_replay setTitle:@"回复" forState:UIControlStateNormal];
        [_replay setTitleColor:UIColorMake(255, 80, 0) forState:UIControlStateNormal];
        _replay.titleLabel.font = [UIFont systemFontOfSize:13];
        [_replay addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _replay;
}
- (void)uploadRecommModel:(PhyRecomModel *)model{
    [_headerImage sd_setImageWithURL:[NSURL URLWithString:model.userHead] placeholderImage:PLACEHOLDERIMAGE];
    _name.text = model.userName;
    _contentLab.text = model.content;
    _time.text = [NSString hoursTimeWith:model.createTime];
    self.reModel = model;
    
    if ([[NSString stringWithFormat:@"%@",model.userId] isEqualToString:[[YYCacheManager shareYYCacheManager] uid]]) {
        self.deleteBtn.hidden = NO;
    }
    else{
        self.deleteBtn.hidden = YES;
    }
    
}
- (void)uploadReplyModel:(PRComment *)model{
    [_headerImage sd_setImageWithURL:[NSURL URLWithString:model.fromHead] placeholderImage:PLACEHOLDERIMAGE];
    _name.text = model.fromName;
    _contentLab.text = model.content;
    _time.text = [NSString hoursTimeWith:model.createTime];
    self.commModel = model;
    
    if ([[NSString stringWithFormat:@"%@",model.fromUid] isEqualToString:[[YYCacheManager shareYYCacheManager] uid]]) {
        self.deleteBtn.hidden = NO;
    }
    else{
        self.deleteBtn.hidden = YES;
    }
}

- (void)buttonPressed:(UIButton *)sender{
    [self replyButtonPressedWith:self.reModel ? self.reModel : self.commModel andType:1];
}

- (void)replyButtonPressedWith:(id)model andType:(NSInteger)index{
    if (_delegate) {
        [_delegate replyButtonPressedWith:model andType:index];
    }
}

- (void)deleteBtnPressed{
    [self replyButtonPressedWith:self.reModel ? self.reModel : self.commModel andType:0];
}

@end
