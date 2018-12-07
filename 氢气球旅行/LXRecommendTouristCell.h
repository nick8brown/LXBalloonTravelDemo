//
//  LXRecommendTouristCell.h
//  氢气球旅行
//
//  Created by 曾令轩 on 16/1/1.
//  Copyright © 2016年 曾令轩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LXRecommendTouristCell : UITableViewCell
@property (nonatomic, strong) UIViewController *preCtl;
@property (nonatomic, strong) NSArray *tourists;
@property (nonatomic, strong) NSArray *touristActivitys;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
- (instancetype)initWithTableView:(UITableView *)tableView;
@end
