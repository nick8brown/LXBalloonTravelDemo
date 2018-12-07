//
//  LXTopicDestinationCell.m
//  氢气球旅行
//
//  Created by 曾令轩 on 16/1/4.
//  Copyright © 2016年 曾令轩. All rights reserved.
//

#import "LXTopicDestinationCell.h"
#import "LXTopicDestination.h"
#import "UIImageView+WebCache.h"

@interface LXTopicDestinationCell ()
@property (weak, nonatomic) IBOutlet UIImageView *coverImgView;
@property (weak, nonatomic) IBOutlet UILabel *topicLabel;
@property (weak, nonatomic) IBOutlet UILabel *inspiration_activities_countLabel;
@end

@implementation LXTopicDestinationCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    return [[[self class] alloc] initWithTableView:tableView];
}

- (instancetype)initWithTableView:(UITableView *)tableView {
    if (self = [super init]) {
        self = [tableView dequeueReusableCellWithIdentifier:TopicDestinationCell_ID];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setDestination:(LXTopicDestination *)destination {
    _destination = destination;
    [self.coverImgView setImageWithURL:[NSURL URLWithString:destination.photo_url] placeholderImage:[UIImage imageNamed:photo_placeholder]];
    self.topicLabel.font = [UIFont boldSystemFontOfSize:20];
    self.topicLabel.text = destination.topic;
    self.inspiration_activities_countLabel.text = [NSString stringWithFormat:@"- %@条旅行灵感 -", destination.inspiration_activities_count];
}

@end
