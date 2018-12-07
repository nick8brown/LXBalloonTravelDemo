//
//  LXSectionHeaderView.m
//  氢气球旅行
//
//  Created by 曾令轩 on 15/12/28.
//  Copyright © 2015年 曾令轩. All rights reserved.
//

#import "LXSectionHeaderView.h"
#import "LXTravelUser.h"
#import "LXTravelRecommendUser.h"
#import "UIImageView+WebCache.h"

@interface LXSectionHeaderView ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *recommendUserNameBtn;
@property (weak, nonatomic) IBOutlet UIButton *genderBtn;
@end

@implementation LXSectionHeaderView

- (void)setUser:(LXTravelUser *)user {
    _user = user;
    // 初始化子控件
    [self setupSubviews];
    [self.iconImgView setImageWithURL:[NSURL URLWithString:user.photo_url] placeholderImage:[UIImage imageNamed:photo_placeholder]];
    self.nameLabel.text = user.name;
    if ([user.gender boolValue]) {
        [self.genderBtn setTitle:@"关注他" forState:UIControlStateNormal];
    } else {
        [self.genderBtn setTitle:@"关注她" forState:UIControlStateNormal];
    }
}
// 初始化子控件
- (void)setupSubviews {
    // 头像
    self.iconImgView.layer.cornerRadius = self.iconImgView.frame.size.width*0.5;
    self.iconImgView.clipsToBounds = YES;
    self.iconImgView.contentMode = UIViewContentModeScaleAspectFill;
    // 性别
    self.genderBtn.layer.borderWidth = 1;
    self.genderBtn.layer.borderColor = mainThemeColor.CGColor;
    self.genderBtn.layer.cornerRadius = 3;
    self.genderBtn.clipsToBounds = YES;
}

- (void)setRecommendUser:(LXTravelRecommendUser *)recommendUser {
    _recommendUser = recommendUser;
    [self.recommendUserNameBtn setTitle:recommendUser.name forState:UIControlStateNormal];
}

@end
