//
//  LXSearchViewController.m
//  氢气球旅行
//
//  Created by 曾令轩 on 15/12/25.
//  Copyright © 2015年 曾令轩. All rights reserved.
//

#import "LXSearchViewController.h"

@interface LXSearchViewController ()
@property (weak, nonatomic) IBOutlet UISearchBar *destinationSearchBar;
- (IBAction)cancelBtnClick:(UIButton *)sender;
@end

@implementation LXSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 轻扫手势
    [self createSwipeGesture];
    [self.destinationSearchBar setBackgroundImage:[[UIImage alloc] init]];
    [self.destinationSearchBar becomeFirstResponder];
}

#pragma mark - 轻扫手势
- (void)createSwipeGesture {
    UISwipeGestureRecognizer *swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(onSwipe:)];
    swipeGesture.direction = UISwipeGestureRecognizerDirectionUp
                           | UISwipeGestureRecognizerDirectionDown;
    [self.view addGestureRecognizer:swipeGesture];
}
- (void)onSwipe:(UISwipeGestureRecognizer *)recognizer {
    [self.view endEditing:YES];
}

#pragma mark - IBAction
- (IBAction)cancelBtnClick:(UIButton *)sender {
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
