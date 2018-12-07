//
//  LXTopicDestination.h
//  氢气球旅行
//
//  Created by 曾令轩 on 16/1/4.
//  Copyright © 2016年 曾令轩. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LXTopicDestination : NSObject
// 主题攻略id
@property (nonatomic, strong) NSNumber *ID;
// 主题
@property (nonatomic, copy) NSString *topic;
// 描述
@property (nonatomic, copy) NSString *desc;
// 旅行灵感
@property (nonatomic, strong) NSNumber *inspiration_activities_count;
// 封面
@property (nonatomic, copy) NSString *photo_url;
@end
