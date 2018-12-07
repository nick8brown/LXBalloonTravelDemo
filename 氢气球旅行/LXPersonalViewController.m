//
//  LXPersonalViewController.m
//  氢气球旅行
//
//  Created by 曾令轩 on 16/1/7.
//  Copyright © 2016年 曾令轩. All rights reserved.
//

#import "LXPersonalViewController.h"
#import "LXUserProfile.h"
#import "LXUserProfileHeader_photo.h"
#import "LXProfileBGView.h"
// Sudoku
#import "LXSudokuActivityTableViewCell.h"
// BigPhoto
#import "LXTravelActivityFrame.h"
#import "LXSectionFooterView.h"
#import "LXTravelActivityCell.h"
// TimeList
#import "LXUserActivity.h"
#import "LXLocationDistrict.h"
#import "LXTravelActivity.h"
#import "LXUserActivityDistrict.h"
#import "LXActivitySectionHeaderView.h"
#import "LXActivitySectionFooterView.h"
#import "LXActivitySectionFooterView_Unfold.h"
#import "LXTimeListActivityCell.h"
// other
#import "AFNetworking.h"
#import "MJExtension.h"

@interface LXPersonalViewController () <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) LXProfileBGView *profileBGView;
@property (nonatomic, strong) LXUserProfile *userProfile;
@property (nonatomic, assign) NSInteger pageMode;
@property (nonatomic, strong) NSArray *userActivitys;
@property (nonatomic, strong) NSArray *travelActivitys;
@property (nonatomic, strong) NSArray *sortedTravelActivitys;
@property (nonatomic, strong) NSArray *sortedTravelActivityFrames;
@end

@implementation LXPersonalViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 添加监听，动态观察tableView的contentOffset的改变
    [self.tableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    if (!self.isNavigationBarHide) {
        [self hideNavigationBar];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.tableView removeObserver:self forKeyPath:@"contentOffset"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    // tableView内边距
    self.tableView.contentInset = UIEdgeInsetsMake(ProfileBGView_edgeInset_TOP, 0, 0, 0);
    // 注册cell
    [self.tableView registerClass:[LXSudokuActivityTableViewCell class] forCellReuseIdentifier:SudokuActivityTableViewCell_ID];
    [self.tableView registerClass:[LXTravelActivityCell class] forCellReuseIdentifier:TravelActivityCell_ID];
    [self.tableView registerNib:[UINib nibWithNibName:@"LXTimeListActivityCell" bundle:nil] forCellReuseIdentifier:TimeListActivityCell_ID];
    // 监听通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(switchPage:) name:BTN_CLICK object:nil];
    // 加载个人资料相关数据
    [self loadUserProfileViewDatas];
    // 加载游记页数据
    [self loadUserActivityPageDatas];
}

#pragma mark - tableView滚动
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"contentOffset"]) {
        CGPoint offset = [change[NSKeyValueChangeNewKey] CGPointValue];
        CGFloat minimum_offset_TOP = navigationBarH+toolbarH;
        /*
         tableView内边距为ProfileBGView_HEIGHT，(0,0)坐标系向下偏移
         offset.y为负的ProfileBGView_HEIGHT这么高
         */
        CGFloat offset_TOP = -offset.y-ProfileBGView_HEIGHT;
        CGRect newFrame = CGRectMake(0, 0, screen_WIDTH, ProfileBGView_HEIGHT);
        if (-offset.y < ProfileBGView_HEIGHT) {// (一开始就)上拉
            if (-offset.y <= minimum_offset_TOP) {// 上拉边界
                newFrame.origin.y = minimum_offset_TOP-ProfileBGView_HEIGHT;
                self.tableView.contentInset = UIEdgeInsetsMake(navigationBarH+toolbarH, 0, 0, 0);
                // 显示导航栏
                [self showNavigationBar];
            } else {
                newFrame.origin.y = offset_TOP;
                self.tableView.contentInset = UIEdgeInsetsMake(ProfileBGView_edgeInset_TOP, 0, 0, 0);
                // 隐藏导航栏
                [self hideNavigationBar];
            }
            self.profileBGView.frame = newFrame;
        } else {// (一开始就)下拉
#warning todo 下拉刷新
        }
    }
}

#pragma mark - 导航栏
// 显示导航栏
- (void)showNavigationBar {
    self.isNavigationBarHide = NO;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navBar_ProfileBGView_375.jpg"] forBarMetrics:UIBarMetricsDefault];
}
// 隐藏导航栏
- (void)hideNavigationBar {
    self.isNavigationBarHide = YES;
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
}

