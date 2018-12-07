//
//  LXTopicItemFrame.h
//  氢气球旅行
//
//  Created by 曾令轩 on 15/12/31.
//  Copyright © 2015年 曾令轩. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>

@class LXTopicItem;

@interface LXTopicItemFrame : NSObject
// 专题
@property (nonatomic, strong) LXTopicItem *topicItem;
// 标题
@property (nonatomic, assign, readonly) CGRect titleLabelFrame;
// 描述
@property (nonatomic, assign, readonly) CGRect descLabelFrame;
// cell
@property (nonatomic, assign, readonly) CGFloat cellHeight;
@end
