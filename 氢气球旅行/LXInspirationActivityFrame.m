//
//  LXInspirationActivityFrame.m
//  氢气球旅行
//
//  Created by 曾令轩 on 16/1/5.
//  Copyright © 2016年 曾令轩. All rights reserved.
//

#import "LXInspirationActivityFrame.h"
#import "LXInspirationActivity.h"

@implementation LXInspirationActivityFrame

- (void)setInspiration:(LXInspirationActivity *)inspiration {
    _inspiration = inspiration;
    // 附图
    _contentImgViewFrame = CGRectMake(0, 0, screen_WIDTH, contentImgView_HEIGHT);
    // 介绍
    CGFloat introduceLabelX = InspirationSpacing_Text;
    CGFloat introduceLabelY = CGRectGetMaxY(_contentImgViewFrame)+introduceLabelX;
    CGSize introduceLabelSize = [inspiration.introduce boundingRectWithSize:CGSizeMake(screen_WIDTH-2*introduceLabelX, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:InspirationFont_Introduce} context:nil].size;
    _introduceLabelFrame = (CGRect){{introduceLabelX, introduceLabelY}, introduceLabelSize};
    // 查看详情
    CGFloat detailViewX = introduceLabelX;
    CGFloat detailViewY = CGRectGetMaxY(_introduceLabelFrame)+detailViewX;
    CGFloat detailViewW = screen_WIDTH-2*detailViewX;
    CGFloat detailViewH = detailView_HEIGHT;
    _detailViewFrame = CGRectMake(detailViewX, detailViewY, detailViewW, detailViewH);
    // cell
    CGFloat cellH = CGRectGetMaxY(_detailViewFrame)+InspirationSpacing_Text;
    _cellHeight = cellH;
}

@end
