//
//  LXActivityView.m
//  氢气球旅行
//
//  Created by 曾令轩 on 16/1/11.
//  Copyright © 2016年 曾令轩. All rights reserved.
//

#import "LXActivityView.h"
#import "LXTravelActivity.h"
#import "LXTravelContent.h"
#import "UIImageView+WebCache.h"
#import "MJExtension.h"

@interface LXActivityView ()
@property (weak, nonatomic) IBOutlet UIImageView *contentImgView;
@end

@implementation LXActivityView

+ (instancetype)view {
    return [[[self class] alloc] init];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"LXActivityView" owner:self options:nil] lastObject];
    }
    return self;
}

- (void)setActivity:(LXTravelActivity *)activity {
    _activity = activity;
    LXTravelContent *content = [[LXTravelContent objectArrayWithKeyValuesArray:activity.contents] firstObject];
    self.contentImgView.contentMode = UIViewContentModeScaleAspectFill;
    self.contentImgView.clipsToBounds = YES;
    [self.contentImgView setImageWithURL:[NSURL URLWithString:content.photo_url] placeholderImage:[UIImage imageNamed:photo_placeholder]];
}

@end
