//
//  TeamShowTableViewCell.m
//  HJZSU
//
//  Created by apple on 2019/3/13.
//  Copyright © 2019 apple. All rights reserved.
//

#import "TeamShowTableViewCell.h"
#import "TSCollectionViewCell.h"

@interface TeamShowTableViewCell ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (strong,nonatomic) UIImageView *iconImage;
@property (strong,nonatomic) UILabel *tip;
@property (strong,nonatomic) FormatLabel *contentLab;
@property (strong,nonatomic) UICollectionView *collectionView;
@property (strong,nonatomic) QMUICollectionViewPagingLayout *collectionViewLayout;
@property (strong,nonatomic) NSArray *images;


@end

@implementation TeamShowTableViewCell

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
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 13)];
        line.backgroundColor = UIColorMake(239, 239, 239);
        [self addSubview:line];
        
        
        self.tip = [LabelCreat creatLabelWith:@"团队风采" font:[UIFont systemFontOfSize:15] color:UIColorMake(34, 34, 34) textAlignment:NSTextAlignmentLeft];
        [self addSubview:self.iconImage];
        [self addSubview:self.tip];
        [self addSubview:self.collectionView];
        [self addSubview:self.contentLab];
        
        [_iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(10);
            make.left.equalTo(self).offset(13);
            make.height.offset(50);
            make.width.offset(7.5);
        }];
        
        [_tip mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(10);
            make.left.equalTo(self.iconImage.mas_right).offset(10);
            make.right.equalTo(self).offset(-13);
            make.height.offset(50);
        }];
        
        [_contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.collectionView.mas_bottom).offset(18);
            make.left.equalTo(self).offset(13);
            make.right.equalTo(self).offset(-13);
            make.bottom.equalTo(self).offset(-13);
        }];
        
        
    }
    return self;
}

- (UIImageView *)iconImage{
    if (!_iconImage) {
        _iconImage = [[UIImageView alloc] init];
        _iconImage.contentMode = UIViewContentModeScaleAspectFit;
        _iconImage.image = [UIImage imageNamed:@"装饰"];
    }
    return _iconImage;
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(13, 60, SCREEN_WIDTH - 26, 180) collectionViewLayout:self.collectionViewLayout];
        self.collectionView.backgroundColor = UIColorClear;
        self.collectionView.showsHorizontalScrollIndicator = NO;
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        [self.collectionView registerClass:[TSCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([TSCollectionViewCell class])];
    }
    return _collectionView;
}

- (QMUICollectionViewPagingLayout *)collectionViewLayout{
    if (!_collectionViewLayout) {
        _collectionViewLayout = [[QMUICollectionViewPagingLayout alloc] initWithStyle:QMUICollectionViewPagingLayoutStyleDefault];
        _collectionViewLayout.pagingThreshold = 13;
        _collectionViewLayout.itemSize = CGSizeMake(300, 180);
    }
    return _collectionViewLayout;
}

- (FormatLabel *)contentLab{
    if (!_contentLab) {
        _contentLab = [[FormatLabel alloc] init];
        _contentLab.lineSpcae = 5;
        _contentLab.wordSpace = 1.5;
        _contentLab.textColor = UIColorMake(137, 137, 137);
        _contentLab.font = [UIFont systemFontOfSize:14];
        _contentLab.numberOfLines = 0;
        _contentLab.text = @"文字描述...文字描述...文字描述...文字描述...文字描述...文字描述...文字描述...文字描述...文字描述...文字描述...文字描述...文字描述...文字描述...文字描述...文字描述...文字描述...文字描述...文字描述...文字描述...";
    }
    return _contentLab;
}

#pragma mark - <UICollectionViewDelegate, UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.images ? self.images.count : 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TSCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([TSCollectionViewCell class]) forIndexPath:indexPath];
    cell.iamgeURL = self.images ? self.images[indexPath.row] : nil;
    return cell;
}

- (void)setInfo:(NSDictionary *)info{
    _info = info;
    if (_info) {
        if (self.type == 1) {
            _contentLab.text = _info[@"teamImageComment"];
            self.images = [_info[@"teamImages"] componentsSeparatedByString:@";"];
            [self.collectionView reloadData];
        }
        else if (self.type == 2){
            _contentLab.text = _info[@"activityImageComment"];
            self.images = [_info[@"activityImage"] componentsSeparatedByString:@";"];
            [self.collectionView reloadData];
        }
    }
}


@end