#pragma mark - 通知
// 切换tableView游记页
- (void)switchPage:(NSNotification *)notification {
    self.pageMode = [notification.userInfo[sender_tag] integerValue];
    [self.tableView reloadData];
}

#pragma mark - 加载个人资料相关数据
- (void)loadUserProfileViewDatas {
    // 1.创建请求管理对象
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    // 2.创建URL
    NSMutableString *urlStr = [NSMutableString stringWithString:UserProfile_URL];
    [urlStr replaceOccurrencesOfString:@"ID" withString:[NSString stringWithFormat:@"%@", UserProfile_ID] options:NSLiteralSearch range:NSMakeRange(0, urlStr.length)];
    // 3.发送请求
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"-----【我的】-----【加载个人资料相关数据】-----【成功】-----");
        // 将字典数组转为模型数组（里面放的就是LXUserProfile模型）
        self.userProfile = [LXUserProfile objectWithKeyValues:responseObject[@"data"]];
        // 初始化个人资料背景
        [self setupProfileBGView];
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"-----【我的】-----【加载个人资料相关数据】-----【失败】-----");
    }];
}

#pragma mark - 加载游记页数据
- (void)loadUserActivityPageDatas {
    // 1.创建请求管理对象
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    // 2.创建URL
    NSMutableString *urlStr = [NSMutableString stringWithString:UserActivity_URL];
    [urlStr replaceOccurrencesOfString:@"ID" withString:[NSString stringWithFormat:@"%@", UserProfile_ID] options:NSLiteralSearch range:NSMakeRange(0, urlStr.length)];
    // 3.发送请求
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"-----【我的】-----【加载游记页数据】-----【成功】-----");
        // 将字典数组转为模型数组（里面放的就是LXUserActivity模型）
        self.userActivitys = [LXUserActivity objectArrayWithKeyValuesArray:responseObject[@"data"]];
        // 将字典数组转为模型数组（里面放的就是LXTravelActivity模型）
        NSMutableArray *tempArray = [NSMutableArray array];
        for (NSDictionary *dict in responseObject[@"data"]) {
            [tempArray addObject:[LXTravelActivity objectArrayWithKeyValuesArray:dict[@"activities"]]];
        }
        self.travelActivitys = tempArray;
        self.profileBGView.travelActivitys = self.travelActivitys;
        // 排序（最近更新在前）
        NSMutableArray *tempArray2 = [NSMutableArray array];
        for (NSArray *array in self.travelActivitys) {
            for (LXTravelActivity *travelActivity in array) {
                [tempArray2 addObject:travelActivity];
            }
        }
        [tempArray2 sortUsingComparator:^NSComparisonResult(LXTravelActivity *travelActivity1, LXTravelActivity *travelActivity2) {
            return [travelActivity2.created_at compare:travelActivity1.created_at];
        }];
        self.sortedTravelActivitys = tempArray2;
        // 创建frame模型对象
        NSMutableArray *sortedTravelActivityFramesArray = [NSMutableArray array];
        for (int i = 0; i < self.sortedTravelActivitys.count; i++) {
            LXTravelActivityFrame *activityFrame = [[LXTravelActivityFrame alloc] init];
            activityFrame.activity = self.sortedTravelActivitys[i];
            [sortedTravelActivityFramesArray addObject:activityFrame];
        }
        self.sortedTravelActivityFrames = sortedTravelActivityFramesArray;
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"-----【我的】-----【加载游记页数据】-----【失败】-----");
    }];
}

#pragma mark - 个人资料背景
- (void)setupProfileBGView {
    LXProfileBGView *profileBGView = [LXProfileBGView viewWithUserProfile:self.userProfile];
    profileBGView.frame = CGRectMake(0, 0, screen_WIDTH, ProfileBGView_HEIGHT);
    profileBGView.preCtl = self;
    [self.view addSubview:profileBGView];
    self.profileBGView = profileBGView;
}

