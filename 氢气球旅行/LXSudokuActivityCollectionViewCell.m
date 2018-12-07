//
//  LXSudokuActivityCollectionViewCell.m
//  氢气球旅行
//
//  Created by 曾令轩 on 16/1/12.
//  Copyright © 2016年 曾令轩. All rights reserved.
//

#import "LXSudokuActivityCollectionViewCell.h"
#import "LXTravelActivity.h"
#import "LXTravelContent.h"
#import "UIImageView+WebCache.h"
#import "MJExtension.h"

@interface LXSudokuActivityCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *contentImgView;
@end

@implementation LXSudokuActivityCollectionViewCell

+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath {
    return [[[self class] alloc] initWithCollectionView:collectionView indexPath:indexPath];
}

- (instancetype)initWithCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath {
    if (self = [super init]) {
        self = [collectionView dequeueReusableCellWithReuseIdentifier:SudokuActivityCollectionViewCell_ID forIndexPath:indexPath];
    }
    return self;
}

- (void)setActivity:(LXTravelActivity *)activity {
    _activity = activity;
    self.contentImgView.contentMode = UIViewContentModeScaleAspectFill;
    self.contentImgView.clipsToBounds = YES;
    LXTravelContent *content = [[LXTravelContent objectArrayWithKeyValuesArray:activity.contents] firstObject];
    [self.contentImgView setImageWithURL:[NSURL URLWithString:content.photo_url] placeholderImage:[UIImage imageNamed:photo_placeholder]];
}

@end
