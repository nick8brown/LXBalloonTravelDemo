//
//  LXWannaGoViewController.m
//  氢气球旅行
//
//  Created by 曾令轩 on 16/1/3.
//  Copyright © 2016年 曾令轩. All rights reserved.
//

#import "LXWannaGoViewController.h"
#import "LXTopicDestinationViewController.h"
#import "LXWannaGoPage.h"
#import "LXWannaGoDestination.h"
#import "LXTravelActivity.h"
#import "LXTravelUser.h"
#import "LXWannaGoHitted_destination.h"
#import "LXWannaGoDestinationCell.h"
#import "LXWannaGoUserActivityCell.h"
#import "LXWannaGoUserCell.h"
#import "UIImageView+WebCache.h"
#import "AFNetworking.h"
#import "MJExtension.h"

@interface LXWannaGoViewController () <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, assign) NSInteger sections;
@property (nonatomic, strong) NSMutableArray *titleArray;
@property (nonatomic, strong) NSMutableArray *rowArray;
@property (nonatomic, strong) NSMutableArray *indexArray;
@property (nonatomic, strong) LXWannaGoPage *wannaGoPage;
@property (nonatomic, strong) NSArray *wannaGoDestinations;
@property (nonatomic, strong) NSArray *wannaGoUser_activitys;
@property (nonatomic, strong) NSArray *wannaGoUser_activityGroups;
@property (nonatomic, strong) NSArray *wannaGoUsers;
@property (nonatomic, strong) LXWannaGoHitted_destination *wannaGoHitted_destination;
@end

@implementation LXWannaGoViewController

- (NSMutableArray *)titleArray {
    if (_titleArray == nil) {
        _titleArray = [NSMutableArray array];
    }
    return _titleArray;
}

- (NSMutableArray *)rowArray {
    if (_rowArray == nil) {
        _rowArray = [NSMutableArray array];
    }
    return _rowArray;
}

- (NSMutableArray *)indexArray {
    if (_indexArray == nil) {
        _indexArray = [NSMutableArray array];
    }
    return _indexArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 初始化搜索框
    [self setupNavView];
    // 注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"LXWannaGoDestinationCell" bundle:nil] forCellReuseIdentifier:WannaGoDestinationCell_ID];
    [self.tableView registerClass:[LXWannaGoUserActivityCell class] forCellReuseIdentifier:WannaGoUserActivityCell_ID];
    [self.tableView registerNib:[UINib nibWithNibName:@"LXWannaGoUserCell" bundle:nil] forCellReuseIdentifier:WannaGoUserCell_ID];
    // 加载我想去页数据
    [self loadWannaGoViewDatas];
}
// 初始化搜索框
- (void)setupNavView {
    // 搜索框
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, screen_WIDTH-80, toolbarH)];
    searchBar.layer.cornerRadius = 15;
    searchBar.clipsToBounds = YES;
    searchBar.placeholder = @"我想去...";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:searchBar];
    // 取消
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancel:)];
}
// 取消
- (void)cancel:(UIBarButtonItem *)sender {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 加载我想去页数据
- (void)loadWannaGoViewDatas {
    // 1.创建请求管理对象
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    // 2.发送请求
    [manager GET:self.wannaGoPage_url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"-----【发现】-----【加载我想去页数据】-----【成功】-----");
        // 将字典数组转为模型数组（里面放的就是LXWannaGoPage模型）
        self.wannaGoPage = [LXWannaGoPage objectWithKeyValues:responseObject[@"data"]];
        // 将字典数组转为模型数组（里面放的就是LXWannaGoDestination模型）
        self.wannaGoDestinations = [LXWannaGoDestination objectArrayWithKeyValuesArray:responseObject[@"data"][@"destinations"]];
        // 绑定攻略id
        NSArray *destinationsArray = responseObject[@"data"][@"destinations"];
        for (int i = 0; i < self.wannaGoDestinations.count; i++) {
            LXWannaGoDestination *destination = self.wannaGoDestinations[i];
            if (!destination.ID) {
                NSDictionary *dict = destinationsArray[i];
                destination.ID = dict[@"id"];
            }
        }
        // 将字典数组转为模型数组（里面放的就是LXTravelActivity模型）
        self.wannaGoUser_activitys = [LXTravelActivity objectArrayWithKeyValuesArray:responseObject[@"data"][@"user_activities"]];
        // 绑定描述
        for (int i = 0; i < self.wannaGoUser_activitys.count; i++) {
            LXTravelActivity *travelActivity = self.wannaGoUser_activitys[i];
            if (!travelActivity.desc) {
                NSDictionary *dict = responseObject[@"data"][@"user_activities"][i];
                travelActivity.desc = dict[@"description"];
            }
        }
        // 创建group模型对象
        NSMutableArray *tempArray = [NSMutableArray array];
        for (int i = 0; i < self.wannaGoUser_activitys.count; i++) {
            LXWannaGoUserActivityGroup *userActivityGroup = [[LXWannaGoUserActivityGroup alloc] init];
            userActivityGroup.activity = self.wannaGoUser_activitys[i];
            [tempArray addObject:userActivityGroup];
        }
        self.wannaGoUser_activityGroups = tempArray;
        // 将字典数组转为模型数组（里面放的就是LXTravelUser模型）
        self.wannaGoUsers = [LXTravelUser objectArrayWithKeyValuesArray:responseObject[@"data"][@"users"]];
        // 将字典数组转为模型数组（里面放的就是LXWannaGoHitted_destination模型）
        self.wannaGoHitted_destination = [LXWannaGoHitted_destination objectWithKeyValues:responseObject[@"data"][@"hitted_destination"]];
        // 计算tableView段数
        self.sections = [self numberOfSectionsWithDestinations:self.wannaGoDestinations user_activitys:self.wannaGoUser_activitys users:self.wannaGoUsers];
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"-----【发现】-----【加载我想去页数据】-----【失败】-----");
    }];
}
// 计算tableView段数
- (NSInteger)numberOfSectionsWithDestinations:(NSArray *)destinations user_activitys:(NSArray *)user_activitys users:(NSArray *)users {
    return [self countSectionsWithPreSections:[self countSectionsWithPreSections:[self countSectionsWithPreSections:0 datas:destinations] datas:user_activitys] datas:users];
}
// 返回段数\(某段)对应标题、行数
- (NSInteger)countSectionsWithPreSections:(NSInteger)sections datas:(NSArray *)datas {
    static int k = 0;
    if (k == 3) {
        k = 0;
    }
    k++;
    if (datas.count) {
        sections += 1;
        [self.indexArray addObject:@(k)];
        switch (k) {
            case 1:
                {
                    [self.titleArray addObject:@"目的地攻略"];
                    [self.rowArray addObject:self.wannaGoDestinations];
                }
                break;
            case 2:
                {
                    [self.titleArray addObject:@"相关氢游记"];
                    [self.rowArray addObject:self.wannaGoUser_activitys];
                }
                break;
            case 3:
                {
                    [self.titleArray addObject:@"相关用户"];
                    [self.rowArray addObject:self.wannaGoUsers];
                }
                break;
        }
    }
    return sections;
}

