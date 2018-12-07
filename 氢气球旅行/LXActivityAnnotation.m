//
//  LXActivityAnnotation.m
//  氢气球旅行
//
//  Created by 曾令轩 on 16/1/11.
//  Copyright © 2016年 曾令轩. All rights reserved.
//

#import "LXActivityAnnotation.h"
#import "LXTravelActivity.h"
#import "LXUserActivityDistrict.h"
#import "MJExtension.h"

@implementation LXActivityAnnotation

-(void)setActivity:(LXTravelActivity *)activity {
    _activity = activity;
    LXUserActivityDistrict *district = [[LXUserActivityDistrict objectArrayWithKeyValuesArray:activity.districts] lastObject];
    self.coordinate = CLLocationCoordinate2DMake(district.lat, district.lng);
}

@end
