//
//  LXTouristView.h
//  氢气球旅行
//
//  Created by 曾令轩 on 16/1/1.
//  Copyright © 2016年 曾令轩. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LXRecommendTourist, LXRecommendTouristActivity;

@interface LXTouristView : UIView
@property (nonatomic, strong) LXRecommendTourist *tourist;
@property (nonatomic, strong) LXRecommendTouristActivity *activity;
@end
