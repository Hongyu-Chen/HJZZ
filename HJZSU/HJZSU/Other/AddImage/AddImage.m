//
//  AddImage.m
//  HJZSU
//
//  Created by apple on 2019/3/9.
//  Copyright © 2019 apple. All rights reserved.
//

#import "AddImage.h"
#import "ShowImage.h"

@interface AddImage ()

@property (strong,nonatomic) NSMutableArray *images;

@end

@implementation AddImage

- (instancetype)init{
    self = [super init];
    if (self) {
        self.maxImage = 9;
        self.showWidth = (SCREEN_WIDTH - 26);
        self.marginH = self.marginV = 10.0;
        self.itemSize = CGSizeMake((self.showWidth - (3 * self.marginH))/4, (self.showWidth - (3 * self.marginH))/4);
        self.showAddItem = YES;
        [self creatShowImageView];
        self.userInteractionEnabled = YES;
    }
    return self;
}

- (void)creatShowImageView{
    NSLog(@"creatShowImageView");
     [self.images removeAllObjects];
    NSInteger count = self.maxImage;
    if (self.showAddItem) {
        count += 1;
    }
    CGFloat orginx = 0;
    CGFloat orginy = 0;
    __weak typeof(self) weakself = self;
    for (int i = 0; i < count; i++) {
        for (ShowImage *imageView in self.images) {
            if (orginx > (self.showWidth - self.itemSize.width)) {
                orginx = 0;
                orginy += (self.marginV + self.itemSize.height);
            }
            imageView.frame = CGRectMake(orginx, orginy, self.itemSize.width, self.itemSize.height);
            orginx += (self.itemSize.width + self.marginH);
        }
        
        
        ShowImage *imageView = [[ShowImage alloc] initWithFrame:CGRectMake(orginx, orginy, self.itemSize.width, self.itemSize.height)];
        imageView.tag = 100 + i;
        imageView.userWantDeleteImageBlock = ^(NSInteger tag,NSInteger type) {
            [weakself deleteImage:tag - 100 andType:type];
        };
        [self addSubview:imageView];
        [self.images addObject:imageView];
    }
}

- (NSMutableArray *)images{
    if (!_images) {
        _images = [[NSMutableArray alloc] init];
    }
    return _images;
}

- (void)deleteImage:(NSInteger)index andType:(NSInteger)type{
    if (type == 0) {
        //删除
        if (self.showAddItem) {
            if (self.addItemIndex) {
                [self userDeleteIndex:index];
            }
            else{
                [self userDeleteIndex:index - 1];
            }
        }
        else{
            [self userDeleteIndex:index];
        }
    }
    else{
        //点击
        if (self.showAddItem) {
            if (self.addItemIndex) {
                [self userTapImage:index];
            }
            else{
                [self userTapImage:index - 1];
            }
        }
        else{
            [self userTapImage:index];
        }
        
//        [self userTapImage:index];
    }
}

- (void)setValueArray:(NSArray *)valueArray{
    _valueArray = valueArray;
    if (_valueArray) {

        for (int i = 0 ; i < self.images.count; i++) {
            if (self.showAddItem) {
                if (self.addItemIndex) {
                    ShowImage *tmp = [self.images objectAtIndex:i];
                    if (i < _valueArray.count) {
                        [tmp hiddenDeleteBtnWith:NO];
                        tmp.hidden = NO;
                        tmp.imageContent = _valueArray[i];
                    }
                    else if (i == _valueArray.count){
                        tmp.hidden = NO;
                        [tmp hiddenDeleteBtnWith:YES];
                        tmp.imageContent = @"上传图片框";
                    }
                    else{
                        [tmp hiddenDeleteBtnWith:NO];
                        tmp.hidden = YES;
                        tmp.image = nil;
                    }
                }
                else{
                    ShowImage *tmp = [self.images objectAtIndex:i];
                    if (i == 0) {
                        tmp.hidden = NO;
                        tmp.imageContent = @"上传图片框";
                        [tmp hiddenDeleteBtnWith:YES];
                    }
                    else if (i <= _valueArray.count) {
                        tmp.hidden = NO;
                        tmp.imageContent = _valueArray[i - 1];
                        [tmp hiddenDeleteBtnWith:NO];
                    }
                    else{
                        [tmp hiddenDeleteBtnWith:NO];
                        tmp.hidden = YES;
                        tmp.image = nil;
                    }
                }
            }
            else{
                ShowImage *tmp = [self.images objectAtIndex:i];
                [tmp hiddenDeleteBtnWith:YES];
                if (i < _valueArray.count) {
                    tmp.hidden = NO;
                    tmp.imageContent = _valueArray[i];
                }
                else{
                    tmp.hidden = YES;
                    tmp.image = nil;
                }
            }
        }
        
        [self uploadImagesFrame];
    }
}

- (void)uploadImagesFrame{
    CGFloat orginx = 0;
    CGFloat orginy = 0;
    for (ShowImage *imageView in self.images) {
        if (orginx > (self.showWidth - self.itemSize.width)) {
            orginx = 0;
            orginy += (self.marginV + self.itemSize.height);
        }
        imageView.frame = CGRectMake(orginx, orginy, self.itemSize.width, self.itemSize.height);
        orginx += (self.itemSize.width + self.marginH);
    }
    ShowImage *tmp = [self.images objectAtIndex:self.showAddItem ? self.valueArray.count : self.valueArray.count - 1];
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.offset(tmp.center.y + tmp.frame.size.height/2);
    }];
}

- (void)userDeleteIndex:(NSInteger)index{
    if (self.delegate) {
        [_delegate userDeleteIndex:index];
    }
}

- (void)userTapImage:(NSInteger)index{
    if (self.delegate) {
        [_delegate userTapImage:index];
    }
}

@end
