//
//  LXTravelCategory.h
//  氢气球旅行
//
//  Created by 曾令轩 on 15/12/28.
//  Copyright © 2015年 曾令轩. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LXTravelCategory : NSObject
// 游记类型id
@property (nonatomic, strong) NSNumber *ID;
// 游记类型
@property (nonatomic, copy) NSString *name;
// 游记类型（是否自定义）
@property (nonatomic, copy) NSString *category_type;
@end
