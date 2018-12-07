//
//  LXStoryViewController.m
//  氢气球旅行
//
//  Created by 曾令轩 on 15/12/25.
//  Copyright © 2015年 曾令轩. All rights reserved.
//

#import "LXStoryViewController.h"

@interface LXStoryViewController () <UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *placeholderLabel;
@property (weak, nonatomic) IBOutlet UITextView *storyTextView;

- (IBAction)confirmBtnClick:(UIButton *)sender;
@end

@implementation LXStoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.storyTextView becomeFirstResponder];
}

#pragma mark - UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView {
    if (textView.text.length) {
        self.placeholderLabel.text = @"";
    } else {
        self.placeholderLabel.text = @"经历与感想...";
    }
}

#pragma mark - IBAction
- (IBAction)confirmBtnClick:(UIButton *)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
}

@end
