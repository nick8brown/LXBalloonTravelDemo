//
//  LXUserProfile.h
//  氢气球旅行
//
//  Created by 曾令轩 on 16/1/8.
//  Copyright © 2016年 曾令轩. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LXUserProfileHeader_photo;

@interface LXUserProfile : NSObject
// 用户id
@property (nonatomic, strong) NSNumber *ID;
// 昵称
@property (nonatomic, copy) NSString *name;
// 性别
@property (nonatomic, strong) NSNumber *gender;
// 等级
@property (nonatomic, strong) NSNumber *level;
// 头像
@property (nonatomic, copy) NSString *photo_url;
// 关注
@property (nonatomic, strong) NSNumber *followings_count;
// 粉丝
@property (nonatomic, strong) NSNumber *followers_count;
// 游记数
@property (nonatomic, strong) NSNumber *user_activities_count;
// 心愿单数
@property (nonatomic, strong) NSNumber *wishes_count;
// 收藏数
@property (nonatomic, strong) NSNumber *favorites_count;
// 封面图
@property (nonatomic, strong) LXUserProfileHeader_photo *header_photo;
@end
