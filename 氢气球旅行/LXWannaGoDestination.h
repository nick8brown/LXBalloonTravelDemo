//
//  LXWannaGoDestination.h
//  氢气球旅行
//
//  Created by 曾令轩 on 16/1/3.
//  Copyright © 2016年 曾令轩. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LXWannaGoDestination : NSObject
// 攻略id
@property (nonatomic, strong) NSNumber *ID;
// 旅行灵感
@property (nonatomic, strong) NSNumber *inspiration_activities_count;
// 封面
@property (nonatomic, copy) NSString *photo_url;
// 目的地
@property (nonatomic, copy) NSString *name;
@end
