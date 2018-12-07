//
//  LXInspirationActivity.h
//  氢气球旅行
//
//  Created by 曾令轩 on 16/1/5.
//  Copyright © 2016年 曾令轩. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LXTopicPhoto, LXTravelDistrict;

@interface LXInspirationActivity : NSObject
// 旅行灵感id
@property (nonatomic, strong) NSNumber *ID;
// 心愿单数
@property (nonatomic, strong) NSNumber *wishes_count;
// 游玩贴士
@property (nonatomic, copy) NSString *visit_tip;
// 标题
@property (nonatomic, copy) NSString *topic;
// 介绍
@property (nonatomic, copy) NSString *introduce;
// 游记数
@property (nonatomic, strong) NSNumber *user_activities_count;
// 附图
@property (nonatomic, strong) LXTopicPhoto *photo;
// 旅行地点标签
@property (nonatomic, strong) LXTravelDistrict *district;
@end
