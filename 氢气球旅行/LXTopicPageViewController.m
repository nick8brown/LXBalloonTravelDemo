//
//  LXTopicPageViewController.m
//  氢气球旅行
//
//  Created by 曾令轩 on 15/12/31.
//  Copyright © 2015年 曾令轩. All rights reserved.
//

#import "LXTopicPageViewController.h"
#import "LXTopic.h"
#import "LXTopicPage.h"
#import "LXTopicItem.h"
#import "LXTopicItemFrame.h"
#import "LXTravelActivity.h"
#import "LXTravelActivityFrame.h"
#import "LXSectionHeaderView.h"
#import "LXSectionFooterView.h"
#import "LXTopicItemCell.h"
#import "LXTravelActivityCell.h"
#import "AFNetworking.h"
#import "MJExtension.h"

@interface LXTopicPageViewController ()
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) LXTopicPage *topicPage;
@property (nonatomic, strong) NSArray *topicItems;
@property (nonatomic, strong) NSArray *topicItemFrames;
@property (nonatomic, strong) NSArray *travelActivities;
@property (nonatomic, strong) NSArray *travelActivitieFrames;
@end

@implementation LXTopicPageViewController

- (NSArray *)travelActivities {
    if (_travelActivities == nil) {
        NSMutableArray *tempArray = [NSMutableArray array];
        for (int i = 1; i < self.topicItems.count; i = i+2) {
            LXTopicItem *topicItem = self.topicItems[i];
            LXTravelActivity *activity = [LXTravelActivity objectWithKeyValues:topicItem.user_activity];
            // 绑定描述
            if (!activity.desc) {
                NSDictionary *dict = topicItem.user_activity;
                activity.desc = dict[@"description"];
            }
            [tempArray addObject:activity];
        }
        _travelActivities = tempArray;
    }
    return _travelActivities;
}

- (NSArray *)travelActivitieFrames {
    if (_travelActivitieFrames == nil) {
        // 创建frame模型对象
        NSMutableArray *travelActivitieFramesArray = [NSMutableArray array];
        for (int i = 0; i < self.topicItemFrames.count; i++) {
            [travelActivitieFramesArray addObject:@(-1)];
        }
        int k = 0;
        for (int i = 1; i < travelActivitieFramesArray.count; i = i+2, k++) {
            LXTravelActivityFrame *activityFrame = [[LXTravelActivityFrame alloc] init];
            activityFrame.activity = self.travelActivities[k];
            [travelActivitieFramesArray replaceObjectAtIndex:i withObject:activityFrame];
        }
        _travelActivitieFrames = travelActivitieFramesArray;
    }
    return _travelActivitieFrames;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 设置背景图片
    NSString *bgName = nil;
    if (iPhone5s) {
        bgName = @"navBar_0_320";
    } else {
        bgName = @"navBar_0_375";
    }
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:bgName] forBarMetrics:UIBarMetricsDefault];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"氢专题";
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(back:)];
    self.navigationItem.leftBarButtonItem = leftItem;
    self.navigationController.navigationBar.translucent = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // 注册cell
    [self.tableView registerClass:[LXTopicItemCell class] forCellReuseIdentifier:TopicItemCell_ID];
    [self.tableView registerClass:[LXTravelActivityCell class] forCellReuseIdentifier:TravelActivityCell_ID];
    // 加载氢专题数据
    [self loadTopicPageDatas];
}
// 返回
- (void)back:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 加载氢专题数据
- (void)loadTopicPageDatas {
    // 1.创建请求管理对象
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    LXTopic *topic = self.topics[self.page];
    if ([topic.ios_url rangeOfString:@"html"].location == NSNotFound) {
        // 2.发送请求
        [manager GET:topic.ios_url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"-----【游记】-----【加载氢专题数据】-----【成功】-----");
            // 将字典数组转为模型数组（里面放的就是LXTopicPage模型）
            self.topicPage = [LXTopicPage objectWithKeyValues:responseObject[@"data"]];
            // 将字典数组转为模型数组（里面放的就是LXTopicItem模型）
            self.topicItems = [LXTopicItem objectArrayWithKeyValuesArray:responseObject[@"data"][@"items"]];
            // 绑定描述
            for (int i = 0; i < self.topicItems.count; i++) {
                LXTopicItem *topicItem = self.topicItems[i];
                if (!topicItem.desc) {
                    NSDictionary *dict = responseObject[@"data"][@"items"][i];
                    topicItem.desc = dict[@"description"];
                }
            }
            // 创建frame模型对象
            NSMutableArray *topicItemFramesArray = [NSMutableArray array];
            for (LXTopicItem *topicItem in self.topicItems) {
                LXTopicItemFrame *topicItemFrame = [[LXTopicItemFrame alloc] init];
                topicItemFrame.topicItem = topicItem;
                [topicItemFramesArray addObject:topicItemFrame];
            }
            self.topicItemFrames = topicItemFramesArray;
            // 初始化摘要栏
            [self setupSummaryView];
            [self.tableView reloadData];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"-----【游记】-----【加载氢专题数据】-----【失败】-----");
        }];
    }
}

