//
//  LXActivityAnnotationView.m
//  氢气球旅行
//
//  Created by 曾令轩 on 16/1/11.
//  Copyright © 2016年 曾令轩. All rights reserved.
//

#import "LXActivityAnnotationView.h"
#import "LXActivityView.h"
#import "LXActivityAnnotation.h"

@interface LXActivityAnnotationView ()
@property (nonatomic, strong) LXActivityView *activityView;
@end

@implementation LXActivityAnnotationView

+ (instancetype)annotationViewWithMapView:(MKMapView *)mapView {
    return [[[self class] alloc] initWithMapView:mapView];
}

- (instancetype)initWithMapView:(MKMapView *)mapView {
    LXActivityAnnotationView *annotationView = (LXActivityAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:ActivityAnnotationView_ID];
    if (annotationView == nil) {
        annotationView = [[LXActivityAnnotationView alloc] initWithAnnotation:nil reuseIdentifier:ActivityAnnotationView_ID];
    }
    return annotationView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        LXActivityView *activityView = [LXActivityView view];
        [self addSubview:activityView];
        self.activityView = activityView;
        self.frame = activityView.bounds;
    }
    return self;
}

- (void)setAnnotation:(id<MKAnnotation>)annotation {
    [super setAnnotation:annotation];
    if (annotation) {
        LXActivityAnnotation *activityAnnotation = annotation;
        self.activityView.activity = activityAnnotation.activity;
    }
}

@end
