//
//  LXInspirationActivityCell.h
//  氢气球旅行
//
//  Created by 曾令轩 on 16/1/5.
//  Copyright © 2016年 曾令轩. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LXInspirationActivityFrame;

@interface LXInspirationActivityCell : UITableViewCell
@property (nonatomic, strong) LXInspirationActivityFrame *inspirationActivityFrame;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
- (instancetype)initWithTableView:(UITableView *)tableView;
@end
