//
//  LXSectionHeaderView.h
//  氢气球旅行
//
//  Created by 曾令轩 on 15/12/28.
//  Copyright © 2015年 曾令轩. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LXTravelUser, LXTravelRecommendUser;

@interface LXSectionHeaderView : UIView
@property (nonatomic, strong) LXTravelUser *user;
@property (nonatomic, strong) LXTravelRecommendUser *recommendUser;
@end
