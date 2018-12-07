//
//  LXHomePageViewController.m
//  氢气球旅行
//
//  Created by 曾令轩 on 15/12/27.
//  Copyright © 2015年 曾令轩. All rights reserved.
//

#import "LXHomePageViewController.h"
#import "LXTravelUserViewController.h"
#import "LXStatusBarView.h"
#import "LXTopic.h"
#import "LXTopicPhoto.h"
#import "LXTableHeaderView.h"
// 主页
#import "LXTravelStatus.h"
#import "LXTravelRecommendUser.h"
#import "LXTravelActivity.h"
#import "LXTravelContent.h"
#import "LXTravelDistrict.h"
#import "LXTravelCategory.h"
#import "LXTravelUser.h"
#import "LXTravelPoi.h"
#import "LXTravelActivityFrame.h"
#import "LXSectionHeaderView.h"
#import "LXSectionFooterView.h"
#import "LXTravelActivityCell.h"
// other
#import "AFNetworking.h"
#import "MJExtension.h"

@interface LXHomePageViewController () <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>
@property (nonatomic, strong) UIApplication *application;
@property (nonatomic, strong) LXStatusBarView *statusBarView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, assign) BOOL statusBarIsIdentity;
@property (nonatomic, strong) NSArray *topics;
@property (nonatomic, strong) NSArray *topicPhotos;
// 主页
@property (nonatomic, strong) NSArray *travelStatuses;
@property (nonatomic, strong) NSArray *travelRecommendUsers;
@property (nonatomic, strong) NSArray *travelActivities;
@property (nonatomic, strong) NSArray *travelContents;
@property (nonatomic, strong) NSArray *travelDistricts;
@property (nonatomic, strong) NSArray *travelCategorys;
@property (nonatomic, strong) NSArray *travelUsers;
@property (nonatomic, strong) NSArray *travelActivitieFrames;
@end

@implementation LXHomePageViewController

- (UIApplication *)application {
    if (_application == nil) {
        _application = [UIApplication sharedApplication];
    }
    return _application;
}

- (LXStatusBarView *)statusBarView {
    if (_statusBarView == nil) {
        _statusBarView = [LXStatusBarView shareStatusBarView];
    }
    return _statusBarView;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.statusBarIsIdentity) {
        if (self.tableView.contentOffset.y >= topicTableHeaderView_HEIGHT-statusBarH) {
            [self showStatusBar];
        }
    }
    self.statusBarIsIdentity = NO;
    // 隐藏导航栏
    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self hideStatusBar];
    self.statusBarIsIdentity = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 注册cell
    [self.tableView registerClass:[LXTravelActivityCell class] forCellReuseIdentifier:TravelActivityCell_ID];
    // 加载主题栏数据
    [self loadTopicViewDatas];
    // 加载主页数据
    [self loadHomePageDatas];
}

#pragma mark - 加载主题栏数据
- (void)loadTopicViewDatas {
    // 1.创建请求管理对象
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    // 2.发送请求
    [manager GET:Topic_URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"-----【游记】-----【加载主题栏数据】-----【成功】-----");
        // 将字典数组转为模型数组（里面放的就是LXTopic模型）
        self.topics = [LXTopic objectArrayWithKeyValuesArray:responseObject[@"data"]];
        // 将字典数组转为模型数组（里面放的就是LXTopicPhoto模型）
        NSMutableArray *tempArray = [NSMutableArray array];
        for (LXTopic *topic in self.topics) {
            if ([topic.photo isKindOfClass:[LXTopicPhoto class]]) {
                [tempArray addObject:topic.photo];
            }
        }
        self.topicPhotos = tempArray;
        // 绑定跳转url
        for (LXTopic *topic in self.topics) {
            if ([topic.ios_url isEqualToString:@""]) {
                NSMutableString *ios_url = [NSMutableString stringWithString:Topic_iOS_URL];
                [ios_url replaceOccurrencesOfString:@"target_id" withString:topic.target_id options:NSLiteralSearch range:NSMakeRange(0, ios_url.length)];
                topic.ios_url = ios_url;
            }
        }
        // 初始化主题栏
        [self setupTopicView];
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"-----【游记】-----【加载主题栏数据】-----【失败】-----");
    }];
}

