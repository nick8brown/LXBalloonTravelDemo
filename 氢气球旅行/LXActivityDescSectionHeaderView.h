//
//  LXActivityDescSectionHeaderView.h
//  氢气球旅行
//
//  Created by 曾令轩 on 16/1/11.
//  Copyright © 2016年 曾令轩. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LXTravelActivity;

@interface LXActivityDescSectionHeaderView : UIView
@property (nonatomic, strong) LXTravelActivity *activity;

+ (instancetype)view;
@end
