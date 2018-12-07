//
//  LXStatusBarView.m
//  氢气球旅行
//
//  Created by 曾令轩 on 15/12/29.
//  Copyright © 2015年 曾令轩. All rights reserved.
//

#import "LXStatusBarView.h"

@implementation LXStatusBarView

static LXStatusBarView *instance;
+(instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [super allocWithZone:zone];
    });
    return instance;
}

+ (instancetype)shareStatusBarView {
    return [[self alloc] initWithFrame:CGRectMake(0, -statusBarH, screen_WIDTH, statusBarH)];
}

@end
