//
//  TeamListModel.m
//  HJZSU
//
//  Created by apple on 2019/3/25.
//  Copyright © 2019 apple. All rights reserved.
//

#import "TeamListModel.h"

@implementation TeamListModel

- (void)uploadWith:(NSDictionary *)info{
    /*"teamLogo": "https://hjzsmy.oss-cn-shanghai.aliyuncs.com/user/155306871700865238wx773a0b78ccb7a009.o6zAJs1S1xCjrzx2QT9G1UUe1-vg.QYBV4jXa4TFgc44e9d44d99b340dff460a7e1e69ac77.png"
     "name": "团队名称",
     "score": 5//评分
     "id": 5//收藏的主键ID
*/
    
    self.id = [info[@"id"] integerValue];
    self.logo = info[@"logo"];
    self.name = info[@"name"];
    self.start = [info[@"score"] integerValue];
}

- (void)uploadWithCollection:(NSDictionary *)info{
    self.id = [info[@"id"] integerValue];
    self.logo = info[@"teamLogo"];
    self.name = info[@"name"];
    self.start = [info[@"score"] integerValue];
}

@end
