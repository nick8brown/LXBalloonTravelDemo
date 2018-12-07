//
//  LXTravelActivityFrame.m
//  氢气球旅行
//
//  Created by 曾令轩 on 15/12/28.
//  Copyright © 2015年 曾令轩. All rights reserved.
//

#import "LXTravelActivityFrame.h"
#import "LXTravelActivity.h"
#import "LXTravelContent.h"
#import "LXTravelDistrict.h"
#import "LXTravelCategory.h"
#import "MJExtension.h"

@implementation LXTravelActivityFrame

- (NSArray *)travelContents {
    if (_travelContents == nil) {
        _travelContents = [LXTravelContent objectArrayWithKeyValuesArray:self.activity.contents];
    }
    return _travelContents;
}

- (NSArray *)travelDistricts {
    if (_travelDistricts == nil) {
        _travelDistricts = [LXTravelDistrict objectArrayWithKeyValuesArray:self.activity.districts];
    }
    return _travelDistricts;
}

- (NSArray *)travelCategorys {
    if (_travelCategorys == nil) {
        _travelCategorys = [LXTravelCategory objectArrayWithKeyValuesArray:self.activity.categories];
    }
    return _travelCategorys;
}

- (void)setActivity:(LXTravelActivity *)activity {
    _activity = activity;
    // 大图
    CGFloat contentImgViewW = screen_WIDTH;
    LXTravelContent *content = [self.travelContents firstObject];
    CGFloat contentImgViewH = [content.height floatValue]/[content.width floatValue]*contentImgViewW;
    _contentImgViewFrame = CGRectMake(0, 0, contentImgViewW, contentImgViewH);
    // 附图
    CGFloat contentScrollViewY = CGRectGetMaxY(_contentImgViewFrame)+ActivitySpacing_Content;
    CGFloat contentScrollViewW = screen_WIDTH;
    CGFloat contentScrollViewH = 80;
    _contentScrollViewFrame = CGRectMake(0, contentScrollViewY, contentScrollViewW, contentScrollViewH);
    // 主题
    CGFloat topicLabelX = ActivitySpacing_Text;
    CGFloat topicLabelY = CGRectGetMaxY(_contentScrollViewFrame)+topicLabelX;
    CGSize topicLabelSize = [activity.topic boundingRectWithSize:CGSizeMake(screen_WIDTH-2*topicLabelX, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:ActivityFont_Topic} context:nil].size;
    _topicLabelFrame = (CGRect){{topicLabelX, topicLabelY}, topicLabelSize};
    // 描述
    CGFloat descLabelX = topicLabelX;
    CGFloat descLabelY = CGRectGetMaxY(_topicLabelFrame)+descLabelX;
    CGSize descLabelSize;
#warning todo 文字长度待改
    if (activity.desc.length > 170) {
        descLabelSize = CGSizeMake(screen_WIDTH-2*descLabelX, 120);
        _descLabelFrame = (CGRect){{descLabelX, descLabelY}, descLabelSize};
        // 展开全文
        CGFloat unfoldBtnX = descLabelX;
        CGFloat unfoldBtnY = CGRectGetMaxY(_descLabelFrame)+minimumSpacing;
        CGSize unfoldBtnSize = [@"...展开全文" boundingRectWithSize:CGSizeMake(screen_WIDTH-2*unfoldBtnX, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:ActivityFont_Unfold} context:nil].size;
        _unfoldBtnFrame = (CGRect){{unfoldBtnX, unfoldBtnY}, unfoldBtnSize};
    } else {
        descLabelSize = [activity.desc boundingRectWithSize:CGSizeMake(screen_WIDTH-2*descLabelX, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:ActivityFont_Desc} context:nil].size;
        _descLabelFrame = (CGRect){{descLabelX, descLabelY}, descLabelSize};
    }
    // 标签
    CGFloat markScrollViewX = descLabelX;
    CGFloat markScrollViewY;
    if (_unfoldBtnFrame.size.width) {
        markScrollViewY = CGRectGetMaxY(_unfoldBtnFrame)+markScrollViewX;
    } else {
        markScrollViewY = CGRectGetMaxY(_descLabelFrame)+markScrollViewX;
    }
    CGFloat markScrollViewW = screen_WIDTH-2*markScrollViewX;
    CGFloat markScrollViewH = 40;
    _markScrollViewFrame = CGRectMake(markScrollViewX, markScrollViewY, markScrollViewW, markScrollViewH);
    // cell
    CGFloat cellH = CGRectGetMaxY(_markScrollViewFrame)+ActivitySpacing_Text;
    _cellHeight = cellH;
}

@end
