//
//  LXNavigationController.m
//  网易彩票
//
//  Created by 曾令轩 on 15/11/19.
//  Copyright (c) 2015年 曾令轩. All rights reserved.
//

#import "LXNavigationController.h"

@interface LXNavigationController ()

@end

@implementation LXNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
}

+ (void)initialize {
    // 1.设置导航栏主题
    UINavigationBar *navBar = [UINavigationBar appearance];
    navBar.tintColor = [UIColor whiteColor];
    // 设置背景图片
    NSString *bgName = nil;
    if (iPhone5s) {
        bgName = @"navBar_0_320";
    } else {
        bgName = @"navBar_0_375";
    }
    [navBar setBackgroundImage:[UIImage imageNamed:bgName] forBarMetrics:UIBarMetricsDefault];
    // 设置标题文字颜色
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:18];
    [navBar setTitleTextAttributes:attrs];
    
    // 2.设置BarButtonItem的主题
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    // 设置文字颜色
    NSMutableDictionary *itemAttrs = [NSMutableDictionary dictionary];
    itemAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    itemAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:17];
    [item setTitleTextAttributes:itemAttrs forState:UIControlStateNormal];
}

// 重写这个方法，能拦截所有的push操作
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    viewController.hidesBottomBarWhenPushed = YES;
    [super pushViewController:viewController animated:YES];
}

@end
