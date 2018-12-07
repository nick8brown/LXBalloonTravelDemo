//
//  LXPopDestinationCell.m
//  氢气球旅行
//
//  Created by 曾令轩 on 16/1/2.
//  Copyright © 2016年 曾令轩. All rights reserved.
//

#import "LXPopDestinationCell.h"
#import "LXNavigationController.h"
#import "LXWannaGoViewController.h"
#import "LXPopDestination.h"
#import "UIImageView+WebCache.h"

@interface LXPopDestinationCell ()
@property (weak, nonatomic) IBOutlet UIView *destinationView_0;
@property (weak, nonatomic) IBOutlet UIView *destinationView_1;
@property (weak, nonatomic) IBOutlet UIView *destinationView_2;
@property (nonatomic, strong) NSArray *destinationViews;
@end

@implementation LXPopDestinationCell

- (NSArray *)destinationViews {
    if (_destinationViews == nil) {
        _destinationViews = [NSMutableArray arrayWithObjects:self.destinationView_0, self.destinationView_1, self.destinationView_2, nil];
        for (int i = 0; i < _destinationViews.count; i++) {
            UIView *destinationView = _destinationViews[i];
            destinationView.tag = 1000 + i;
            // 点击手势
            [destinationView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap:)]];
        }
    }
    return _destinationViews;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    return [[[self class] alloc] initWithTableView:tableView];
}

- (instancetype)initWithTableView:(UITableView *)tableView {
    if (self = [super init]) {
        self = [tableView dequeueReusableCellWithIdentifier:PopDestinationCell_ID];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setDestinations:(NSArray *)destinations {
    _destinations = destinations;
    if (destinations) {
        for (int i = 0; i < self.destinations.count; i++) {
            UIView *destinationView = self.destinationViews[i];
            LXPopDestination *destination = self.destinations[i];
            UIImageView *coverImgView = [destinationView viewWithTag:PopDestinationCell_Cover_TAG];
            [coverImgView setImageWithURL:[NSURL URLWithString:destination.photo_url] placeholderImage:[UIImage imageNamed:photo_placeholder]];
            UILabel *nameLabel = [destinationView viewWithTag:PopDestinationCell_Name_TAG];
            nameLabel.text = destination.name;
            UILabel *name_enLabel = [destinationView viewWithTag:PopDestinationCell_Name_en_TAG];
            name_enLabel.text = destination.name_en;
        }
    }
}

#pragma mark - 点击手势
- (void)onTap:(UITapGestureRecognizer *)recognizer {
    LXPopDestination *destination = self.destinations[recognizer.view.tag-1000];
    // 创建URL
    NSMutableString *urlStr = [NSMutableString stringWithString:PopDestination_URL];
    [urlStr replaceOccurrencesOfString:@"ID" withString:[NSString stringWithFormat:@"%@", destination.ID] options:NSLiteralSearch range:NSMakeRange(0, urlStr.length)];
    LXWannaGoViewController *wannaGoCtl = [[LXWannaGoViewController alloc] init];
    wannaGoCtl.wannaGoPage_url = urlStr;
    LXNavigationController *navCtl = [[LXNavigationController alloc] initWithRootViewController:wannaGoCtl];
    [self.preCtl presentViewController:navCtl animated:NO completion:nil];
}

@end
