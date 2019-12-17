//
//  CListTableViewCell.m
//  HJZSU
//
//  Created by apple on 2019/3/12.
//  Copyright © 2019 apple. All rights reserved.
//

#import "CListTableViewCell.h"
#import "CommView.h"

@interface CListTableViewCell ()<CommViewDelegate>

@property (strong,nonatomic) CommView *commentContentView;

@end

@implementation CListTableViewCell

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
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.commentContentView];
        [_commentContentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self).offset(0);
        }];
        
    }
    return self;
}

- (CommView *)commentContentView{
    if (!_commentContentView) {
        _commentContentView = [[CommView alloc] init];
        _commentContentView.delegate = self;
    }
    return _commentContentView;
}

- (void)relpayCotentReload:(PRComment *)model{
    if (!model) {
        return;
    }
    [_commentContentView uploadReplyModel:model];
}
- (void)replyButtonPressedWith:(id)model andType:(NSInteger)index{
    [self listDelegateComm:model andType:index];
}

- (void)listDelegateComm:(id)model andType:(NSInteger)index{
    if (_delegate) {
        [_delegate listDelegateComm:model andType:index];
    }
}

@end
