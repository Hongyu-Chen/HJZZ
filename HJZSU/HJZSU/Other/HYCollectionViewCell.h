//
//  HYCollectionViewCell.h
//  youyijia
//
//  Created by apple on 2017/6/30.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HYCollectionViewCell : UICollectionViewCell

@property (strong,nonatomic) NSString *imageUrl;
@property (strong,nonatomic) NSString *locationImageName;
@property (assign,nonatomic) BOOL showImageTitle;
@property (strong,nonatomic) NSString *titleString;


@end
