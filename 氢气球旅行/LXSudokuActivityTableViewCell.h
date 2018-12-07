//
//  LXSudokuActivityTableViewCell.h
//  氢气球旅行
//
//  Created by 曾令轩 on 16/1/12.
//  Copyright © 2016年 曾令轩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LXSudokuActivityTableViewCell : UITableViewCell
@property (nonatomic, strong) NSArray *activitys;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
- (instancetype)initWithTableView:(UITableView *)tableView;
@end
