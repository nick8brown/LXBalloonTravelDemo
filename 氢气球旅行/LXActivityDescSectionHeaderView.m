//
//  LXActivityDescSectionHeaderView.m
//  氢气球旅行
//
//  Created by 曾令轩 on 16/1/11.
//  Copyright © 2016年 曾令轩. All rights reserved.
//

#import "LXActivityDescSectionHeaderView.h"
#import "LXTravelActivity.h"

@interface LXActivityDescSectionHeaderView ()
@property (weak, nonatomic) IBOutlet UILabel *made_atLabel;
@end

@implementation LXActivityDescSectionHeaderView

+ (instancetype)view {
    return [[[self class] alloc] init];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"LXActivityDescSectionHeaderView" owner:self options:nil] lastObject];
    }
    return self;
}

- (void)setActivity:(LXTravelActivity *)activity {
    _activity = activity;
    if (activity) {
        // 日期
        if ([activity.made_at isKindOfClass:[NSString class]] && ![activity.made_at isEqualToString:@""]) {
            self.made_atLabel.text = [self dateFromMade_at:activity.made_at];
        }
    }
}
// 返回日期
- (NSString *)dateFromMade_at:(NSString *)made_at {
    NSMutableString *date = [NSMutableString stringWithString:[made_at substringWithRange:NSMakeRange(0, 7)]];
    [date replaceOccurrencesOfString:@"-" withString:@"." options:NSLiteralSearch range:NSMakeRange(0, date.length)];
    return date;
}

@end
