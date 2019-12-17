//
//  TeamListModel.h
//  HJZSU
//
//  Created by apple on 2019/3/25.
//  Copyright © 2019 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TeamListModel : NSObject

- (void)uploadWith:(NSDictionary *)info;

- (void)uploadWithCollection:(NSDictionary *)info;

@property (assign,nonatomic) NSInteger id;
@property (strong,nonatomic) NSString *logo;
@property (strong,nonatomic) NSString *name;
@property (assign,nonatomic) NSInteger start;
@property (assign,nonatomic) BOOL isSelected;

/**/

@end

NS_ASSUME_NONNULL_END
