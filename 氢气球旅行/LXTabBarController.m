//
//  LXTabBarController.m
//  网易彩票
//
//  Created by 曾令轩 on 15/11/19.
//  Copyright (c) 2015年 曾令轩. All rights reserved.
//

#import "LXTabBarController.h"
#import "LXTabBar.h"
#import "LXNavigationController.h"
#import "LXLoginViewController.h"
#import "LXTravelNoteViewController.h"
#import "LXPersonalViewController.h"

@interface LXTabBarController () <LXTabBarDelegate>
@property (nonatomic, strong) UIApplication *application;
@property (nonatomic, strong) NSUserDefaults *user;
@property (nonatomic, assign) BOOL preStatusBarStyle;
@end

@implementation LXTabBarController

- (UIApplication *)application {
    if (_application == nil) {
        _application = [UIApplication sharedApplication];
    }
    return _application;
}

- (NSUserDefaults *)user {
    if (_user == nil) {
        _user = [NSUserDefaults standardUserDefaults];
    }
    return _user;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 1.添加自己的tabbar
    LXTabBar *myTabBar = [[LXTabBar alloc] initWithFrame:self.tabBar.bounds];
    myTabBar.delegate = self;
    [self.tabBar addSubview:myTabBar];
    // 2.添加对应个数的按钮
    for (int i = 0; i < self.viewControllers.count+1; i++) {
        NSString *name = [NSString stringWithFormat:@"tabBar_%d_normal", i];
        NSString *selName = [NSString stringWithFormat:@"tabBar_%d_selected", i];
        [myTabBar addTabBarButtonWithName:name selName:selName];
    }
}

- (void)tabBar:(LXTabBar *)tabBar didSelectButtonFrom:(NSInteger)from to:(NSInteger)to {
    if (!from) {
        self.preStatusBarStyle = self.application.statusBarStyle;
        if (!self.preStatusBarStyle) {
            self.application.statusBarStyle = !self.application.statusBarStyle;
        }
    }
    if (!to && !self.preStatusBarStyle) {
        self.application.statusBarStyle = !self.application.statusBarStyle;
    }
    if ([self.user objectForKey:login_status]) {// 已登录
        if (to == 2) {
            LXTravelNoteViewController *noteCtl = [[LXTravelNoteViewController alloc] initWithNibName:@"LXTravelNoteViewController" bundle:nil];
            LXNavigationController *navCtl = [[LXNavigationController alloc] initWithRootViewController:noteCtl];
            [self presentViewController:navCtl animated:YES completion:nil];
        } else if (to > 2) {
            self.selectedIndex = to-1;
        } else {
            // 选中最新的控制器
            self.selectedIndex = to;
        }
    } else {// 未登录
        if (to == 2 || to == 4) {
            LXLoginViewController *loginCtl = [[LXLoginViewController alloc] initWithNibName:@"LXLoginViewController" bundle:nil];
            LXNavigationController *navCtl = [[LXNavigationController alloc] initWithRootViewController:loginCtl];
            [self presentViewController:navCtl animated:YES completion:nil];
        } else if (to > 2) {
            self.selectedIndex = to-1;
        } else {
            self.selectedIndex = to;
        }
    }
}

@end
