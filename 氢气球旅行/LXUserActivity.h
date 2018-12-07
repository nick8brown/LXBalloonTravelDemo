//
//  LXUserActivity.h
//  氢气球旅行
//
//  Created by 曾令轩 on 16/1/8.
//  Copyright © 2016年 曾令轩. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LXLocationDistrict;

@interface LXUserActivity : NSObject
// 地理位置信息
@property (nonatomic, strong) LXLocationDistrict *district;
// 游记
@property (nonatomic, strong) NSArray *activities;
@end
