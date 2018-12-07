//
//  LXWannaGoHitted_destination.h
//  氢气球旅行
//
//  Created by 曾令轩 on 16/1/3.
//  Copyright © 2016年 曾令轩. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LXWannaGoHitted_destination : NSObject
// 被点击目的地id
@property (nonatomic, strong) NSNumber *ID;
// 中文名
@property (nonatomic, copy) NSString *name;
// 英文名
@property (nonatomic, copy) NSString *name_en;
@property (nonatomic, strong) NSNumber *district_id;
@end
