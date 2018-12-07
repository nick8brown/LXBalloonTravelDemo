//
//  LXTableHeaderView.m
//  礼物说
//
//  Created by 曾令轩 on 15/11/27.
//  Copyright © 2015年 曾令轩. All rights reserved.
//

#import "LXTableHeaderView.h"
#import "LXTopicPageViewController.h"
#import "LXTopic.h"
#import "LXTopicPhoto.h"
#import "UIImageView+WebCache.h"

@interface LXTableHeaderView () <UIScrollViewDelegate>
@property (nonatomic, strong) NSArray *topicPhotos;
@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, weak) UIPageControl *pageControl;
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation LXTableHeaderView

+ (instancetype)viewWithImgDatas:(NSArray *)imgDatas {
    return [[[self class] alloc] initWithImgDatas:imgDatas];
}

- (instancetype)initWithImgDatas:(NSArray *)imgDatas {
    self.topicPhotos = imgDatas;
    return [self initWithFrame:CGRectMake(0, 0, screen_WIDTH, topicTableHeaderView_HEIGHT)];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // scrollView
        [self createScrollView];
    }
    return self;
}

#pragma mark - 滚动视图
- (void)createScrollView {
    // scrollView
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.frame];
    scrollView.contentSize = CGSizeMake(self.topicPhotos.count*screen_WIDTH, topicTableHeaderView_HEIGHT);
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    [self addSubview:scrollView];
    self.scrollView = scrollView;
    // imageView
    for (int i = 0; i < self.topicPhotos.count; i++) {
        CGFloat imageViewY = 0;
        CGFloat imageViewW = screen_WIDTH;
        CGFloat imageViewH = topicTableHeaderView_HEIGHT;
        CGFloat imageViewX = i*imageViewW;
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(imageViewX, imageViewY, imageViewW, imageViewH)];
        LXTopicPhoto *photo = self.topicPhotos[i];
        [imageView setImageWithURL:[NSURL URLWithString:photo.photo_url]];
        imageView.tag = 100 + i;
        // 点击手势
        [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap:)]];
        imageView.userInteractionEnabled = YES;
        [scrollView addSubview:imageView];
    }
    // pageControl
    CGFloat pageControlW = 100;
    CGFloat pageControlH = 30;
    CGFloat pageControlX = (screen_WIDTH-pageControlW)*0.5;
    CGFloat pageControlY = CGRectGetMaxY(scrollView.frame)-pageControlH;
    UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(pageControlX, pageControlY, pageControlW, pageControlH)];
    pageControl.numberOfPages = self.topicPhotos.count;
    pageControl.currentPage = 0;
    pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    [pageControl addTarget:self action:@selector(pageChange:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:pageControl];
    self.pageControl = pageControl;
    // timer
    self.timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(showAD) userInfo:nil repeats:YES];
}
// 点击手势
- (void)onTap:(UITapGestureRecognizer *)recognizer {
    LXTopicPageViewController *topicPageCtl = [[LXTopicPageViewController alloc] initWithNibName:@"LXTopicPageViewController" bundle:nil];
    topicPageCtl.page = recognizer.view.tag - 100;
    topicPageCtl.topics = self.topics;
    [self.preCtl.navigationController pushViewController:topicPageCtl animated:YES];
}
// pageControl
- (void)pageChange:(UIPageControl *)pageControl {
    NSInteger currentPage = pageControl.currentPage;
    self.scrollView.contentOffset = CGPointMake(currentPage*screen_WIDTH, 0);
}
// timer
- (void)showAD {
    NSInteger currentPage = (self.pageControl.currentPage+1)%self.topicPhotos.count;
    [UIView animateWithDuration:0.5 animations:^{
        self.scrollView.contentOffset = CGPointMake(currentPage*screen_WIDTH, 0);
        self.pageControl.currentPage = currentPage;
    }];
}

#pragma mark - UIScrollViewDelegate
// 当手指点击scrollView时（准备滑动）
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if ([self.timer isValid]) {
        [self.timer invalidate];
        self.timer = nil;
    }
}
// 减速完成（scrollView停止滚动）
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger currentPage = scrollView.contentOffset.x/screen_WIDTH;
    self.pageControl.currentPage = currentPage;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(showAD) userInfo:nil repeats:YES];
}

@end
