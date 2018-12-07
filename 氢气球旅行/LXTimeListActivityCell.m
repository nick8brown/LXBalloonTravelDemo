//
//  LXTimeListActivityCell.m
//  氢气球旅行
//
//  Created by 曾令轩 on 16/1/9.
//  Copyright © 2016年 曾令轩. All rights reserved.
//

#import "LXTimeListActivityCell.h"
#import "LXTravelActivity.h"
#import "LXTravelContent.h"
#import "LXUserActivityDistrict.h"
#import "UIImageView+WebCache.h"
#import "MJExtension.h"

@interface LXTimeListActivityCell ()
@property (weak, nonatomic) IBOutlet UILabel *made_atLabel;
@property (weak, nonatomic) IBOutlet UILabel *districtLabel;
@property (weak, nonatomic) IBOutlet UILabel *topicLabel;
@property (nonatomic, strong) NSArray *travelContents;
@property (nonatomic, strong) NSArray *userActivityDistricts;
@end

@implementation LXTimeListActivityCell

- (NSArray *)travelContents {
    return [LXTravelContent objectArrayWithKeyValuesArray:self.activity.contents];
}

- (NSArray *)userActivityDistricts {
    return [LXUserActivityDistrict objectArrayWithKeyValuesArray:self.activity.districts];
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    return [[[self class] alloc] initWithTableView:tableView];
}

- (instancetype)initWithTableView:(UITableView *)tableView {
    if (self = [super init]) {
        self = [tableView dequeueReusableCellWithIdentifier:TimeListActivityCell_ID];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setActivity:(LXTravelActivity *)activity {
    _activity = activity;
    if (activity) {
        // 时间
        if ([activity.made_at isKindOfClass:[NSString class]] && ![activity.made_at isEqualToString:@""]) {
            self.made_atLabel.text = [self dateFromMade_at:activity.made_at];
        }
        // 地点标签
        LXUserActivityDistrict *district = [self.userActivityDistricts lastObject];
        self.districtLabel.text = district.name;
        // 主题
        self.topicLabel.text = activity.topic;
        // 附图
        for (int i = 0; i < self.travelContents.count; i++) {
            UIImageView *imgView = (UIImageView *)[self.contentView viewWithTag:100+i];
            imgView.contentMode = UIViewContentModeScaleAspectFill;
            imgView.clipsToBounds = YES;
            LXTravelContent *content = self.travelContents[i];
            [imgView setImageWithURL:[NSURL URLWithString:content.photo_url] placeholderImage:[UIImage imageNamed:photo_placeholder]];
        }
    }
}

#pragma mark - 时间
// 返回日期
- (NSString *)dateFromMade_at:(NSString *)made_at {
    made_at = [made_at substringToIndex:[made_at rangeOfString:@"T"].location];
    made_at = [made_at substringFromIndex:[made_at rangeOfString:@"-"].location+1];
    NSString *month = [made_at substringToIndex:[made_at rangeOfString:@"-"].location];
    NSString *day = [made_at substringFromIndex:[made_at rangeOfString:@"-"].location+1];
    return [NSString stringWithFormat:@"%@.%@", [self formatedDate:month], [self formatedDate:day]];
}
// 01 -> 1
- (NSString *)formatedDate:(NSString *)date {
    if ([date characterAtIndex:0] == '0') {
        return [NSString stringWithFormat:@"%c", [date characterAtIndex:1]];
    }
    return date;
}

@end
