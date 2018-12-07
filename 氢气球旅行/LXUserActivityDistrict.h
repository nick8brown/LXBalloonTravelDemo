//
//  LXUserActivityDistrict.h
//  氢气球旅行
//
//  Created by 曾令轩 on 16/1/8.
//  Copyright © 2016年 曾令轩. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

@interface LXUserActivityDistrict : NSObject
// 旅行地点标签id
@property (nonatomic, strong) NSNumber *ID;
// 旅行地点标签
@property (nonatomic, copy) NSString *name;
// 纬度
@property (nonatomic, assign) CGFloat lat;
// 经度
@property (nonatomic, assign) CGFloat lng;
@end
