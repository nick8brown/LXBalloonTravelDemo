//
//  LXInspirationActivityFrame.h
//  氢气球旅行
//
//  Created by 曾令轩 on 16/1/5.
//  Copyright © 2016年 曾令轩. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>

@class LXInspirationActivity;

@interface LXInspirationActivityFrame : NSObject
// 旅行灵感
@property (nonatomic, strong) LXInspirationActivity *inspiration;
// 附图
@property (nonatomic, assign, readonly) CGRect contentImgViewFrame;
// 介绍
@property (nonatomic, assign, readonly) CGRect introduceLabelFrame;
// 查看详情
@property (nonatomic, assign, readonly) CGRect detailViewFrame;
// cell
@property (nonatomic, assign, readonly) CGFloat cellHeight;
@end
