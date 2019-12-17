//
//  RankModel.h
//  HJZSU
//
//  Created by apple on 2019/3/31.
//  Copyright © 2019 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RankModel : NSObject

/*
 "id": 2,
 "logo": "https://wx.qlogo.cn/mmopen/vi_32/T8ibumiciaicNEUqvdEiaSHGnjy90wgOoBfSD4hrqMzYwwKopIWibB1DZaWBeqLrtr3dKbjzqiaPMDp4sccoQicXpTjjSw/132",
 "name": "无敌战神1"
*/
@property (assign,nonatomic) NSInteger id;
@property (strong,nonatomic) NSString *logo;
@property (strong,nonatomic) NSString *name;

@end

NS_ASSUME_NONNULL_END
