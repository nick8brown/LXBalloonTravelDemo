//
//  LXTravelNoteViewController.m
//  氢气球旅行
//
//  Created by 曾令轩 on 15/12/24.
//  Copyright © 2015年 曾令轩. All rights reserved.
//

#import "LXTravelNoteViewController.h"
#import "LXContentCell.h"
#import "LXDescCell.h"

@interface LXTravelNoteViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation LXTravelNoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"写游记";
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancel:)];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"发布" style:UIBarButtonItemStylePlain target:self action:@selector(send:)];
    self.navigationItem.leftBarButtonItem = leftItem;
    self.navigationItem.rightBarButtonItem = rightItem;
    // 注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"LXContentCell" bundle:nil] forCellReuseIdentifier:ContentCell_ID];
    [self.tableView registerNib:[UINib nibWithNibName:@"LXDescCell" bundle:nil] forCellReuseIdentifier:DescCell_ID];
}
// 取消
- (void)cancel:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
// 发布
- (void)send:(UIBarButtonItem *)sender {
    [self cancel:sender];
}

#pragma mark - UITableViewDataSource
// 段数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
// 行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
// cell样式
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section) {
        LXDescCell *cell = [LXDescCell cellWithTableView:tableView];
        cell.preCtl = self;
        return cell;
    }
    LXContentCell *cell = [LXContentCell cellWithTableView:tableView];
    cell.preCtl = self;
    return cell;
}

#pragma mark - UITableViewDelegate
// 行高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section) {
        return DescCell_HEIGHT;
    }
    return ContentCell_HEIGHT;
}
// 段头高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}
// 段尾高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return minimumSpacing;
}
// 尾部视图
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, minimumSpacing)];
    if (!section) {
        footerView.backgroundColor = bgColor;
    } else {
        footerView.backgroundColor = [UIColor clearColor];
    }
    return footerView;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}

@end
