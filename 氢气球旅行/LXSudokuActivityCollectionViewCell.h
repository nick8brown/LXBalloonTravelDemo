//
//  LXSudokuActivityCollectionViewCell.h
//  氢气球旅行
//
//  Created by 曾令轩 on 16/1/12.
//  Copyright © 2016年 曾令轩. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LXTravelActivity;

@interface LXSudokuActivityCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) LXTravelActivity *activity;

+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath;
- (instancetype)initWithCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath;
@end
