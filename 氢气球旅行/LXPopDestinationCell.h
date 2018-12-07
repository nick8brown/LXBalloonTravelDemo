//
//  LXPopDestinationCell.h
//  氢气球旅行
//
//  Created by 曾令轩 on 16/1/2.
//  Copyright © 2016年 曾令轩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LXPopDestinationCell : UITableViewCell
@property (nonatomic, strong) UIViewController *preCtl;
@property (nonatomic, strong) NSArray *destinations;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
- (instancetype)initWithTableView:(UITableView *)tableView;
@end
