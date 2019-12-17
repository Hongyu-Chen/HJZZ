//
//  SCPhotoView.m
//  CareView
//
//  Created by pro1 on 2019/3/16.
//  Copyright © 2019 pro1. All rights reserved.
//

#import "SCPhotoView.h"
#import "SCPhotoFlowLayout.h"
#import "SCPhotoCell.h"
#import "SCPhotoModel.h"
#import <Masonry/Masonry.h>
#import "SDPhotoBrowser/SDPhotoBrowser.h"

@interface SCPhotoView ()<UICollectionViewDelegate,UICollectionViewDataSource,SCPhotoCellDelegate,SDPhotoBrowserDelegate>
@property (strong,nonatomic) UICollectionView *collection;
@property (strong,nonatomic) NSMutableArray *collectioData;


@end

@implementation SCPhotoView

- (instancetype)initWithSCPhotoViewStyle:(SCPhotoViewStyle)style{
    self = [super init];
    if (self) {
        self.style = style;
        self.itemMargin = 10.0;
        self.contentWidth = ([UIScreen mainScreen].bounds.size.width - 26);
        CGFloat width = ([UIScreen mainScreen].bounds.size.width - 26 - self.itemMargin * 3)/4;
        self.itemSize = CGSizeMake(width, width);
        self.addItemValue = @"上传图片框";
        self.deleteBtnValue = @"删除图片";
        [self addSubview:self.collection];
    }
    return self;
}

- (UICollectionView *)collection{
    if (!_collection) {
        _collection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 50) collectionViewLayout:[self creatLayout]];
        _collection.backgroundColor = [UIColor whiteColor];
        _collection.delegate = self;
        _collection.dataSource = self;
        [_collection registerClass:[SCPhotoCell class] forCellWithReuseIdentifier:NSStringFromClass([SCPhotoCell class])];
    }
    return _collection;
}

- (void)setPhotos:(NSMutableArray *)photos{
    _photos = photos;
    if (self.collectioData) {
        [self.collectioData removeAllObjects];
    }
    else{
        self.collectioData = [[NSMutableArray alloc] init];
    }
    switch (self.style) {
        case SCPhotoViewStyleShow:
        {
            for (id value in _photos) {
                SCPhotoModel *model = [[SCPhotoModel alloc] init];
                if (self.showDelete) {
                    model.style = SCPhtoCellStyleShowAddDelete;
                }
                else{
                    model.style = SCPhtoCellStyleShow;
                }
                model.imageContent = value;
                model.deleteContent = self.deleteBtnValue;
                [self.collectioData addObject:model];
            }
        }
            break;
        case SCPhotoViewStyleAddInLast:
        {
            for (id value in _photos) {
                SCPhotoModel *model = [[SCPhotoModel alloc] init];
                model.style = SCPhtoCellStyleShowAddDelete;
                model.imageContent = value;
                model.deleteContent = self.deleteBtnValue;
                [self.collectioData addObject:model];
            }
            
            SCPhotoModel *model = [[SCPhotoModel alloc] init];
            model.style = SCPhtoCellStyleAdd;
            model.imageContent = self.addItemValue;
            [self.collectioData addObject:model];
        }
            break;
        case SCPhotoViewStyleAddInFirst:
        {
            for (id value in _photos) {
                SCPhotoModel *model = [[SCPhotoModel alloc] init];
                model.style = SCPhtoCellStyleShowAddDelete;
                model.imageContent = value;
                model.deleteContent = self.deleteBtnValue;
                [self.collectioData addObject:model];
            }
            SCPhotoModel *model = [[SCPhotoModel alloc] init];
            model.style = SCPhtoCellStyleAdd;
            model.imageContent = self.addItemValue;
            [self.collectioData insertObject:model atIndex:0];
        }
            break;
            
        default:
            break;
    }
    [self CalculateHeight];
    [self.collection reloadData];
}

