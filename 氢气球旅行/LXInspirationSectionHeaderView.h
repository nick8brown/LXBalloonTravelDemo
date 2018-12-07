//
//  LXInspirationSectionHeaderView.h
//  氢气球旅行
//
//  Created by 曾令轩 on 16/1/5.
//  Copyright © 2016年 曾令轩. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LXInspirationActivity;

@interface LXInspirationSectionHeaderView : UIView
@property (nonatomic, assign) NSInteger section;
@property (nonatomic, strong) LXInspirationActivity *inspiration;

+ (instancetype)view;
+ (instancetype)viewWithFrame:(CGRect)frame;
@end
