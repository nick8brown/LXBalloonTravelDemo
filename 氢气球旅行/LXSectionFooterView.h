//
//  LXSectionFooterView.h
//  氢气球旅行
//
//  Created by 曾令轩 on 15/12/28.
//  Copyright © 2015年 曾令轩. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LXTravelActivity;

@interface LXSectionFooterView : UIView
@property (nonatomic, strong) UIViewController *preCtl;
@property (nonatomic, assign) NSInteger section;
@property (nonatomic, strong) LXTravelActivity *activity;
@end
