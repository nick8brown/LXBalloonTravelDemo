//
//  LXActivityAnnotationView.h
//  氢气球旅行
//
//  Created by 曾令轩 on 16/1/11.
//  Copyright © 2016年 曾令轩. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface LXActivityAnnotationView : MKAnnotationView
+ (instancetype)annotationViewWithMapView:(MKMapView *)mapView;
- (instancetype)initWithMapView:(MKMapView *)mapView;
@end
