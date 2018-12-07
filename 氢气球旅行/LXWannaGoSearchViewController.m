//
//  LXWannaGoSearchViewController.m
//  氢气球旅行
//
//  Created by 曾令轩 on 16/1/13.
//  Copyright © 2016年 曾令轩. All rights reserved.
//

#import "LXWannaGoSearchViewController.h"

@interface LXWannaGoSearchViewController ()

@end

@implementation LXWannaGoSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // 初始化搜索框
    [self setupNavView];
}

#pragma mark - 搜索框
- (void)setupNavView {
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, screen_WIDTH-80, toolbarH)];
    searchBar.layer.cornerRadius = 15;
    searchBar.clipsToBounds = YES;
    searchBar.placeholder = @"我想去...";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:searchBar];
    // 取消
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancel:)];
    [searchBar becomeFirstResponder];
}
// 取消
- (void)cancel:(UIBarButtonItem *)sender {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

@end
