//
//  LXActivityAnnotation.h
//  氢气球旅行
//
//  Created by 曾令轩 on 16/1/11.
//  Copyright © 2016年 曾令轩. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@class LXTravelActivity;

@interface LXActivityAnnotation : NSObject <MKAnnotation>
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, strong) LXTravelActivity *activity;
@end
