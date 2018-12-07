//
//  LXMarkViewController.m
//  氢气球旅行
//
//  Created by 曾令轩 on 15/12/25.
//  Copyright © 2015年 曾令轩. All rights reserved.
//

#import "LXMarkViewController.h"

@interface LXMarkViewController () <UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *customUseTextView;
@property (weak, nonatomic) IBOutlet UIView *commonUseView;
@property (nonatomic, weak) UIButton *confirmBtn;
@end

@implementation LXMarkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"添加标签";
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(back:)];
    UIButton *confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    confirmBtn.frame = CGRectMake(0, 0, 35, 30);
    confirmBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    [confirmBtn setTitle:@"完成" forState:UIControlStateNormal];
    [confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    confirmBtn.hidden = YES;
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:confirmBtn];
    self.confirmBtn = confirmBtn;
    self.navigationItem.leftBarButtonItem = leftItem;
    self.navigationItem.rightBarButtonItem = rightItem;
    // 常用标签
    for (UIView *view in self.commonUseView.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton *)view;
            btn.layer.cornerRadius = 50*0.3;
            btn.clipsToBounds = YES;
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    [self.customUseTextView becomeFirstResponder];
}
// 返回
- (void)back:(UIBarButtonItem *)sender {
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
}
// 完成
- (void)confirm:(UIBarButtonItem *)sender {
    [self back:sender];
}
// 常用标签
- (void)btnClick:(UIButton *)sender {
    NSLog(@"点击了%@", sender.currentTitle);
}

#pragma mark - UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView {
    if (textView.text.length) {
        self.confirmBtn.hidden = NO;
    } else {
        self.confirmBtn.hidden = YES;
    }
}

@end
