//
//  LXRecommendTouristCell.m
//  氢气球旅行
//
//  Created by 曾令轩 on 16/1/1.
//  Copyright © 2016年 曾令轩. All rights reserved.
//

#import "LXRecommendTouristCell.h"
#import "LXTravelUserViewController.h"
#import "LXRecommendTourist.h"
#import "LXTouristView.h"

@interface LXRecommendTouristCell ()
@property (nonatomic, weak) UIScrollView *touristScrollView;
@property (nonatomic, strong) NSArray *touristViews;
@end

@implementation LXRecommendTouristCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    return [[[self class] alloc] initWithTableView:tableView];
}

- (instancetype)initWithTableView:(UITableView *)tableView {
    LXRecommendTouristCell *cell = [tableView dequeueReusableCellWithIdentifier:RecommendTouristCell_ID];
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        // 初始化旅行家栏
        [self setupScrollView];
    }
    return self;
}
// 初始化旅行家栏
- (void)setupScrollView {
    // scrollView
    UIScrollView *touristScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, screen_WIDTH, touristScrollView_HEIGHT)];
    touristScrollView.showsHorizontalScrollIndicator = NO;
    [self.contentView addSubview:touristScrollView];
    self.touristScrollView = touristScrollView;
}

- (void)setTourists:(NSArray *)tourists {
    _tourists = tourists;
    if (!self.touristScrollView.contentSize.width) {
        if (tourists) {
            // touristView
            NSMutableArray *tempArray = [NSMutableArray array];
            for (int i = 0; i < self.tourists.count; i++) {
                CGFloat touristViewX = i*(touristView_WIDTH+minimumSpacing)+minimumSpacing;
                LXTouristView *touristView = [[[NSBundle mainBundle] loadNibNamed:@"LXTouristView" owner:self options:nil] lastObject];
                touristView.frame = CGRectMake(touristViewX, 0, touristView_WIDTH, touristView_HEIGHT);
                touristView.layer.borderWidth = 1;
                touristView.layer.borderColor = separateLineColor.CGColor;
                touristView.tourist = self.tourists[i];
                [self.touristScrollView addSubview:touristView];
                touristView.tag = [touristView.tourist.ID integerValue];
                // 点击手势
                [touristView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap:)]];
                touristView.userInteractionEnabled = YES;
                [tempArray addObject:touristView];
            }
            self.touristViews = tempArray;
            self.touristScrollView.contentSize = CGSizeMake(self.tourists.count*(touristView_WIDTH+minimumSpacing)+minimumSpacing, touristScrollView_HEIGHT);
        }
    }
}

- (void)setTouristActivitys:(NSArray *)touristActivitys {
    _touristActivitys = touristActivitys;
    if (touristActivitys) {
        for (int i = 0; i < self.touristViews.count; i++) {
            LXTouristView *touristView = self.touristViews[i];
            touristView.activity = self.touristActivitys[i];
        }
    }
}

#pragma mark - 点击手势
- (void)onTap:(UITapGestureRecognizer *)recognizer {
    LXTravelUserViewController *travelUserCtl = [[LXTravelUserViewController alloc] initWithNibName:@"LXTravelUserViewController" bundle:nil];
    travelUserCtl.userProfile_id = [NSString stringWithFormat:@"%ld", recognizer.view.tag];
    [self.preCtl.navigationController pushViewController:travelUserCtl animated:YES];
}

@end
