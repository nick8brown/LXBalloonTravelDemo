//
//  LXWannaGoUserActivityCell.h
//  氢气球旅行
//
//  Created by 曾令轩 on 16/1/14.
//  Copyright © 2016年 曾令轩. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^WannaGoTravelActivityBlock)(NSIndexPath *indexPath);

@class LXTravelActivity;

@interface LXWannaGoUserActivityGroup : NSObject
@property (nonatomic, strong) LXTravelActivity *activity;
@property (nonatomic, assign) BOOL isUnfold;
@end

@interface LXWannaGoUserActivityCell : UITableViewCell
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, copy) WannaGoTravelActivityBlock block;
@property (nonatomic, strong) LXWannaGoUserActivityGroup *group;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
- (instancetype)initWithTableView:(UITableView *)tableView;
+ (CGFloat)heightWithModel:(LXWannaGoUserActivityGroup *)group;
- (void)configCellWithModel:(LXWannaGoUserActivityGroup *)group;
@end
