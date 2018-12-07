//
//  LXLocationDistrict.h
//  氢气球旅行
//
//  Created by 曾令轩 on 16/1/8.
//  Copyright © 2016年 曾令轩. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

@interface LXLocationDistrict : NSObject
// 地理位置信息id
@property (nonatomic, strong) NSNumber *ID;
// 中文名
@property (nonatomic, copy) NSString *name;
// 英文名
@property (nonatomic, copy) NSString *name_en;
// 纬度
@property (nonatomic, assign) CGFloat lat;
// 经度
@property (nonatomic, assign) CGFloat lng;
// 期间（时间）
@property (nonatomic, copy) NSString *during;
@end
