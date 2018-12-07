//
//  LXWannaGoPage.h
//  氢气球旅行
//
//  Created by 曾令轩 on 16/1/3.
//  Copyright © 2016年 曾令轩. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LXWannaGoHitted_destination;

@interface LXWannaGoPage : NSObject
@property (nonatomic, strong) NSArray *destinations;
@property (nonatomic, strong) NSArray *user_activities;
@property (nonatomic, strong) NSArray *users;
@property (nonatomic, strong) LXWannaGoHitted_destination *hitted_destination;
@end
