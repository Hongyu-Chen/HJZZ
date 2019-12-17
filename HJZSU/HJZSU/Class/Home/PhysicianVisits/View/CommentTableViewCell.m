//
//  CommentTableViewCell.m
//  HJZSU
//
//  Created by apple on 2019/3/12.
//  Copyright © 2019 apple. All rights reserved.
//

#import "CommentTableViewCell.h"
#import "CommView.h"
#import "CommListView.h"

@interface CommentTableViewCell ()<CommViewDelegate,CommListViewDelegate>

@property (strong,nonatomic) CommView *commentContentView;
@property (strong,nonatomic) CommListView *listView;
@property (strong,nonatomic) PhyRecomModel *model;



@end

@implementation CommentTableViewCell

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
        [self addSubview:self.commentContentView];
        [_commentContentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self).offset(0);
        }];
        
        [self addSubview:self.listView];
        [_listView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.commentContentView.mas_bottom).offset(0);
            make.left.equalTo(self).offset(66);
            make.right.equalTo(self).offset(-13);
            make.height.offset(0);
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

- (CommListView *)listView{
    if (!_listView) {
        _listView = [[CommListView alloc] init];
        _listView.delegate = self;
    }
    return _listView;
}

- (void)uploadCellValueWith:(PhyRecomModel *)model{
    if (!model) {
        return;
    }
    self.model = model;
    [_listView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.offset((model.reply && model.reply.count > 0) ? model.cellHeight - 157 : 0);
    }];
    [_commentContentView uploadRecommModel:model];
    _listView.listData = model.reply;
    
}

- (void)replyButtonPressedWith:(id)model andType:(NSInteger)index{
    [self replyCommBtnPressed:model andTYpe:index];
}

- (void)listReplyWith:(id)model andType:(NSInteger)index{
    NSMutableDictionary *tmp = [[NSMutableDictionary alloc] init];
    [tmp setObject:self.model.id forKey:@"commId"];
    PRComment *commtent = model;
    [tmp setObject:commtent.id forKey:@"loucommId"];
    [tmp setObject:commtent.fromUid forKey:@"toUid"];
    [self replyCommBtnPressed:tmp andTYpe:index];
}

- (void)replyCommBtnPressed:(id)model andTYpe:(NSInteger)index{
    if (_delegate) {
        [_delegate replyCommBtnPressed:model andTYpe:index];
    }
}



@end
