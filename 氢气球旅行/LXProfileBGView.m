//
//  LXProfileBGView.m
//  氢气球旅行
//
//  Created by 曾令轩 on 16/1/7.
//  Copyright © 2016年 曾令轩. All rights reserved.
//

#import "LXProfileBGView.h"
#import "LXTravelUserViewController.h"
#import "LXPersonalViewController.h"
#import "LXActivityMapViewController.h"
#import "LXTabBarButton.h"
#import "LXUserProfile.h"
#import "LXUserProfileHeader_photo.h"
#import "UIImage+ScaledImage.h"
#import "UIImageView+WebCache.h"

@interface LXProfileBGView ()
@property (weak, nonatomic) IBOutlet UIImageView *bgImgView;
@property (weak, nonatomic) IBOutlet UIButton *iconBtn;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *followingsBtn;
@property (weak, nonatomic) IBOutlet UIButton *followersBtn;
@property (weak, nonatomic) IBOutlet UIView *btnView;
@property (nonatomic, strong) NSMutableDictionary *img_norDict;
@property (nonatomic, strong) NSMutableDictionary *img_selDict;
@property (nonatomic, strong) LXTabBarButton *preBtn;
@end

@implementation LXProfileBGView

- (NSMutableDictionary *)img_norDict {
    if (_img_norDict == nil) {
        _img_norDict = [NSMutableDictionary dictionary];
        _img_norDict[@(Sudoku_TAG)] = [UIImage imageNamed:sudoku_normal_IMG];
        _img_norDict[@(BigPhoto_TAG)] = [UIImage imageNamed:bigPhoto_normal_IMG];
        _img_norDict[@(TimeList_TAG)] = [UIImage imageNamed:timeList_normal_IMG];
        _img_norDict[@(Location_TAG)] = [UIImage imageNamed:location_normal_IMG];
    }
    return _img_norDict;
}

- (NSMutableDictionary *)img_selDict {
    if (_img_selDict == nil) {
        _img_selDict = [NSMutableDictionary dictionary];
        _img_selDict[@(100+Sudoku_TAG)] = [UIImage imageNamed:suduku_selected_IMG];
        _img_selDict[@(100+BigPhoto_TAG)] = [UIImage imageNamed:bigPhoto_selected_IMG];
        _img_selDict[@(100+TimeList_TAG)] = [UIImage imageNamed:timeList_selected_IMG];
        _img_selDict[@(100+Location_TAG)] = [UIImage imageNamed:location_normal_IMG];
    }
    return _img_selDict;
}

+ (instancetype)viewWithUserProfile:(LXUserProfile *)userProfile {
    return [[[self class] alloc] initWithUserProfile:userProfile];
}

- (instancetype)initWithUserProfile:(LXUserProfile *)userProfile {
    if (self = [super init]) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"LXProfileBGView" owner:self options:nil] lastObject];
        // 初始化内部子控件
        [self setupViewWithUserProfile:(LXUserProfile *)userProfile];
    }
    return self;
}
// 初始化内部子控件
- (void)setupViewWithUserProfile:(LXUserProfile *)userProfile {
    // 封面图
    [self.bgImgView setImageWithURL:[NSURL URLWithString:userProfile.header_photo.photo_url]];
    // 头像
    self.iconBtn.layer.borderWidth = 2;
    self.iconBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    self.iconBtn.layer.cornerRadius = ProfileBGView_iconBtn_WIDTH*0.5;
    self.iconBtn.clipsToBounds = YES;
    UIImage *iconImg = [[UIImage alloc] OriginImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:userProfile.photo_url]]] scaleToSize:CGSizeMake(ProfileBGView_iconImg_WIDTH, ProfileBGView_iconImg_HEIGHT)];
    [self.iconBtn setImage:iconImg forState:UIControlStateNormal];
    // 昵称
    self.nameLabel.text = userProfile.name;
    // 关注
    [self.followingsBtn setTitle:[NSString stringWithFormat:@"%@ 关注", userProfile.followings_count] forState:UIControlStateNormal];
    // 粉丝
    [self.followersBtn setTitle:[NSString stringWithFormat:@"%@ 粉丝", userProfile.followers_count] forState:UIControlStateNormal];
    // 默认选中
    [self defaultShowWithSelectedButton_Tag:BigPhoto_TAG];
}
// 默认选中
- (void)defaultShowWithSelectedButton_Tag:(NSInteger)selectedBtn_tag {
    [self bigPhotoBtnClick:[self.btnView viewWithTag:selectedBtn_tag]];
}

