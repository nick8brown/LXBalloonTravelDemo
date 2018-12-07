//
//  LXRecommendTourist.h
//  氢气球旅行
//
//  Created by 曾令轩 on 16/1/1.
//  Copyright © 2016年 曾令轩. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LXRecommendTouristActivity;

@interface LXRecommendTourist : NSObject
// 用户id
@property (nonatomic, strong) NSNumber *ID;
// 昵称
@property (nonatomic, copy) NSString *name;
// 性别（男:1,女:0）
@property (nonatomic, strong) NSNumber *gender;
// 等级
@property (nonatomic, strong) NSNumber *level;
// 头像
@property (nonatomic, copy) NSString *photo_url;
// 事迹
@property (nonatomic, strong) LXRecommendTouristActivity *latest_activity;
@end