#pragma mark - 加载主页数据
- (void)loadHomePageDatas {
    // 1.创建请求管理对象
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    // 2.发送请求
    [manager GET:TravelStatus_URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"-----【游记】-----【加载主页数据】-----【成功】-----");
        // 将字典数组转为模型数组（里面放的就是LXTravelStatus模型）
        self.travelStatuses = [LXTravelStatus objectArrayWithKeyValuesArray:responseObject[@"data"]];
        // 绑定描述
        for (int i = 0; i < self.travelStatuses.count; i++) {
            LXTravelStatus *status = self.travelStatuses[i];
            if (!status.activity.desc) {
                NSDictionary *dict = responseObject[@"data"][i];
                status.activity.desc = dict[@"activity"][@"description"];
            }
        }
        // 转化所有模型
        [self translateTotalModel:responseObject];
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"-----【游记】-----【加载主页数据】-----【失败】-----");
    }];
}
// 转化所有模型
- (void)translateTotalModel:(id)responseObject {
    NSMutableArray *recommendUsersArray = [NSMutableArray array];
    NSMutableArray *activitiesArray = [NSMutableArray array];
    NSMutableArray *usersArray = [NSMutableArray array];
    for (LXTravelStatus *status in self.travelStatuses) {
        [recommendUsersArray addObject:status.user];
        [activitiesArray addObject:status.activity];
        self.travelContents = [LXTravelContent objectArrayWithKeyValuesArray:status.activity.contents];
        self.travelDistricts = [LXTravelDistrict objectArrayWithKeyValuesArray:status.activity.districts];
        self.travelCategorys = [LXTravelCategory objectArrayWithKeyValuesArray:status.activity.categories];
        [usersArray addObject:status.activity.user];
    }
    self.travelRecommendUsers = recommendUsersArray;
    self.travelActivities = activitiesArray;
    self.travelUsers = usersArray;
    // 绑定用户id
    for (int i = 0; i < self.travelUsers.count; i++) {
        NSDictionary *dict = responseObject[@"data"][i];
        LXTravelUser *travelUser = self.travelUsers[i];
        if (!travelUser.ID) {
            travelUser.ID = dict[@"activity"][@"user"][@"id"];
        }
    }
    // 创建frame模型对象
    NSMutableArray *travelActivitieFramesArray = [NSMutableArray array];
    for (LXTravelActivity *activity in self.travelActivities) {
        LXTravelActivityFrame *activityFrame = [[LXTravelActivityFrame alloc] init];
        activityFrame.activity = activity;
        [travelActivitieFramesArray addObject:activityFrame];
    }
    self.travelActivitieFrames = travelActivitieFramesArray;
}

#pragma mark - 主题栏
- (void)setupTopicView {
    LXTableHeaderView *tableHeaderView = [LXTableHeaderView viewWithImgDatas:self.topicPhotos];
    tableHeaderView.preCtl = self;
    tableHeaderView.topics = self.topics;
    self.tableView.tableHeaderView = tableHeaderView;
}

#pragma mark - UITableViewDataSource
// 段数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.travelActivitieFrames.count;
}
// 行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
// cell样式
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LXTravelActivityCell *cell = [LXTravelActivityCell cellWithTableView:tableView];
    cell.preCtl = self;
    cell.activityFrame = self.travelActivitieFrames[indexPath.section];
    return cell;
}

#pragma mark - UITableViewDelegate
// 行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    LXTravelActivityFrame *activityFrame = self.travelActivitieFrames[indexPath.section];
    return activityFrame.cellHeight;
}
// 段头高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return travelSectionHeaderView_HEIGHT;
}
// 段尾高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return travelSectionFooterView_HEIGHT;
}
// 段头视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    LXSectionHeaderView *headerView = [[[NSBundle mainBundle] loadNibNamed:@"LXSectionHeaderView" owner:self options:nil] lastObject];
    headerView.user = self.travelUsers[section];
    headerView.recommendUser = self.travelRecommendUsers[section];
    headerView.tag = [headerView.user.ID integerValue];
    [headerView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap:)]];
    return headerView;
}
// 段尾视图
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    LXSectionFooterView *footerView = [[[NSBundle mainBundle] loadNibNamed:@"LXSectionFooterView" owner:self options:nil] lastObject];
    footerView.preCtl = self;
    footerView.section = section;
    footerView.activity = self.travelActivities[section];
    return footerView;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y >= topicTableHeaderView_HEIGHT-statusBarH) {
        if (!self.statusBarIsIdentity) {
            // 设置状态栏的样式（dark）
            self.application.statusBarStyle = UIStatusBarStyleDefault;
            // 显示状态栏
            [self showStatusBar];
        }
        // 内边距（一个状态栏高度）
        scrollView.contentInset = UIEdgeInsetsMake(statusBarH, 0, 0, 0);
    } else {
        if (!self.statusBarIsIdentity) {
            // 设置状态栏的样式（light）
            self.application.statusBarStyle = UIStatusBarStyleLightContent;
            // 隐藏状态栏
            [self hideStatusBar];
        }
        // 内边距（0）
        scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
}

#pragma mark - 状态栏
// 显示状态栏
- (void)showStatusBar {
    self.statusBarView.backgroundColor = bgColor;
    [self.navigationController.navigationBar addSubview:self.statusBarView];
}
// 隐藏状态栏
- (void)hideStatusBar {
    [self.statusBarView removeFromSuperview];
}

#pragma mark - 点击手势
- (void)onTap:(UITapGestureRecognizer *)recognizer {
    LXTravelUserViewController *travelUserCtl = [[LXTravelUserViewController alloc] initWithNibName:@"LXTravelUserViewController" bundle:nil];
    travelUserCtl.userProfile_id = [NSString stringWithFormat:@"%ld", recognizer.view.tag];
    [self.navigationController pushViewController:travelUserCtl animated:YES];
}

@end
