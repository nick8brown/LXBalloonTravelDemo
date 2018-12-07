//
//  LXSectionFooterView.m
//  氢气球旅行
//
//  Created by 曾令轩 on 15/12/28.
//  Copyright © 2015年 曾令轩. All rights reserved.
//

#import "LXSectionFooterView.h"
#import "LXNavigationController.h"
#import "LXLoginViewController.h"
#import "LXTabBarButton.h"
#import "LXTravelActivity.h"

@interface LXSectionFooterView ()
@property (weak, nonatomic) IBOutlet LXTabBarButton *likes_countBtn;
@property (weak, nonatomic) IBOutlet LXTabBarButton *favorites_countBtn;
@property (weak, nonatomic) IBOutlet UILabel *likes_countLabel;
@property (weak, nonatomic) IBOutlet UILabel *comments_countLabel;
@property (weak, nonatomic) IBOutlet UILabel *favorites_countLabel;
@property (nonatomic, strong) NSUserDefaults *user;
@property (nonatomic, assign) BOOL isLikes_countBtnClick;
@property (nonatomic, assign) BOOL isFavorites_countBtnClick;
@end

@implementation LXSectionFooterView

- (NSUserDefaults *)user {
    if (_user == nil) {
        _user = [NSUserDefaults standardUserDefaults];
    }
    return _user;
}

- (void)setActivity:(LXTravelActivity *)activity {
    _activity = activity;
    [self selectedButton:self.likes_countBtn markWithKey:likes_count_KEY setImageWithIMGName_Nor:likes_count_normal_IMG andIMGName_Sel:likes_count_selected_IMG];
    [self selectedButton:self.favorites_countBtn markWithKey:favorites_count_KEY setImageWithIMGName_Nor:favorites_count_normal_IMG andIMGName_Sel:favorites_count_selected_IMG];
    self.likes_countLabel.text = [NSString stringWithFormat:@"%@", activity.likes_count];
    self.comments_countLabel.text = [NSString stringWithFormat:@"%@", activity.comments_count];
    self.favorites_countLabel.text = [NSString stringWithFormat:@"%@", activity.favorites_count];
}

#pragma mark - IBAction
// 点赞
- (IBAction)likes_countBtnClick:(LXTabBarButton *)sender {
    if ([self.user objectForKey:login_status]) {
        self.isLikes_countBtnClick = !self.isLikes_countBtnClick;
        [self selectedButtonSynchronizeClickState:self.isLikes_countBtnClick withKey:likes_count_KEY];
        [self selectedButton:sender markWithKey:likes_count_KEY setImageWithIMGName_Nor:likes_count_normal_IMG andIMGName_Sel:likes_count_selected_IMG];
        [self selectedButtonSynchronizeCountWithKey:likes_count_KEY forLabel:self.likes_countLabel];
    } else {
        LXLoginViewController *loginCtl = [[LXLoginViewController alloc] initWithNibName:@"LXLoginViewController" bundle:nil];
        LXNavigationController *navCtl = [[LXNavigationController alloc] initWithRootViewController:loginCtl];
        [self.preCtl presentViewController:navCtl animated:YES completion:nil];
    }
}
// 评论
- (IBAction)comments_countBtnClick:(LXTabBarButton *)sender {
    if ([self.user objectForKey:login_status]) {
#warning todo
    } else {
        LXLoginViewController *loginCtl = [[LXLoginViewController alloc] initWithNibName:@"LXLoginViewController" bundle:nil];
        LXNavigationController *navCtl = [[LXNavigationController alloc] initWithRootViewController:loginCtl];
        [self.preCtl presentViewController:navCtl animated:YES completion:nil];
    }
}
// 收藏
- (IBAction)favorites_countBtnClick:(LXTabBarButton *)sender {
    if ([self.user objectForKey:login_status]) {
        self.isFavorites_countBtnClick = !self.isFavorites_countBtnClick;
        [self selectedButtonSynchronizeClickState:self.isFavorites_countBtnClick withKey:favorites_count_KEY];
        [self selectedButton:sender markWithKey:favorites_count_KEY setImageWithIMGName_Nor:favorites_count_normal_IMG andIMGName_Sel:favorites_count_selected_IMG];
        [self selectedButtonSynchronizeCountWithKey:favorites_count_KEY forLabel:self.favorites_countLabel];
    } else {
        LXLoginViewController *loginCtl = [[LXLoginViewController alloc] initWithNibName:@"LXLoginViewController" bundle:nil];
        LXNavigationController *navCtl = [[LXNavigationController alloc] initWithRootViewController:loginCtl];
        [self.preCtl presentViewController:navCtl animated:YES completion:nil];
    }
}
// 更多
- (IBAction)moreBtnClick:(LXTabBarButton *)sender {
#warning todo
}

#pragma mark - 被点击按钮
// 同步被点击按钮的状态
- (void)selectedButtonSynchronizeClickState:(BOOL)state withKey:(NSString *)key {
    [self.user setBool:state forKey:key];
    [self.user synchronize];
}
// 切换被点击按钮的图片
- (void)selectedButton:(UIButton *)btn markWithKey:(NSString *)key setImageWithIMGName_Nor:(NSString *)img_nor andIMGName_Sel:(NSString *)img_sel {
    if (![self.user boolForKey:key]) {
        [btn setImage:[UIImage imageNamed:img_nor] forState:UIControlStateNormal];
    } else {
        [btn setImage:[UIImage imageNamed:img_sel] forState:UIControlStateNormal];
    }
}
// 改变被点击按钮的点赞数\收藏数
- (void)selectedButtonSynchronizeCountWithKey:(NSString *)key forLabel:(UILabel *)label {
    if ([self.user boolForKey:key]) {
        label.text = [NSString stringWithFormat:@"%ld", [label.text integerValue]+1];
    } else {
        label.text = [NSString stringWithFormat:@"%ld", [label.text integerValue]-1];
    }
}

@end
