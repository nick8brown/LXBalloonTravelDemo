//
//  LXTouristView.m
//  氢气球旅行
//
//  Created by 曾令轩 on 16/1/1.
//  Copyright © 2016年 曾令轩. All rights reserved.
//

#import "LXTouristView.h"
#import "LXRecommendTourist.h"
#import "LXRecommendTouristActivity.h"
#import "UIImageView+WebCache.h"

@interface LXTouristView ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *latest_activityLabel;
@end

@implementation LXTouristView

- (void)setTourist:(LXRecommendTourist *)tourist {
    _tourist = tourist;
    self.iconImgView.layer.cornerRadius = self.iconImgView.frame.size.width*0.5;
    self.iconImgView.clipsToBounds = YES;
    self.iconImgView.contentMode = UIViewContentModeScaleAspectFill;
    [self.iconImgView setImageWithURL:[NSURL URLWithString:tourist.photo_url]];
    self.nameLabel.text = tourist.name;
}

- (void)setActivity:(LXRecommendTouristActivity *)activity {
    _activity = activity;
    self.latest_activityLabel.text = activity.topic;
}

@end
