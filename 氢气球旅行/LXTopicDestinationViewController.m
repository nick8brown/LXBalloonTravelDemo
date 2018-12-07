//
//  LXTopicDestinationViewController.m
//  氢气球旅行
//
//  Created by 曾令轩 on 16/1/4.
//  Copyright © 2016年 曾令轩. All rights reserved.
//

#import "LXTopicDestinationViewController.h"
#import "LXInspirationActivityViewController.h"
#import "LXTopicDestination.h"
#import "LXTopicDestinationCell.h"
#import "AFNetworking.h"
#import "MJExtension.h"

@interface LXTopicDestinationViewController () <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *topicDestinations;
@end

@implementation LXTopicDestinationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = [NSString stringWithFormat:@"%@攻略", self.topicTitle];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(back:)];
    // 注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"LXTopicDestinationCell" bundle:nil] forCellReuseIdentifier:TopicDestinationCell_ID];
    // 加载主题攻略页数据
    [self loadTopicDestinationViewDatas];
}
// 返回
- (void)back:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 加载主题攻略页数据
- (void)loadTopicDestinationViewDatas {
    // 1.创建请求管理对象
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    // 2.发送请求
    [manager GET:self.topicDestination_url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"-----【发现】-----【加载主题攻略页数据】-----【成功】-----");
        // 将字典数组转为模型数组（里面放的就是LXTopicDestination模型）
        self.topicDestinations = [LXTopicDestination objectArrayWithKeyValuesArray:responseObject[@"data"]];
        // 绑定主题攻略id
        NSArray *destinationsArray = responseObject[@"data"];
        for (int i = 0; i < self.topicDestinations.count; i++) {
            LXTopicDestination *destination = self.topicDestinations[i];
            if (!destination.ID) {
                NSDictionary *dict = destinationsArray[i];
                destination.ID = dict[@"id"];
            }
        }
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"-----【发现】-----【加载主题攻略页数据】-----【失败】-----");
    }];
}

#pragma mark - UITableViewDataSource
// 段数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
// 行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.topicDestinations.count;
}
// cell样式
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LXTopicDestinationCell *cell = [LXTopicDestinationCell cellWithTableView:tableView];
    cell.destination = self.topicDestinations[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate
// 选中某行
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    LXTopicDestination *destination = self.topicDestinations[indexPath.row];
    // 创建URL
    NSMutableString *urlStr = [NSMutableString stringWithString:InspirationActivityPage_URL];
    [urlStr replaceOccurrencesOfString:@"ID" withString:[NSString stringWithFormat:@"%@", destination.ID] options:NSLiteralSearch range:NSMakeRange(0, urlStr.length)];
    LXInspirationActivityViewController *inspirationActivityCtl = [[LXInspirationActivityViewController alloc] initWithNibName:@"LXInspirationActivityViewController" bundle:nil];
    inspirationActivityCtl.inspirationTitle = destination.topic;
    inspirationActivityCtl.inspirationActivityPage_url = urlStr;
    [self.navigationController pushViewController:inspirationActivityCtl animated:YES];
}

@end
