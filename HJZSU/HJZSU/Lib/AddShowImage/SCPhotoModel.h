//
//  SCPhotoModel.h
//  CareView
//
//  Created by pro1 on 2019/3/16.
//  Copyright © 2019 pro1. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,SCPhtoCellStyle) {
    SCPhtoCellStyleAdd = 0,
    SCPhtoCellStyleShow,
    SCPhtoCellStyleShowAddDelete,
};

NS_ASSUME_NONNULL_BEGIN

@interface SCPhotoModel : NSObject

@property (assign,nonatomic) SCPhtoCellStyle style;
@property (strong,nonatomic) id imageContent;
@property (strong,nonatomic) id deleteContent;


@end

NS_ASSUME_NONNULL_END
