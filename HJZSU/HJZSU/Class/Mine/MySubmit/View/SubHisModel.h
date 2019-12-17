//
//  SubHisModel.h
//  HJZSU
//
//  Created by apple on 2019/3/31.
//  Copyright © 2019 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SubHisModel : NSObject

@property (strong,nonatomic) NSString *address;
@property (strong,nonatomic) NSString *start_time;
@property (strong,nonatomic) NSString *downTime;
@property (strong,nonatomic) NSString *end_time;
@property (assign,nonatomic) NSInteger id;
@property (strong,nonatomic) NSString *images;
@property (strong,nonatomic) NSString *orderNo;
@property (strong,nonatomic) NSString *name;
@property (assign,nonatomic) NSInteger score;
@property (strong,nonatomic) NSString *typeNname;
/*address = "\U4e0d\U80fd\U8ba9\U81ea\U5df1\U53d8\U5f97\U8d8a\U6765\U8d8a\U4f18\U79c0\Uff1f\U6211\U7684";
 downTime = 1561023780000;
 "end_time" = 1561023780000;
 id = 273;
 images = "https://hjzsmy.oss-cn-shanghai.aliyuncs.com/activity/1561038243106970212019-06-2013%3A44%3A02%2B0000315.jpg;";
 name = "\U5957\U9910A";
 orderNo = 20190620507774821;
 score = 5;
 "start_time" = 1561023780000;
 typeNname = "\U5355\U5e97";*/

@end

NS_ASSUME_NONNULL_END
