//
//  LXWannaGoDestinationCell.m
//  氢气球旅行
//
//  Created by 曾令轩 on 16/1/4.
//  Copyright © 2016年 曾令轩. All rights reserved.
//

#import "LXWannaGoDestinationCell.h"
#import "LXWannaGoDestination.h"
#import "UIImageView+WebCache.h"

@interface LXWannaGoDestinationCell ()
@property (weak, nonatomic) IBOutlet UIImageView *coverImgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *inspiration_activities_countLabel;
@end

@implementation LXWannaGoDestinationCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    return [[[self class] alloc] initWithTableView:tableView];
}

- (instancetype)initWithTableView:(UITableView *)tableView {
    if (self = [super init]) {
        self = [tableView dequeueReusableCellWithIdentifier:WannaGoDestinationCell_ID];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setDestination:(LXWannaGoDestination *)destination {
    _destination = destination;
    [self.coverImgView setImageWithURL:[NSURL URLWithString:destination.photo_url] placeholderImage:[UIImage imageNamed:photo_placeholder]];
    self.nameLabel.text = destination.name;
    self.inspiration_activities_countLabel.text = [NSString stringWithFormat:@"%@条旅行灵感", destination.inspiration_activities_count];
}

@end
