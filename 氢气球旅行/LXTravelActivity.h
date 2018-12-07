//
//  LXTravelActivity.h
//  氢气球旅行
//
//  Created by 曾令轩 on 15/12/27.
//  Copyright © 2015年 曾令轩. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LXTravelContent, LXTravelDistrict, LXTravelCategory, LXTravelUser, LXTravelPoi;

@interface LXTravelActivity : NSObject
// 游记id
@property (nonatomic, strong) NSNumber *ID;
// 旅行时间
@property (nonatomic, copy) NSString *made_at;
// 点赞数
@property (nonatomic, strong) NSNumber *likes_count;
// 评论数
@property (nonatomic, strong) NSNumber *comments_count;
// 主题
@property (nonatomic, copy) NSString *topic;
// 附图数
@property (nonatomic, strong) NSNumber *contents_count;
// 旅行地点标签id
@property (nonatomic, strong) NSNumber *district_id;
// 游记发布时间
@property (nonatomic, copy) NSString *created_at;
// 收藏数
@property (nonatomic, strong) NSNumber *favorites_count;
// 描述
@property (nonatomic, copy) NSString *desc;
// 附图
@property (nonatomic, strong) NSArray *contents;
// 旅行地点标签
@property (nonatomic, strong) NSArray *districts;
// 游记类型
@property (nonatomic, strong) NSArray *categories;
// 发布用户
@property (nonatomic, strong) LXTravelUser *user;
//// 相关攻略网页
//@property (nonatomic, strong) LXTravelPoi *poi;
@end
