//
//  LXTravelActivityCell.m
//  氢气球旅行
//
//  Created by 曾令轩 on 15/12/28.
//  Copyright © 2015年 曾令轩. All rights reserved.
//

#import "LXTravelActivityCell.h"
#import "LXNavigationController.h"
#import "LXPhotoAlbumViewController.h"
#import "LXTravelActivity.h"
#import "LXTravelContent.h"
#import "LXTravelDistrict.h"
#import "LXTravelCategory.h"
#import "LXTravelActivityFrame.h"
#import "UIImageView+WebCache.h"

@interface LXTravelActivityCell ()
// 大图
@property (nonatomic, weak) UIImageView *contentImgView;
// 附图
@property (nonatomic, weak) UIScrollView *contentScrollView;
// 主题
@property (nonatomic, weak) UILabel *topicLabel;
// 描述
@property (nonatomic, weak) UILabel *descLabel;
// 展开全文
@property (nonatomic, weak) UIButton *unfoldBtn;
// 标签
@property (nonatomic, weak) UIScrollView *markScrollView;

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSArray *made_atsArray;
@end

@implementation LXTravelActivityCell

- (NSArray *)made_atsArray {
    if (_made_atsArray == nil) {
        _made_atsArray = @[@"一月", @"二月", @"三月", @"四月", @"五月", @"六月", @"七月", @"八月", @"九月", @"十月", @"十一月", @"十二月"];
    }
    return _made_atsArray;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    return [[[self class] alloc] initWithTableView:tableView];
}

- (instancetype)initWithTableView:(UITableView *)tableView {
    LXTravelActivityCell *cell = [tableView dequeueReusableCellWithIdentifier:TravelActivityCell_ID];
    self.tableView = tableView;
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        // 添加游记内部的子控件
        [self setupSubviews];
    }
    return self;
}
// 添加游记内部的子控件
- (void)setupSubviews {
    // 大图
    UIImageView *contentImgView = [[UIImageView alloc] init];
    contentImgView.tag = 100;
        // 点击手势
    [contentImgView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(contentImgViewOnTap:)]];
    contentImgView.userInteractionEnabled = YES;
    [self.contentView addSubview:contentImgView];
    self.contentImgView = contentImgView;
    // 附图
    UIScrollView *contentScrollView = [[UIScrollView alloc] init];
    [self.contentView addSubview:contentScrollView];
    self.contentScrollView = contentScrollView;
    // 主题
    UILabel *topicLabel = [[UILabel alloc] init];
    topicLabel.font = ActivityFont_Topic;
    topicLabel.textAlignment = NSTextAlignmentLeft;
    topicLabel.numberOfLines = 0;
    topicLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [self.contentView addSubview:topicLabel];
    self.topicLabel = topicLabel;
    // 描述
    UILabel *descLabel = [[UILabel alloc] init];
    descLabel.font = ActivityFont_Desc;
    descLabel.textAlignment = NSTextAlignmentLeft;
    descLabel.numberOfLines = 0;
    descLabel.lineBreakMode = NSLineBreakByWordWrapping;
        // 点击手势
    [descLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(descLabelOnTap:)]];
    descLabel.userInteractionEnabled = YES;
    [self.contentView addSubview:descLabel];
    self.descLabel = descLabel;
    // 展开全文
    UIButton *unfoldBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    unfoldBtn.titleLabel.font = ActivityFont_Unfold;
    [unfoldBtn setTitleColor:mainThemeColor forState:UIControlStateNormal];
    unfoldBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
    [unfoldBtn setTitle:@"...展开全文" forState:UIControlStateNormal];
    [unfoldBtn addTarget:self action:@selector(unfoldBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:unfoldBtn];
    self.unfoldBtn = unfoldBtn;
    // 标签
    UIScrollView *markScrollView = [[UIScrollView alloc] init];
    [self.contentView addSubview:markScrollView];
    self.markScrollView = markScrollView;
}
// 展开全文
- (void)unfoldBtnClick:(UIButton *)sender {
#warning todo 展开全文
}

- (void)setActivityFrame:(LXTravelActivityFrame *)activityFrame {
    _activityFrame = activityFrame;
    LXTravelActivity *activity = self.activityFrame.activity;
    NSArray *contentsArray = self.activityFrame.travelContents;
    NSArray *districtsArray = self.activityFrame.travelDistricts;
    NSArray *categorysArray = self.activityFrame.travelCategorys;
    // 大图
    self.contentImgView.frame = self.activityFrame.contentImgViewFrame;
    LXTravelContent *content = [contentsArray firstObject];
    [self.contentImgView setImageWithURL:[NSURL URLWithString:content.photo_url] placeholderImage:[UIImage imageNamed:photo_placeholder]];
    // 附图
    self.contentScrollView.frame = self.activityFrame.contentScrollViewFrame;
    [self setupContentScrollViewWithContentsArray:contentsArray];
    // 主题
    self.topicLabel.frame = self.activityFrame.topicLabelFrame;
    self.topicLabel.text = activity.topic;
    // 描述
    self.descLabel.frame = self.activityFrame.descLabelFrame;
    self.descLabel.text = activity.desc;
    // 展开全文
    self.unfoldBtn.frame = self.activityFrame.unfoldBtnFrame;
    // 标签
    self.markScrollView.frame = self.activityFrame.markScrollViewFrame;
    [self setupMarkScrollViewWithActivity:activity districtsArray:districtsArray categorysArray:categorysArray];
}

