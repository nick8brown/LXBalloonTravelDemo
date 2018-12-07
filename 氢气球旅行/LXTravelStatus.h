//
//  LXTravelStatus.h
//  氢气球旅行
//
//  Created by 曾令轩 on 15/12/28.
//  Copyright © 2015年 曾令轩. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LXTravelRecommendUser, LXTravelActivity;

@interface LXTravelStatus : NSObject
// 动态类型（是否为推荐）
@property (nonatomic, copy) NSString *event_type;
// 推荐用户
@property (nonatomic, strong) LXTravelRecommendUser *user;
// 游记
@property (nonatomic, strong) LXTravelActivity *activity;
@end
