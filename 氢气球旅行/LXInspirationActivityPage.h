//
//  LXInspirationActivityPage.h
//  氢气球旅行
//
//  Created by 曾令轩 on 16/1/5.
//  Copyright © 2016年 曾令轩. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LXInspirationActivityPage : NSObject
// 旅行灵感页id
@property (nonatomic, strong) NSNumber *ID;
// 描述
@property (nonatomic, copy) NSString *desc;
// 主题
@property (nonatomic, copy) NSString *topic;
// 旅行灵感数
@property (nonatomic, strong) NSNumber *inspiration_activities_count;
// 旅行灵感
@property (nonatomic, strong) NSArray *inspirations;
@end