- (void)setItemSize:(CGSize)itemSize{
    _itemSize = itemSize;
    if (_collection) {
        [_collection setCollectionViewLayout:[self creatLayout] animated:NO];
    }
}

- (void)setContentWidth:(CGFloat)contentWidth{
    _contentWidth = contentWidth;
    if (_collection) {
        [self CalculateHeight];
        [_collection reloadData];
    }
}

- (void)setItemMargin:(CGFloat)itemMargin{
    _itemMargin = itemMargin;
    if (_collection) {
        [_collection setCollectionViewLayout:[self creatLayout] animated:NO];
    }
}

- (void)CalculateHeight{
    NSInteger hNumber = (NSInteger)self.contentWidth/(NSInteger)self.itemSize.width;
    NSInteger vNumber = self.collectioData.count%hNumber == 0 ? self.collectioData.count/hNumber : self.collectioData.count/hNumber + 1;
    CGFloat height = (vNumber - 1) * self.itemMargin + vNumber * self.itemSize.height;
    self.collection.frame = CGRectMake(0, 0, self.contentWidth, height);
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.offset(height);
    }];
}

- (SCPhotoFlowLayout *)creatLayout{
    SCPhotoFlowLayout *layout = [[SCPhotoFlowLayout alloc] init];
    layout.itemSize = self.itemSize;
    layout.minimumLineSpacing = self.itemMargin;
    layout.minimumInteritemSpacing = self.itemMargin;
    return layout;
}

#pragma mark - <UICollectionViewDelegate,UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.collectioData.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SCPhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([SCPhotoCell class]) forIndexPath:indexPath];
    cell.delegate = self;
    cell.model = self.collectioData ? self.collectioData[indexPath.row] : nil;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    SCPhotoModel *model = self.collectioData[indexPath.row];
    if (model.style == SCPhtoCellStyleAdd) {
        [self userPressedAddImage];
    }
    else if(model.style == SCPhtoCellStyleShow){
        if (self.showDelete) {
            return;
        }
        if (self.showPreviewPicture) {
            [self showPhotoBrowseWith:indexPath];
        }
    }
    else if(model.style == SCPhtoCellStyleShowAddDelete){
        
    }
}

- (void)showPhotoBrowseWith:(NSIndexPath *)indexPath{
    SDPhotoBrowser *photoBrowser = [SDPhotoBrowser new];
    photoBrowser.delegate = self;
    photoBrowser.currentImageIndex = indexPath.item;
    photoBrowser.imageCount = self.photos.count;
    photoBrowser.sourceImagesContainerView = self.collection;
    [photoBrowser show];
}

#pragma mark - <CellDelegate>

- (void)cellDeleteButtonPressed:(SCPhotoModel *)model{
    if (self.style == SCPhotoViewStyleAddInFirst) {
        [self userDeleteItem:[self.collectioData indexOfObject:model] - 1];
    }
    else if (self.style == SCPhotoViewStyleAddInLast || self.style == SCPhotoViewStyleShow){
        [self userDeleteItem:[self.collectioData indexOfObject:model]];
    }
}

#pragma mark - <SCPhotoViewDelegate>

- (void)userDeleteItem:(NSInteger)index{
    if (_delegate) {
        [_delegate userDeleteItem:index];
    }
}

- (void)userPressedAddImage{
    if (_delegate) {
        [_delegate userPressedAddImage];
    }
}

#pragma mark - <SDPhotoBrowserDelegate>

#pragma mark  SDPhotoBrowserDelegate

// 返回临时占位图片（即原来的小图）
- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    // 不建议用此种方式获取小图，这里只是为了简单实现展示而已
    SCPhotoModel *model = self.collectioData[index];
    NSURL *url = model.imageContent;
    return model ? [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:url.absoluteString] : nil;
    
}


// 返回高质量图片的url
- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
{
    SCPhotoModel *model = self.collectioData[index];
    return model ? model.imageContent : nil;
}






@end