#pragma mark - UITableViewDataSource
// 段数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sections;
}
// 行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.rowArray[section] count];
}
// cell样式
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger index = [self.indexArray[indexPath.section] integerValue];
    if (index == 1) {
        LXWannaGoDestinationCell *cell = [LXWannaGoDestinationCell cellWithTableView:tableView];
        cell.destination = self.wannaGoDestinations[indexPath.row];
        return cell;
    } else if (index == 2) {
        LXWannaGoUserActivityCell *cell = [LXWannaGoUserActivityCell cellWithTableView:tableView];
        cell.indexPath = indexPath;
        cell.block = ^(NSIndexPath *indexPath){
            [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        };
        [cell configCellWithModel:self.wannaGoUser_activityGroups[indexPath.row]];
        return cell;
    }
    LXWannaGoUserCell *cell = [LXWannaGoUserCell cellWithTableView:tableView];
    cell.user = self.wannaGoUsers[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate
// 行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger index = [self.indexArray[indexPath.section] integerValue];
    if (index == 1) {
        return WannaGoDestinationCell_HEIGHT;
    } else if (index == 2) {
        return [LXWannaGoUserActivityCell heightWithModel:self.wannaGoUser_activityGroups[indexPath.row]];
    }
    return WannaGoUserCell_HEIGHT;
}
// 段头高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return wannaGoSectionHeaderView_HEIGHT;
}
// 段尾高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return minimumSpacing;
}
// 段头视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor whiteColor];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(1.5*minimumSpacing, 0.5*minimumSpacing, 100, wannaGoSectionHeaderView_HEIGHT)];
    titleLabel.text = self.titleArray[section];
    titleLabel.font = [UIFont systemFontOfSize:16];
    titleLabel.textColor = [UIColor lightGrayColor];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    [headerView addSubview:titleLabel];
    return headerView;
}
// 段尾视图
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *footerView = [[UIView alloc] init];
    footerView.backgroundColor = bgColor;
    return footerView;
}
// 选中某行
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger index = [self.indexArray[indexPath.section] integerValue];
    if (index == 1) {
        LXWannaGoDestination *destination = self.wannaGoDestinations[indexPath.row];
        // 创建URL
        NSMutableString *urlStr = [NSMutableString stringWithString:TopicDestination_URL];
        [urlStr replaceOccurrencesOfString:@"ID" withString:[NSString stringWithFormat:@"%@", destination.ID] options:NSLiteralSearch range:NSMakeRange(0, urlStr.length)];
        LXTopicDestinationViewController *topicDestinationCtl = [[LXTopicDestinationViewController alloc] initWithNibName:@"LXTopicDestinationViewController" bundle:nil];
        topicDestinationCtl.topicTitle = destination.name;
        topicDestinationCtl.topicDestination_url = urlStr;
        [self.navigationController pushViewController:topicDestinationCtl animated:YES];
    }
}

@end
