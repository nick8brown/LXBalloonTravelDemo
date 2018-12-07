//
//  LXContentCell.m
//  氢气球旅行
//
//  Created by 曾令轩 on 15/12/24.
//  Copyright © 2015年 曾令轩. All rights reserved.
//

#import "LXContentCell.h"
#import "LXStoryViewController.h"

@interface LXContentCell () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UIView *storyView;
@property (weak, nonatomic) IBOutlet UIButton *cameraBtn;

- (IBAction)cameraBtnClick:(UIButton *)sender;
@end

@implementation LXContentCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    return [[[self class] alloc] initWithTableView:tableView];
}

- (instancetype)initWithTableView:(UITableView *)tableView {
    if (self = [super init]) {
        self = [tableView dequeueReusableCellWithIdentifier:ContentCell_ID];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.titleTextField becomeFirstResponder];
        [self.storyView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap:)]];
        self.cameraBtn.layer.borderWidth = 1;
        self.cameraBtn.layer.borderColor = separateLineColor.CGColor;
    }
    return self;
}

#pragma mark - 点击手势
- (void)onTap:(UITapGestureRecognizer *)recognizer {
    LXStoryViewController *storyCtl = [[LXStoryViewController alloc] initWithNibName:@"LXStoryViewController" bundle:nil];
    [self.preCtl presentViewController:storyCtl animated:NO completion:nil];
}

#pragma mark - IBAction
- (IBAction)cameraBtnClick:(UIButton *)sender {
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    UIImagePickerController *imgPickerCtl = [[UIImagePickerController alloc] init];
    imgPickerCtl.sourceType = sourceType;
    imgPickerCtl.allowsEditing = YES;
    imgPickerCtl.delegate = self;
    [self.preCtl presentViewController:imgPickerCtl animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate
// 点击相册中的图片或照相机照完后点击use后触发的方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    [self.preCtl dismissViewControllerAnimated:YES completion:nil];
}
// 点击cancel调用的方法
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self.preCtl dismissViewControllerAnimated:YES completion:nil];
}

@end
