//
//  LXDiscoverViewController.m
//  氢气球旅行
//
//  Created by 曾令轩 on 16/1/1.
//  Copyright © 2016年 曾令轩. All rights reserved.
//

#import "LXDiscoverViewController.h"
#import "LXNavigationController.h"
#import "LXWannaGoSearchViewController.h"
#import "LXWannaGoViewController.h"
#import "LXRecommendTourist.h"
#import "LXRecommendTouristActivity.h"
#import "LXPopDestination.h"
#import "LXRecommendTouristCell.h"
#import "LXPopDestinationCell.h"
#import "AFNetworking.h"
#import "MJExtension.h"

@interface LXDiscoverViewController () <UISearchBarDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *recommendTourists;
@property (nonatomic, strong) NSArray *recommendTouristActivitys;
@property (nonatomic, strong) NSArray *popDestinations;
@end

@implementation LXDiscoverViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.translucent = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 初始化搜索框
    [self setupNavView];
    // 注册cell
    [self.tableView registerClass:[LXRecommendTouristCell class] forCellReuseIdentifier:RecommendTouristCell_ID];
    [self.tableView registerNib:[UINib nibWithNibName:@"LXPopDestinationCell" bundle:nil] forCellReuseIdentifier:PopDestinationCell_ID];
    // 加载发现页数据
    [self loadDiscoverViewDatas];
}
// 初始化搜索框
- (void)setupNavView {
    UIView *searchBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_WIDTH-2*minimumSpacing, toolbarH)];
    self.navigationItem.titleView = searchBarView;
    // 搜索框
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:searchBarView.bounds];
    searchBar.searchBarStyle = UISearchBarStyleMinimal;
    searchBar.layer.cornerRadius = 25;
    searchBar.clipsToBounds = YES;
    searchBar.placeholder = @"我想去...";
    // 字体\颜色
    [[searchBar valueForKey:@"_searchField"] setValue:[UIFont systemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    [[searchBar valueForKey:@"_searchField"] setValue:[UIColor lightTextColor] forKeyPath:@"_placeholderLabel.textColor"];
    searchBar.delegate = self;
    [searchBarView addSubview:searchBar];
}

#pragma mark - 加载发现页数据
- (void)loadDiscoverViewDatas {
    // 1.创建请求管理对象
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    // 2.发送请求
    [manager GET:RecommendTourist_URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"-----【发现】-----【加载发现页数据】-----【成功】-----");
        // 将字典数组转为模型数组（里面放的就是LXRecommendTourist模型）
        self.recommendTourists = [LXRecommendTourist objectArrayWithKeyValuesArray:responseObject[@"data"][@"users"]];
        // 绑定用户id
        NSArray *touristsArray = responseObject[@"data"][@"users"];
        for (int i = 0; i < self.recommendTourists.count; i++) {
            LXRecommendTourist *tourist = self.recommendTourists[i];
            if (!tourist.ID) {
                NSDictionary *dict = touristsArray[i];
                tourist.ID = dict[@"id"];
            }
        }
        // 将字典数组转为模型数组（里面放的就是LXRecommendTouristActivity模型）
        NSMutableArray *tempArray = [NSMutableArray array];
        for (LXRecommendTourist *tourist in self.recommendTourists) {
            [tempArray addObject:tourist.latest_activity];
        }
        self.recommendTouristActivitys = tempArray;
        // 将字典数组转为模型数组（里面放的就是LXPopDestination模型）
        self.popDestinations = [LXPopDestination objectArrayWithKeyValuesArray:responseObject[@"data"][@"destinations"]];
        // 绑定目的地id
        NSArray *destinationsArray = responseObject[@"data"][@"destinations"];
        for (int i = 0; i < self.popDestinations.count; i++) {
            LXPopDestination *destination = self.popDestinations[i];
            if (!destination.ID) {
                NSDictionary *dict = destinationsArray[i];
                destination.ID = dict[@"id"];
            }
        }
        // 分割行数据
        self.popDestinations = [self separateDatasForRow:self.popDestinations];
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"-----【发现】-----【加载发现页数据】-----【失败】-----");
    }];
}
// 分割行数据
- (NSArray *)separateDatasForRow:(NSArray *)popDestinations  {
    NSMutableArray *destinationsArray = [NSMutableArray array];
    static int k = 0;
    int count = 0;
    for (int row = 0; row < PopDestinationCell_ROW; row++) {
        NSMutableArray *tempArray = [NSMutableArray array];
        for (int i = k; i < popDestinations.count; i++) {
            k++;
            [tempArray addObject:popDestinations[i]];
            count++;
            if (count == numberOfItemsInRow) {
                [destinationsArray addObject:tempArray];
                count = 0;
                break;
            }
        }
    }
    return destinationsArray;
}

#pragma mark - UITableViewDataSource
// 段数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
// 行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (!section) {
        return 1;
    }
    return PopDestinationCell_ROW;
}
// cell样式
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!indexPath.section) {
        LXRecommendTouristCell *cell = [LXRecommendTouristCell cellWithTableView:tableView];
        cell.preCtl = self;
        cell.tourists = self.recommendTourists;
        cell.touristActivitys = self.recommendTouristActivitys;
        return cell;
    }
    LXPopDestinationCell *cell = [LXPopDestinationCell cellWithTableView:tableView];
    cell.preCtl = self;
    cell.destinations = self.popDestinations[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate
// 行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!indexPath.section) {
        return touristScrollView_HEIGHT;
    }
    return PopDestinationCell_HEIGHT;
}
// 段头高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return discoverSectionHeaderView_HEIGHT;
}
// 段尾高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return minimumSpacing;
}
// 段头视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor whiteColor];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(minimumSpacing, 0, 100, discoverSectionHeaderView_HEIGHT)];
    if (!section) {
        titleLabel.text = @"推荐旅行家";
    } else {
        titleLabel.text = @"热门目的地";
    }
    titleLabel.font = [UIFont systemFontOfSize:16];
    titleLabel.textColor = [UIColor blackColor];
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

#pragma mark - UISearchBarDelegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    LXWannaGoSearchViewController *wannaGoSearchCtl = [[LXWannaGoSearchViewController alloc] init];
    LXNavigationController *navCtl = [[LXNavigationController alloc] initWithRootViewController:wannaGoSearchCtl];
    [self.navigationController presentViewController:navCtl animated:NO completion:nil];
    return YES;
}

@end