#pragma mark - 摘要栏
- (void)setupSummaryView {
    LXTopicItemCell *summaryView = [[LXTopicItemCell alloc] init];
    summaryView.backgroundColor = [UIColor whiteColor];
    LXTopicItemFrame *topicItemFrame = [[LXTopicItemFrame alloc] init];
    LXTopicItem *topicItem = [[LXTopicItem alloc] init];
    topicItem.title = self.topicPage.title;
    topicItem.desc = self.topicPage.summary;
    topicItemFrame.topicItem = topicItem;
    summaryView.bounds = CGRectMake(0, 0, 0, topicItemFrame.cellHeight);
    summaryView.topicItemFrame = topicItemFrame;
    self.tableView.tableHeaderView = summaryView;
}

#pragma mark - UITableViewDataSource
// 段数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.topicItemFrames.count;
}
// 行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
// cell样式
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger evenSection = indexPath.section%2;
    if (!evenSection) {
        LXTopicItemCell *cell = [LXTopicItemCell cellWithTableView:tableView];
        cell.topicItemFrame = self.topicItemFrames[indexPath.section];
        return cell;
    }
    LXTravelActivityCell *cell = [LXTravelActivityCell cellWithTableView:tableView];
    cell.preCtl = self;
    cell.activityFrame = self.travelActivitieFrames[indexPath.section];
    return cell;
}

#pragma mark - UITableViewDelegate
// 行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger evenSection = indexPath.section%2;
    if (!evenSection) {
        LXTopicItemFrame *topicItemFrame = self.topicItemFrames[indexPath.section];
        return topicItemFrame.cellHeight;
    }
    LXTravelActivityFrame *activityFrame = self.travelActivitieFrames[indexPath.section];
    return activityFrame.cellHeight;
}
// 段头高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    NSInteger evenSection = section%2;
    if (!evenSection) {
        if (!section) {
            return minimumSpacing;
        }
        return CGFLOAT_MIN;
    }
    return travelSectionHeaderView_HEIGHT;
}
// 段尾高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    NSInteger evenSection = section%2;
    if (!evenSection) {
        if (section == self.topicItemFrames.count-1) {
            return CGFLOAT_MIN;
        }
        return minimumSpacing;
    }
    return travelSectionFooterView_HEIGHT;
}
// 段头视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    NSInteger evenSection = section%2;
    if (!evenSection) {
        if (!section) {
            UIView *headerView = [[UIView alloc] init];
            headerView.backgroundColor = bgColor;
            return headerView;
        }
        return [[UIView alloc] init];
    }
    LXSectionHeaderView *headerView = [[[NSBundle mainBundle] loadNibNamed:@"LXSectionHeaderView" owner:self options:nil] lastObject];
#warning todo 此处段数暂用0示例，另外推荐用户需隐藏
    LXTravelActivity *travelActivity = self.travelActivities[0];
    headerView.user = travelActivity.user;
    return headerView;
}
// 段尾视图
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    NSInteger evenSection = section%2;
    if (!evenSection) {
        if (section == self.topicItemFrames.count-1) {
            return [[UIView alloc] init];
        }
        UIView *footerView = [[UIView alloc] init];
        footerView.backgroundColor = bgColor;
        return footerView;
    }
    LXSectionFooterView *footerView = [[[NSBundle mainBundle] loadNibNamed:@"LXSectionFooterView" owner:self options:nil] lastObject];
#warning todo 此处段数暂用0示例
    footerView.preCtl = self;
    footerView.section = 0;
    footerView.activity = self.travelActivities[0];
    return footerView;
}

@end
