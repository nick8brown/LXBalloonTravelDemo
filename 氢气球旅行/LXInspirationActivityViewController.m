//
//  LXInspirationActivityViewController.m
//  氢气球旅行
//
//  Created by 曾令轩 on 16/1/5.
//  Copyright © 2016年 曾令轩. All rights reserved.
//

#import "LXInspirationActivityViewController.h"
#import "LXInspirationActivityPage.h"
#import "LXInspirationActivityGroup.h"
#import "LXInspirationActivity.h"
#import "LXInspirationActivityFrame.h"
#import "LXInspirationSectionHeaderView.h"
#import "LXInspirationSectionFooterView.h"
#import "LXInspirationActivityCell.h"
// tableHeaderView
#import "LXTopicItem.h"
#import "LXTopicItemFrame.h"
#import "LXTopicItemCell.h"
// other
#import "AFNetworking.h"
#import "MJExtension.h"

@interface LXInspirationActivityViewController () <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) LXInspirationActivityPage *inspirationActivityPage;
@property (nonatomic, strong) NSArray *inspirationActivityGroups;
@property (nonatomic, strong) NSArray *inspirationActivitys;
@property (nonatomic, strong) NSArray *inspirationActivityFrames;
@end

@implementation LXInspirationActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.inspirationTitle;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(back:)];
    // 注册cell
    [self.tableView registerClass:[LXInspirationActivityCell class] forCellReuseIdentifier:InspirationActivityCell_ID];
    // 加载旅行灵感页数据
    [self loadInspirationActivityViewDatas];
}
// 返回
- (void)back:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 加载旅行灵感页数据
- (void)loadInspirationActivityViewDatas {
    // 1.创建请求管理对象
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    // 2.发送请求
    [manager GET:self.inspirationActivityPage_url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"-----【发现】-----【加载旅行灵感页数据】-----【成功】-----");
        // 将字典数组转为模型数组（里面放的就是LXInspirationActivityPage模型）
        self.inspirationActivityPage = [LXInspirationActivityPage objectWithKeyValues:responseObject[@"data"]];
        // 绑定描述
        if (!self.inspirationActivityPage.desc) {
            self.inspirationActivityPage.desc = responseObject[@"data"][@"description"];
        }
        // 将字典数组转为模型数组（里面放的就是LXInspirationActivityPage模型）
        self.inspirationActivitys = [LXInspirationActivity objectArrayWithKeyValuesArray:responseObject[@"data"][@"inspirations"]];
        // 创建frame模型对象
        NSMutableArray *inspirationActivityFramesArray = [NSMutableArray array];
        for (LXInspirationActivity *inspiration in self.inspirationActivitys) {
            LXInspirationActivityFrame *inspirationFrame = [[LXInspirationActivityFrame alloc] init];
            inspirationFrame.inspiration = inspiration;
            [inspirationActivityFramesArray addObject:inspirationFrame];
        }
        self.inspirationActivityFrames = inspirationActivityFramesArray;
        // 段数
        NSMutableArray *tempArray = [NSMutableArray array];
        for (int i = 0; i < self.inspirationActivitys.count; i++) {
            LXInspirationActivityGroup *group = [[LXInspirationActivityGroup alloc] init];
            if (i == 0) {
                group.isShow = YES;
            }
            [tempArray addObject:group];
        }
        self.inspirationActivityGroups = tempArray;
        if ([self.inspirationActivityPage.desc isKindOfClass:[NSString class]] && ![self.inspirationActivityPage.desc isEqualToString:@""]) {
            // 初始化摘要栏
            [self setupSummaryView];
        }
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"-----【发现】-----【加载旅行灵感页数据】-----【失败】-----");
    }];
}

#pragma mark - 摘要栏
- (void)setupSummaryView {
    LXTopicItemCell *summaryView = [[LXTopicItemCell alloc] init];
    summaryView.backgroundColor = [UIColor whiteColor];
    LXTopicItemFrame *topicItemFrame = [[LXTopicItemFrame alloc] init];
    LXTopicItem *topicItem = [[LXTopicItem alloc] init];
    topicItem.desc = self.inspirationActivityPage.desc;
    topicItemFrame.topicItem = topicItem;
    summaryView.bounds = CGRectMake(0, 0, 0, topicItemFrame.cellHeight);
    summaryView.topicItemFrame = topicItemFrame;
    self.tableView.tableHeaderView = summaryView;
}

#pragma mark - UITableViewDataSource
// 段数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.inspirationActivityFrames.count;
}
// 行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    LXInspirationActivityGroup *group = self.inspirationActivityGroups[section];
    if (group.isShow) {
        return 1;
    }
    return 0;
}
// cell样式
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LXInspirationActivityCell *cell = [LXInspirationActivityCell cellWithTableView:tableView];
    cell.inspirationActivityFrame = self.inspirationActivityFrames[indexPath.section];
    return cell;
}

#pragma mark - UITableViewDelegate
// 行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    LXInspirationActivityFrame *inspirationFrame = self.inspirationActivityFrames[indexPath.section];
    return inspirationFrame.cellHeight;
}
// 段头高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (!section) {
        return inspirationSectionHeaderView_HEIGHT+minimumSpacing;
    }
    return inspirationSectionHeaderView_HEIGHT;
}
// 段尾高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == self.inspirationActivitys.count-1) {
        return inspirationSectionFooterView_HEIGHT+minimumSpacing;
    }
    return inspirationSectionFooterView_HEIGHT;
}
// 段头视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (!section) {
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_WIDTH, inspirationSectionHeaderView_HEIGHT+minimumSpacing)];
        bgView.backgroundColor = bgColor;
        LXInspirationSectionHeaderView *headerView = [LXInspirationSectionHeaderView viewWithFrame:CGRectMake(0, minimumSpacing, screen_WIDTH, inspirationSectionHeaderView_HEIGHT)];
        headerView.section = section;
        headerView.inspiration = self.inspirationActivitys[section];
        headerView.tag = 100 + section;
        // 点击手势
        [headerView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap:)]];
        [bgView addSubview:headerView];
        return bgView;
    }
    LXInspirationSectionHeaderView *headerView = [LXInspirationSectionHeaderView view];
    headerView.section = section;
    headerView.inspiration = self.inspirationActivitys[section];
    headerView.tag = 100 + section;
    // 点击手势
    [headerView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap:)]];
    return headerView;
}
// 段尾视图
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == self.inspirationActivitys.count-1) {
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_WIDTH, inspirationSectionFooterView_HEIGHT+minimumSpacing)];
        bgView.backgroundColor = bgColor;
        LXInspirationSectionFooterView *footerView = [LXInspirationSectionFooterView viewWithFrame:CGRectMake(0, 0, screen_WIDTH, inspirationSectionFooterView_HEIGHT)];
        [bgView addSubview:footerView];
        return bgView;
    }
    LXInspirationSectionFooterView *footerView = [LXInspirationSectionFooterView view];
    return footerView;
}

#pragma mark - 点击手势
- (void)onTap:(UITapGestureRecognizer *)recognizer {
    NSInteger section = recognizer.view.tag - 100;
    LXInspirationActivityGroup *group = self.inspirationActivityGroups[section];
    group.isShow = !group.isShow;
    [self.tableView reloadData];
}

@end