#pragma mark - 附图
- (void)setupContentScrollViewWithContentsArray:(NSArray *)contentsArray {
    // 移除子控件
    for (UIImageView *imageView in self.contentScrollView.subviews) {
        [imageView removeFromSuperview];
    }
    // imageView
    CGFloat imageViewY = 0;
    CGFloat imageViewW = 150;
    CGFloat imageViewH = self.contentScrollView.frame.size.height;
    for (int i = 1; i < contentsArray.count; i++) {
        CGFloat imageViewX = (i-1)*(imageViewW+ActivitySpacing_Content);
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(imageViewX, imageViewY, imageViewW, imageViewH)];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        LXTravelContent *content = contentsArray[i];
        [imageView setImageWithURL:[NSURL URLWithString:content.photo_url] placeholderImage:[UIImage imageNamed:photo_placeholder]];
        imageView.tag = 100 + i;
        // 点击手势
        [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(contentImgViewOnTap:)]];
        imageView.userInteractionEnabled = YES;
        [self.contentScrollView addSubview:imageView];
    }
    self.contentScrollView.contentSize = CGSizeMake((contentsArray.count-1)*imageViewW+(contentsArray.count-2)*ActivitySpacing_Content, imageViewH);
    self.contentScrollView.contentOffset = CGPointMake(0, 0);
    self.contentScrollView.showsHorizontalScrollIndicator = NO;
}

#pragma mark - 标签
- (void)setupMarkScrollViewWithActivity:(LXTravelActivity *)activity districtsArray:(NSArray *)districtsArray categorysArray:(NSArray *)categorysArray {
    NSArray *marksArray = [self addMarksWithActivity:activity districtsArray:districtsArray categorysArray:categorysArray];
    // 移除子控件
    for (UIButton *btn in self.markScrollView.subviews) {
        [btn removeFromSuperview];
    }
    // btn
    UIButton *preBtn;
    CGFloat btnX = 0;
    CGFloat btnY = 0.6*minimumSpacing;
    CGFloat btnH = self.markScrollView.frame.size.height-2*btnY;
    for (int i = 0; i < marksArray.count; i++) {
        CGFloat btnW = [marksArray[i] boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, self.markScrollView.frame.size.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:ActivityFont_Mark} context:nil].size.width+1.5*minimumSpacing;
        if (CGRectGetMaxX(preBtn.frame)) {
            btnX = CGRectGetMaxX(preBtn.frame)+minimumSpacing;
        }
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        btn.backgroundColor = bgColor;
        btn.layer.cornerRadius = 12;
        btn.clipsToBounds = YES;
        btn.titleLabel.font = ActivityFont_Mark;
        [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [btn setTitle:marksArray[i] forState:UIControlStateNormal];
        [self.markScrollView addSubview:btn];
        preBtn = btn;
    }
    if (CGRectGetMaxX(preBtn.frame) <= self.markScrollView.frame.size.width) {
        self.markScrollView.contentSize = CGSizeMake(self.markScrollView.frame.size.width+0.1*minimumSpacing, btnH);
    } else {
        self.markScrollView.contentSize = CGSizeMake(CGRectGetMaxX(preBtn.frame), btnH);
    }
    self.markScrollView.contentOffset = CGPointMake(0, 0);
    self.markScrollView.showsHorizontalScrollIndicator = NO;
}
// 返回标签数组
- (NSArray *)addMarksWithActivity:(LXTravelActivity *)activity districtsArray:(NSArray *)districtsArray categorysArray:(NSArray *)categorysArray {
    NSMutableArray *marksArray = [NSMutableArray array];
    for (LXTravelDistrict *district in districtsArray) {
        [marksArray addObject:district.name];
    }
    for (LXTravelCategory *category in categorysArray) {
        [marksArray addObject:category.name];
    }
    if ([activity.made_at isKindOfClass:[NSString class]] && ![activity.made_at isEqualToString:@""]) {
        [marksArray addObject:[self markStringFromMade_at:activity.made_at]];
    }
    return marksArray;
}
// 返回月份标签
- (NSString *)markStringFromMade_at:(NSString *)made_at {
    made_at = [made_at substringFromIndex:[made_at rangeOfString:@"-"].location+1];
    made_at = [made_at substringToIndex:[made_at rangeOfString:@"-"].location];
    for (int i = 1; i <= self.made_atsArray.count; i++) {
        if ([made_at intValue] == i) {
            return self.made_atsArray[i-1];
        }
    }
    return nil;
}

#pragma mark - 点击手势
// 附图
- (void)contentImgViewOnTap:(UITapGestureRecognizer *)recognizer {
    LXPhotoAlbumViewController *photoAlbumCtl = [[LXPhotoAlbumViewController alloc] initWithNibName:@"LXPhotoAlbumViewController" bundle:nil];
    photoAlbumCtl.contentsArray = self.activityFrame.travelContents;
    photoAlbumCtl.currentPage = recognizer.view.tag - 100;
    LXNavigationController *navCtl = [[LXNavigationController alloc] initWithRootViewController:photoAlbumCtl];
    [self.preCtl presentViewController:navCtl animated:NO completion:nil];
}
// 描述
- (void)descLabelOnTap:(UITapGestureRecognizer *)recognizer {
#warning todo 展开全文
}

@end