#pragma mark - IBAction
// 头像
- (IBAction)iconBtnClick:(UIButton *)sender {
    NSLog(@"-----头像-----");
}
// 关注
- (IBAction)followingsBtnClick:(UIButton *)sender {
    NSLog(@"-----关注-----");
}
// 粉丝
- (IBAction)followersBtnClick:(UIButton *)sender {
    NSLog(@"-----粉丝-----");
}
// 九宫格
- (IBAction)sudokuBtnClick:(LXTabBarButton *)sender {
    [self markSelectedButton:sender];
}
// 大图
- (IBAction)bigPhotoBtnClick:(LXTabBarButton *)sender {
    [self markSelectedButton:sender];
}
// 时光轴
- (IBAction)timeListBtnClick:(LXTabBarButton *)sender {
    [self markSelectedButton:sender];
}
// 地图显示
- (IBAction)locationBtnClick:(LXTabBarButton *)sender {
    [self markSelectedButton:sender];
    LXActivityMapViewController *activityMapCtl = [[LXActivityMapViewController alloc] initWithNibName:@"LXActivityMapViewController" bundle:nil];
    activityMapCtl.travelActivitys = self.travelActivitys;
    if ([self.preCtl isKindOfClass:[LXTravelUserViewController class]]) {
        LXTravelUserViewController *travelUserCtl = (LXTravelUserViewController *)self.preCtl;
        activityMapCtl.isNavigationBarHide = travelUserCtl.isNavigationBarHide;
        [travelUserCtl.navigationController pushViewController:activityMapCtl animated:YES];
    } else if ([self.preCtl isKindOfClass:[LXPersonalViewController class]]) {
        LXPersonalViewController *personalCtl = (LXPersonalViewController *)self.preCtl;
        activityMapCtl.isNavigationBarHide = personalCtl.isNavigationBarHide;
        [personalCtl.navigationController pushViewController:activityMapCtl animated:YES];
    }
}

#pragma mark - 被点击按钮
// 标记被点击按钮\发送通知
- (void)markSelectedButton:(UIButton *)sender {
    [self setImageForSelectedButton:sender deselectedButtons:[self deselectedButtonsWithSelectedButton:sender]];
    if (sender.tag != Location_TAG) {
        [[NSNotificationCenter defaultCenter] postNotificationName:BTN_CLICK object:nil userInfo:@{sender_tag:@(sender.tag)}];
    }
}
// 返回其它按钮
- (NSArray *)deselectedButtonsWithSelectedButton:(UIButton *)sender {
    NSMutableArray *btnArray = [NSMutableArray array];
    for (UIView *view in self.btnView.subviews) {
        if ([view isKindOfClass:[LXTabBarButton class]]) {
            if (view.tag != sender.tag) {
                [btnArray addObject:view];
            }
        }
    }
    return btnArray;
}
// 切换被点击按钮的图片
- (void)setImageForSelectedButton:(UIButton *)selectedBtn deselectedButtons:(NSArray *)deselectedBtns {
    [selectedBtn setImage:self.img_selDict[@(100+selectedBtn.tag)] forState:UIControlStateNormal];
    for (int i = 0; i < deselectedBtns.count; i++) {
        LXTabBarButton *deselectedBtn = deselectedBtns[i];
        [deselectedBtn setImage:self.img_norDict[@(deselectedBtn.tag)] forState:UIControlStateNormal];
    }
    if (self.preBtn) {
        if (selectedBtn.tag == Location_TAG) {
            [self.preBtn setImage:self.img_selDict[@(100+self.preBtn.tag)] forState:UIControlStateNormal];
        }
    }
    self.preBtn = (LXTabBarButton *)selectedBtn;
}

@end
