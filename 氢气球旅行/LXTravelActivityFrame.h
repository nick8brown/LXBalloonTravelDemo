//
//  LXTravelActivityFrame.h
//  氢气球旅行
//
//  Created by 曾令轩 on 15/12/28.
//  Copyright © 2015年 曾令轩. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>

@class LXTravelActivity;

@interface LXTravelActivityFrame : NSObject
// 游记
@property (nonatomic, strong) LXTravelActivity *activity;
// 大图
@property (nonatomic, assign, readonly) CGRect contentImgViewFrame;
// 附图
@property (nonatomic, assign, readonly) CGRect contentScrollViewFrame;
// 主题
@property (nonatomic, assign, readonly) CGRect topicLabelFrame;
// 描述
@property (nonatomic, assign, readonly) CGRect descLabelFrame;
// 展开全文
@property (nonatomic, assign, readonly) CGRect unfoldBtnFrame;
// 标签
@property (nonatomic, assign, readonly) CGRect markScrollViewFrame;
// cell
@property (nonatomic, assign, readonly) CGFloat cellHeight;

@property (nonatomic, strong) NSArray *travelContents;
@property (nonatomic, strong) NSArray *travelDistricts;
@property (nonatomic, strong) NSArray *travelCategorys;
@end
