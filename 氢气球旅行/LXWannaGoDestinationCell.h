//
//  LXWannaGoDestinationCell.h
//  氢气球旅行
//
//  Created by 曾令轩 on 16/1/4.
//  Copyright © 2016年 曾令轩. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LXWannaGoDestination;

@interface LXWannaGoDestinationCell : UITableViewCell
@property (nonatomic, strong) LXWannaGoDestination *destination;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
- (instancetype)initWithTableView:(UITableView *)tableView;
@end