#pragma mark - UITableViewDataSource
// 段数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.pageMode == Sudoku_TAG) {
        return 1;
    } else if (self.pageMode == TimeList_TAG) {
        return self.userActivitys.count;
    }
    return self.sortedTravelActivityFrames.count;
}
// 行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.pageMode == Sudoku_TAG) {
        return 1;
    } else if (self.pageMode == TimeList_TAG) {
        if ([self.travelActivitys[section] count] > maximum_numberOfRowsInSection) {
            return maximum_numberOfRowsInSection;
        }
        return [self.travelActivitys[section] count];
    }
    return 1;
}
// cell样式
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.pageMode == Sudoku_TAG) {
        LXSudokuActivityTableViewCell *cell = [LXSudokuActivityTableViewCell cellWithTableView:tableView];
        cell.activitys = self.sortedTravelActivitys;
        return cell;
    } else if (self.pageMode == TimeList_TAG) {
        LXTimeListActivityCell *cell = [LXTimeListActivityCell cellWithTableView:tableView];
        cell.activity = self.travelActivitys[indexPath.section][indexPath.row];
        return cell;
    }
    LXTravelActivityCell *cell = [LXTravelActivityCell cellWithTableView:tableView];
    cell.preCtl = self;
    cell.activityFrame = self.sortedTravelActivityFrames[indexPath.section];
    return cell;
}

#pragma mark - UITableViewDelegate
// 行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.pageMode == Sudoku_TAG) {
        return [self cellHeightWithNumberOfItemsInCollectionView:self.sortedTravelActivitys.count];
    } else if (self.pageMode == TimeList_TAG) {
        return TimeListActivityCell_HEIGHT;
    }
    LXTravelActivityFrame *activityFrame = self.sortedTravelActivityFrames[indexPath.section];
    return activityFrame.cellHeight;
}
// 返回行高
- (CGFloat)cellHeightWithNumberOfItemsInCollectionView:(NSInteger)count {
    NSInteger row = 0;
    if (iPhone5s) {
        if (count%numberOfItemsInRow_iPhone5s) {
            row = count/numberOfItemsInRow_iPhone5s+1;
        } else {
            row = count/numberOfItemsInRow_iPhone5s;
        }
        return row*((screen_WIDTH-(numberOfItemsInRow_iPhone5s-1)*minimumInteritemSpacing_iPhone5s)/numberOfItemsInRow_iPhone5s)+(row-1)*minimumInteritemSpacing_iPhone5s;
    } else {
        if (count%numberOfItemsInRow_iPhone6s) {
            row = count/numberOfItemsInRow_iPhone6s+1;
        } else {
            row = count/numberOfItemsInRow_iPhone6s;
        }
        if (iPhone6s) {
            return row*((screen_WIDTH-(numberOfItemsInRow_iPhone6s-1)*minimumInteritemSpacing_iPhone6s)/numberOfItemsInRow_iPhone6s)+(row-1)*minimumInteritemSpacing_iPhone6s;
        } else {
            return row*((screen_WIDTH-(numberOfItemsInRow_iPhone6sPlus-1)*minimumInteritemSpacing_iPhone6sPlus)/numberOfItemsInRow_iPhone6sPlus)+(row-1)*minimumInteritemSpacing_iPhone6sPlus;
        }
    }
}
// 段头高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (self.pageMode == Sudoku_TAG) {
        return CGFLOAT_MIN;
    } else if (self.pageMode == TimeList_TAG) {
        return activitySectionHeaderView_HEIGHT;
    }
    return CGFLOAT_MIN;
}
// 段尾高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (self.pageMode == Sudoku_TAG) {
        return minimumSpacing;
    } else if (self.pageMode == TimeList_TAG) {
        if ([self.travelActivitys[section] count] > 3) {
            return activitySectionFooterView_Unfold_HEIGHT;
        }
        return activitySectionFooterView_HEIGHT;
    }
    return travelSectionFooterView_HEIGHT;
}
// 段头视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (self.pageMode == Sudoku_TAG) {
        return [[UIView alloc] init];
    } else if (self.pageMode == TimeList_TAG) {
        LXActivitySectionHeaderView *headerView = [LXActivitySectionHeaderView view];
        LXUserActivity *userActivity = self.userActivitys[section];
        headerView.location = userActivity.district;
        return headerView;
    }
    return [[UIView alloc] init];
}
// 段尾视图
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (self.pageMode == Sudoku_TAG) {
        UIView *footerView = [[UIView alloc] init];
        footerView.backgroundColor = bgColor;
        return footerView;
    } else if (self.pageMode == TimeList_TAG) {
        if ([self.travelActivitys[section] count] > 3) {
            LXActivitySectionFooterView_Unfold *footerView = [LXActivitySectionFooterView_Unfold view];
            return footerView;
        }
        LXActivitySectionFooterView *footerView = [LXActivitySectionFooterView view];
        return footerView;
    }
    LXSectionFooterView *footerView = [[[NSBundle mainBundle] loadNibNamed:@"LXSectionFooterView" owner:self options:nil] lastObject];
    footerView.preCtl = self;
    footerView.section = section;
    footerView.activity = self.sortedTravelActivitys[section];
    return footerView;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
