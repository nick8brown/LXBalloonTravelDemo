//
//  LXTravelUser.h
//  氢气球旅行
//
//  Created by 曾令轩 on 15/12/28.
//  Copyright © 2015年 曾令轩. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LXTravelUser : NSObject
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
@end
