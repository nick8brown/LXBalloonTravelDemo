//
//  LXActivityMapViewController.m
//  氢气球旅行
//
//  Created by 曾令轩 on 16/1/10.
//  Copyright © 2016年 曾令轩. All rights reserved.
//

#import "LXActivityMapViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "LXTravelUserViewController.h"
#import "LXPersonalViewController.h"
#import "LXActivityAnnotation.h"
#import "LXActivityAnnotationView.h"
// 描述
#import "LXTabBarButton.h"
#import "LXTravelActivity.h"
#import "LXUserActivityDistrict.h"
#import "LXActivityDescSectionHeaderView.h"
#import "LXActivityDescCell.h"
// other
#import "MJExtension.h"

@interface LXActivityMapViewController () <MKMapViewDelegate, UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UIApplication *application;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UIView *descView;
@property (weak, nonatomic) IBOutlet UIView *districtView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, assign) BOOL navigationBarIsIdentity;
@property (nonatomic, strong) LXTravelActivity *travelActivity;
@end

@implementation LXActivityMapViewController

- (UIApplication *)application {
    if (_application == nil) {
        _application = [UIApplication sharedApplication];
    }
    return _application;
}

- (void)setTravelActivity:(LXTravelActivity *)travelActivity {
    _travelActivity = travelActivity;
    [self.tableView reloadData];
}

- (void)viewWillAppear:(BOOL)animated {
    self.application.statusBarStyle = UIStatusBarStyleDefault;
    if (!self.isNavigationBarHide) {
        [self hideNavigationBar];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    self.application.statusBarStyle = UIStatusBarStyleLightContent;
    if (self.navigationBarIsIdentity) {
        [self showNavigationBar];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 初始化导航栏
    [self setupNavView];
    // 注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"LXActivityDescCell" bundle:nil] forCellReuseIdentifier:ActivityDescCell_ID];
    // 初始化地图
    [self setupMapView];
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
    self.navigationBarIsIdentity = YES;
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
}
// 初始化导航栏
- (void)setupNavView {
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 35, 35);
    backBtn.imageView.layer.cornerRadius = backBtn.frame.size.width*0.5;
    backBtn.imageView.clipsToBounds = YES;
    [backBtn setImage:[UIImage imageNamed:@"back_1"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
}
// 返回
- (void)back:(UIButton *)sender {
    NSUInteger count = self.navigationController.viewControllers.count;
    UIViewController *vc = [self.navigationController.viewControllers objectAtIndex:count-2];
    if ([vc isKindOfClass:[LXTravelUserViewController class]]) {
        LXTravelUserViewController *travelUserCtl = (LXTravelUserViewController *)vc;
        travelUserCtl.isNavigationBarHide = self.isNavigationBarHide;
        [self.navigationController popToViewController:travelUserCtl animated:YES];
    } else if ([vc isKindOfClass:[LXPersonalViewController class]]) {
        LXPersonalViewController *personalCtl = (LXPersonalViewController *)vc;
        personalCtl.isNavigationBarHide = self.isNavigationBarHide;
        [self.navigationController popToViewController:personalCtl animated:YES];
    }
}

#pragma mark - 地图
- (void)setupMapView {
    for (NSArray *array in self.travelActivitys) {
        for (LXTravelActivity *travelActivity in array) {
            LXActivityAnnotation *activityAnnotation = [[LXActivityAnnotation alloc] init];
            activityAnnotation.activity = travelActivity;
            [self.mapView addAnnotation:activityAnnotation];
        }
    }
}

#pragma mark - MKMapViewDelegate
// 大头针view样式
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    if ([annotation isKindOfClass:[LXActivityAnnotation class]]) {
        // 创建大头针view
        LXActivityAnnotationView *activityAnnotationView = [LXActivityAnnotationView annotationViewWithMapView:mapView];
        // 传递模型
        activityAnnotationView.annotation = annotation;
        return activityAnnotationView;
    }
    return nil;
}
// 选中某大头针
- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    if ([view isKindOfClass:[LXActivityAnnotationView class]]) {
        self.descView.hidden = !self.descView.hidden;
        LXActivityAnnotation *activityAnnotation = (LXActivityAnnotation *)view.annotation;
        // 初始化旅行地点标签视图
        [self setupDistrictViewWithDistrict:[[LXUserActivityDistrict objectArrayWithKeyValuesArray:activityAnnotation.activity.districts] lastObject]];
        self.travelActivity = activityAnnotation.activity;
    }
}

#pragma mark - 旅行地点标签视图
- (void)setupDistrictViewWithDistrict:(LXUserActivityDistrict *)district {
    UILabel *districtLabel = [self.districtView viewWithTag:DistrictLabel_TAG];
    districtLabel.text = [NSString stringWithFormat:@"%@游记", district.name];
    LXTabBarButton *closeBtn = [self.districtView viewWithTag:CloseBtn_TAG];
    closeBtn.layer.cornerRadius = closeBtn.frame.size.width*0.5;
    closeBtn.clipsToBounds = YES;
}

#pragma mark - UITableViewDataSource
// 段数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
// 行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
// cell样式
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LXActivityDescCell *cell = [LXActivityDescCell cellWithTableView:tableView];
    cell.activity = self.travelActivity;
    return cell;
}

#pragma mark - UITableViewDelegate
// 行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return ActivityDescCell_HEIGHT;
}
// 段头高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return activityDescSectionHeaderView_HEIGHT;
}
// 段尾高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return activityDescSectionFooterView_HEIGHT;
}
// 段头视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    LXActivityDescSectionHeaderView *headerView = [LXActivityDescSectionHeaderView view];
    headerView.activity = self.travelActivity;
    return headerView;
}
// 段尾视图
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] init];
}

#pragma mark - IBAction
- (IBAction)closeBtnClick:(LXTabBarButton *)sender {
    self.descView.hidden = !self.descView.hidden;
}

@end
