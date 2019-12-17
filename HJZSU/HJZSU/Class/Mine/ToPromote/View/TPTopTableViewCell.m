//
//  TPTopTableViewCell.m
//  HJZSU
//
//  Created by apple on 2019/3/15.
//  Copyright © 2019 apple. All rights reserved.
//

#import "TPTopTableViewCell.h"

@interface TPTopTableViewCell ()


@property (strong,nonatomic) UIImageView *bgImage;
@property (strong,nonatomic) UIImageView *qrCode;
@property (strong,nonatomic) UILabel *invitedCode;
@property (strong,nonatomic) UILabel *tip;
@property (strong,nonatomic) UILabel *shareTip;
@property (strong,nonatomic) UILabel *myintivited;

@end

@implementation TPTopTableViewCell

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
        
        self.invitedCode = [LabelCreat creatLabelWith:[NSString stringWithFormat:@"邀请码：%@",[[YYCacheManager shareYYCacheManager] getSaveInfo:LOGIN][@"code"]] font:[UIFont boldSystemFontOfSize:15] color:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter];
        self.tip = [LabelCreat creatLabelWith:!IsNullString([[YYCacheManager shareYYCacheManager] getSaveInfo:SYSTEMCONFIG][@"invite_user"]) ? [[YYCacheManager shareYYCacheManager] getSaveInfo:SYSTEMCONFIG][@"invite_user"] : @"" font:[UIFont boldSystemFontOfSize:12] color:[UIColor blackColor] textAlignment:NSTextAlignmentCenter];
        self.tip.numberOfLines = 0;
        self.shareTip = [LabelCreat creatLabelWith:@"分享到" font:[UIFont boldSystemFontOfSize:12] color:[UIColor blackColor] textAlignment:NSTextAlignmentCenter];
        self.myintivited = [LabelCreat creatLabelWith:@"我要约的好友" font:[UIFont boldSystemFontOfSize:15] color:[UIColor blackColor] textAlignment:NSTextAlignmentLeft];
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = UIColorMake(239, 239, 239);
        
        [self addSubview:self.bgImage];
        [self addSubview:self.qrCode];
        [self addSubview:self.invitedCode];
        [self addSubview:self.tip];
        [self addSubview:self.shareTip];
        [self addSubview:line];
        [self addSubview:self.myintivited];
        
        [_bgImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self).offset(0);
            make.height.offset(SCREEN_WIDTH * 601/750.0);
        }];
        
        [_qrCode mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(SCREEN_WIDTH * 601/750.0/2 - 75);
            make.left.equalTo(self).offset(SCREEN_WIDTH/2 - 75);
            make.height.width.offset(150);
        }];
        
        [_invitedCode mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.qrCode.mas_bottom).offset(10);
            make.left.right.equalTo(self).offset(0);
        }];
        
        [_tip mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.bgImage.mas_bottom).offset(0);
            make.left.equalTo(self).offset(35);
            make.right.equalTo(self).offset(-35);
        }];
        
        [_shareTip mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.tip.mas_bottom).offset(32);
            make.left.right.equalTo(self).offset(0);
        }];
        
        for (int i = 0; i < 3; i ++) {
            QMUIButton *button = [[QMUIButton alloc] init];
            [button setImage:[UIImage imageNamed:@[@"分享-qq",@"分享-微信",@"分享-朋友圈"][i]] forState:UIControlStateNormal];
            [button setTitle:@[@"QQ",@"微信",@"朋友圈"][i] forState:UIControlStateNormal];
            [button setTitleColor:UIColorMake(34, 34, 34) forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:12];
            button.tag = 900 + i;
            [button addTarget:self action:@selector(shareButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
            button.spacingBetweenImageAndTitle = 10;
            button.imagePosition = QMUIButtonImagePositionTop;
            [self addSubview:button];
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.shareTip.mas_bottom).offset(32);
                make.left.equalTo(self).offset(35 + (SCREEN_WIDTH - 70)/3 * i);
                make.width.offset((SCREEN_WIDTH - 70)/3);
            }];
        }
        
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.shareTip).offset(32 + 55 + 30);
            make.left.right.equalTo(self).offset(0);
            make.height.offset(10);
        }];
        
        [_myintivited mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(line.mas_bottom).offset(0);
            make.left.equalTo(self).offset(13);
            make.right.equalTo(self).offset(-13);
            make.height.offset(50);
            make.bottom.equalTo(self).offset(0);
        }];
        
        UIView *line1 = [[UIView alloc] init];
        line1.backgroundColor = UIColorMake(239, 239, 239);
        [self addSubview:line1];
        [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self).offset(0);
            make.left.equalTo(self).offset(0);
            make.right.equalTo(self).offset(0);
            make.height.offset(1);
        }];
        
    }
    return self;
}

- (UIImageView *)bgImage{
    if (!_bgImage) {
        _bgImage = [[UIImageView alloc] init];
        _bgImage.contentMode = UIViewContentModeScaleAspectFit;
        _bgImage.image = [UIImage imageNamed:@"邀请好友底图"];
    }
    return _bgImage;
}

- (UIImageView *)qrCode{
    if (!_qrCode) {
        _qrCode = [[UIImageView alloc] init];
        _qrCode.backgroundColor = [UIColor whiteColor];
        _qrCode.layer.cornerRadius = 5;
        _qrCode.clipsToBounds = YES;
        _qrCode.image = [UIImage createQRCodeWithData:[NSString stringWithFormat:@"https://api.hjiaozs.com/about/index_user.html?code=%@",[[YYCacheManager shareYYCacheManager] getSaveInfo:LOGIN][@"code"]] logoImage:UIImageMake(@"Logo") imageSize:100.0];
    }
    return _qrCode;
}

- (void)shareButtonPressed:(UIButton *)sender{
    if (sender.tag == 900) {
        [[QQTool shareQQTool] shareToQQWithImage:@"" webPage:[NSString stringWithFormat:@"https://api.hjiaozs.com/about/index_user.html?code=%@",[[YYCacheManager shareYYCacheManager] getSaveInfo:LOGIN][@"code"]] title:@"呼叫战神" description:@"人人都有生意做，人人生意都好做！" withType:1];
    }
    else if (sender.tag == 901){
        [WeChatTool shareToWechatWith:@"呼叫战神" description:@"人人都有生意做，人人生意都好做！" thumImageUrl:@"Logo" webPageUrl:[NSString stringWithFormat:@"https://api.hjiaozs.com/about/index_user.html?code=%@",[[YYCacheManager shareYYCacheManager] getSaveInfo:LOGIN][@"code"]] scene:WXSceneTypeSession];
    }
    else if (sender.tag == 902){
        [WeChatTool shareToWechatWith:@"呼叫战神" description:@"人人都有生意做，人人生意都好做！" thumImageUrl:@"Logo" webPageUrl:[NSString stringWithFormat:@"https://api.hjiaozs.com/about/index_user.html?code=%@",[[YYCacheManager shareYYCacheManager] getSaveInfo:LOGIN][@"code"]] scene:WXSceneTypeTimeline];
    }
}

@end
