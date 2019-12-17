//
//  STNTableViewCell.m
//  HJZSU
//
//  Created by apple on 2019/3/11.
//  Copyright © 2019 apple. All rights reserved.
//

#import "STNTableViewCell.h"

@interface STNTableViewCell ()

@property (strong,nonatomic) UILabel *titleLab;
@property (strong,nonatomic) CHYTextField *input;
@property (strong,nonatomic) UIImageView *next;
@property (strong,nonatomic) UIButton *question;
@property (strong,nonatomic) UILabel *tip;

@end

@implementation STNTableViewCell

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
        self.titleLab = [LabelCreat creatLabelWith:@"标题" font:[UIFont systemFontOfSize:14] color:UIColorMake(51, 51, 51) textAlignment:NSTextAlignmentLeft];
        self.tip = [LabelCreat creatLabelWith:@"税额 统一：0.0" font:[UIFont systemFontOfSize:14] color:UIColorMake(137, 137, 137) textAlignment:NSTextAlignmentCenter];
        [self addSubview:self.titleLab];
        [self addSubview:self.tip];
        [self addSubview:self.question];
        [self addSubview:self.input];
        [self addSubview:self.next];
        
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self).offset(0);
            make.left.equalTo(self).offset(13);
            make.height.offset(50);
        }];
        
        [_question mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self).offset(0);
            make.left.equalTo(self.titleLab.mas_right).offset(0);
            make.width.offset(50);
        }];
        
        [_tip mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self).offset(0);
            make.left.equalTo(self).offset(100);
            make.right.equalTo(self).offset(-100);
        }];
        
        [_next mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self).offset(0);
            make.right.equalTo(self).offset(-13);
            make.width.offset(7.5);
        }];
        
        [_input mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(5);
            make.bottom.equalTo(self).offset(-5);
            make.right.equalTo(self.next.mas_left).offset(-10);
            make.width.offset(SCREEN_WIDTH * 0.5);
        }];
        
        UIView *lien = [[UIView alloc] init];
        lien.backgroundColor = UIColorMake(239, 239, 239);
        [self addSubview:lien];
        [lien mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-13);
            make.bottom.equalTo(self).offset(0);
            make.left.equalTo(self).offset(13);
            make.height.offset(1);
        }];
        
    }
    return self;
}

- (CHYTextField *)input{
    if (!_input) {
        _input = [[CHYTextField alloc] init];
        _input.placeholder = @"";
        _input.font = [UIFont systemFontOfSize:14];
        _input.textColor = UIColorMake(137, 137, 137);
        _input.layer.borderWidth = 0.0;
        _input.layer.borderColor = UIColorMake(255, 80, 0).CGColor;
        _input.textAlignment = NSTextAlignmentRight;
        _input.userInteractionEnabled = NO;
    }
    return _input;
}

- (UIImageView *)next{
    if (!_next) {
        _next = [[UIImageView alloc] init];
        _next.image = [UIImage imageNamed:@"箭头-向右"];
        _next.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _next;
}

- (UIButton *)question{
    if (!_question) {
        _question = [[UIButton alloc] init];
        [_question setImage:[UIImage imageNamed:@"安全砝码"] forState:UIControlStateNormal];
        _question.imageView.contentMode = UIViewContentModeScaleAspectFit;
        _question.imageEdgeInsets = UIEdgeInsetsMake(17.5, 17.5, 17.5, 17.5);
    }
    return _question;
}


- (void)setType:(NSInteger)type{
    _type = type;
    if (_type == 1) {
        _tip.hidden = YES;
        _titleLab.text = @"安全砝码";
        _input.text = @" ";
        _question.hidden = NO;
        [_next mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.offset(7.5);
        }];
    }
    else{
        _tip.hidden = NO;
        _titleLab.text = @"总金额";
        _question.hidden = YES;
        [_next mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.offset(0);
        }];
    }
}

- (void)setModel:(SubmitModel *)model{
    _model = model;
    if (_model) {
        _input.text = @"";
        if (_type == 1) {
            if (_model.safe) {
                _input.text = _model.safe.name;
            }
            else{
                _input.text = @"无";
            }
        }
        else{
            
            CGFloat allmoney = _model.allMoneny - ((_model.safe ? _model.safe.buy_money : 0) - (_model.vocherModel ? _model.vocherModel.worth_money/100 : 0));
            self.tip.text = [NSString stringWithFormat:@"税额 统一：%.2f",allmoney * [YYCacheManager shareYYCacheManager].saleFloat];
            _input.text = [NSString stringWithFormat:@"%.2f元",_model.allMoneny + allmoney * [YYCacheManager shareYYCacheManager].saleFloat];
            
        }
    }
}


@end
