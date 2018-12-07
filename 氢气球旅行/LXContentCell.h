//
//  LXContentCell.h
//  氢气球旅行
//
//  Created by 曾令轩 on 15/12/24.
//  Copyright © 2015年 曾令轩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LXContentCell : UITableViewCell
@property (nonatomic, strong) UIViewController *preCtl;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
- (instancetype)initWithTableView:(UITableView *)tableView;
@end
