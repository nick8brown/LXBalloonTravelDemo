//
//  LXPhotoAlbumViewController.m
//  氢气球旅行
//
//  Created by 曾令轩 on 15/12/30.
//  Copyright © 2015年 曾令轩. All rights reserved.
//

#import "LXPhotoAlbumViewController.h"
#import "LXTravelContent.h"
#import "UIImageView+WebCache.h"

@interface LXPhotoAlbumViewController () <UIScrollViewDelegate>
@property (nonatomic, strong) UIApplication *application;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (nonatomic, assign) BOOL preStatusBarStyle;
@property (nonatomic, strong) UIScrollView *albumScrollView;
@end

@implementation LXPhotoAlbumViewController

- (UIApplication *)application {
    if (_application == nil) {
        _application = [UIApplication sharedApplication];
    }
    return _application;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.application.statusBarStyle = self.preStatusBarStyle;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.preStatusBarStyle = self.application.statusBarStyle;
    self.application.statusBarStyle = UIStatusBarStyleDefault;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBarHidden = YES;
    // 初始化照片墙
    [self setupAlbumView];
}

#pragma mark - 照片墙
- (void)setupAlbumView {
    // pageControl
    self.pageControl.numberOfPages = self.contentsArray.count;
    self.pageControl.currentPage = self.currentPage;
    self.pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    [self.pageControl addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pageControlOnTap:)]];
    // albumScrollView
    CGFloat albumScrollViewX = 0;
    CGFloat albumScrollViewY = CGRectGetMaxY(self.pageControl.frame);
    CGFloat albumScrollViewW = screen_WIDTH;
    CGFloat albumScrollViewH = screen_HEIGHT-albumScrollViewY;
    self.albumScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(albumScrollViewX, albumScrollViewY, albumScrollViewW, albumScrollViewH)];
    self.albumScrollView.contentSize = CGSizeMake(self.contentsArray.count*screen_WIDTH, albumScrollViewH);
    self.albumScrollView.showsHorizontalScrollIndicator = NO;
    self.albumScrollView.pagingEnabled = YES;
    [self.albumScrollView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(albumScrollViewOnTap:)]];
    self.albumScrollView.contentOffset = CGPointMake(self.pageControl.currentPage*screen_WIDTH, 0);
    self.albumScrollView.delegate = self;
    [self.view addSubview:self.albumScrollView];
        // imageView
    CGFloat imageViewY = 0;
    CGFloat imageViewW = screen_WIDTH;
    CGFloat imageViewH = albumScrollViewH-tabBarH;
        // captionView
    CGFloat captionViewY = imageViewH;
    CGFloat captionViewW = imageViewW;
    CGFloat captionViewH = tabBarH;
    for (int i = 0; i < self.contentsArray.count; i++) {
        CGFloat imageViewX = i*imageViewW;
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(imageViewX, imageViewY, imageViewW, imageViewH)];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        LXTravelContent *content = self.contentsArray[i];
        [imageView setImageWithURL:[NSURL URLWithString:content.photo_url]];
        [self.albumScrollView addSubview:imageView];
        // captionView
        if ([content.caption isKindOfClass:[NSString class]]) {
            CGFloat captionViewX = i*captionViewW;
            UIView *captionView = [[UIView alloc] initWithFrame:CGRectMake(captionViewX, captionViewY, captionViewW, captionViewH)];
            captionView.backgroundColor = [UIColor darkTextColor];
            // captionLabel
            UILabel *captionLabel = [[UILabel alloc] initWithFrame:CGRectMake(minimumSpacing, 0, captionViewW-2*minimumSpacing, captionViewH)];
            captionLabel.text = content.caption;
            captionLabel.font = [UIFont systemFontOfSize:14];
            captionLabel.textColor = [UIColor whiteColor];
            captionLabel.textAlignment = NSTextAlignmentLeft;
            captionLabel.numberOfLines = 0;
            captionLabel.lineBreakMode = NSLineBreakByWordWrapping;
            [captionView addSubview:captionLabel];
            [self.albumScrollView addSubview:captionView];
        }
    }
}

#pragma mark - UIScrollViewDelegate
// 减速完成（scrollView停止滚动）
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger currentPage = scrollView.contentOffset.x/screen_WIDTH;
    self.pageControl.currentPage = currentPage;
}

#pragma mark - 点击手势
// pageControl
- (void)pageControlOnTap:(UITapGestureRecognizer *)recognizer {
    [self dismissViewControllerAnimated:NO completion:nil];
}
// albumScrollView
- (void)albumScrollViewOnTap:(UITapGestureRecognizer *)recognizer {
    [self dismissViewControllerAnimated:NO completion:nil];
}

@end
