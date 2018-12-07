//
//  LXTopicItemFrame.m
//  氢气球旅行
//
//  Created by 曾令轩 on 15/12/31.
//  Copyright © 2015年 曾令轩. All rights reserved.
//

#import "LXTopicItemFrame.h"
#import "LXTopicItem.h"

@implementation LXTopicItemFrame

- (void)setTopicItem:(LXTopicItem *)topicItem {
    _topicItem = topicItem;
    // 标题
    CGFloat titleLabelX = ItemSpacing_Text;
    CGFloat titleLabelY = titleLabelX ;
    CGSize titleLabelSize = [topicItem.title boundingRectWithSize:CGSizeMake(screen_WIDTH-2*titleLabelX, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:ItemFont_Title} context:nil].size;
    _titleLabelFrame = (CGRect){{titleLabelX, titleLabelY}, titleLabelSize};
    // 描述
    CGFloat descLabelX = titleLabelX;
    CGFloat descLabelY = CGRectGetMaxY(_titleLabelFrame)+descLabelX;
    CGSize descLabelSize = [topicItem.desc boundingRectWithSize:CGSizeMake(screen_WIDTH-2*descLabelX, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:ItemFont_Desc} context:nil].size;
    _descLabelFrame = (CGRect){{descLabelX, descLabelY}, descLabelSize};
    // cell
    CGFloat cellH = CGRectGetMaxY(_descLabelFrame)+ItemSpacing_Text;
    _cellHeight = cellH;
}

@end
