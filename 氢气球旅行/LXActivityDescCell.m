//
//  LXActivityDescCell.m
//  氢气球旅行
//
//  Created by 曾令轩 on 16/1/11.
//  Copyright © 2016年 曾令轩. All rights reserved.
//

#import "LXActivityDescCell.h"
#import "LXTravelActivity.h"
#import "LXTravelContent.h"
#import "UIImageView+WebCache.h"
#import "MJExtension.h"

@interface LXActivityDescCell ()
@property (weak, nonatomic) IBOutlet UIImageView *contentImgView;
@property (weak, nonatomic) IBOutlet UILabel *topicLabel;
@end

@implementation LXActivityDescCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    return [[[self class] alloc] initWithTableView:tableView];
}

- (instancetype)initWithTableView:(UITableView *)tableView {
    if (self = [super init]) {
        self = [tableView dequeueReusableCellWithIdentifier:ActivityDescCell_ID];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setActivity:(LXTravelActivity *)activity {
    _activity = activity;
    if (activity) {
        // 大图
        LXTravelContent *content = [[LXTravelContent objectArrayWithKeyValuesArray:activity.contents] firstObject];
        self.contentImgView.contentMode = UIViewContentModeScaleAspectFill;
        self.contentImgView.clipsToBounds = YES;
        [self.contentImgView setImageWithURL:[NSURL URLWithString:content.photo_url] placeholderImage:[UIImage imageNamed:photo_placeholder]];
        // 主题
        self.topicLabel.text = activity.topic;
    }
}

@end
