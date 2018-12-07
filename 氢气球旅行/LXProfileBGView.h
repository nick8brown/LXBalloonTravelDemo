//
//  LXProfileBGView.h
//  氢气球旅行
//
//  Created by 曾令轩 on 16/1/7.
//  Copyright © 2016年 曾令轩. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LXUserProfile;

@interface LXProfileBGView : UIView
@property (nonatomic, strong) UIViewController *preCtl;
@property (nonatomic, strong) LXUserProfile *userProfile;
@property (nonatomic, strong) NSArray *travelActivitys;

+ (instancetype)viewWithUserProfile:(LXUserProfile *)userProfile;
- (instancetype)initWithUserProfile:(LXUserProfile *)userProfile;
@end
