//
//  LXTopicItemCell.m
//  氢气球旅行
//
//  Created by 曾令轩 on 15/12/31.
//  Copyright © 2015年 曾令轩. All rights reserved.
//

#import "LXTopicItemCell.h"
#import "LXTopicItem.h"
#import "LXTopicItemFrame.h"

@interface LXTopicItemCell ()
// 标题
@property (nonatomic, weak) UILabel *titleLabel;
// 描述
@property (nonatomic, weak) UILabel *descLabel;
@end

@implementation LXTopicItemCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    return [[[self class] alloc] initWithTableView:tableView];
}

- (instancetype)initWithTableView:(UITableView *)tableView {
    LXTopicItemCell *cell = [tableView dequeueReusableCellWithIdentifier:TopicItemCell_ID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // 添加专题内部的子控件
        [self setupSubviews];
    }
    return self;
}
// 添加专题内部的子控件
- (void)setupSubviews {
    // 标题
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = ItemFont_Title;
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.numberOfLines = 0;
    titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [self.contentView addSubview:titleLabel];
    self.titleLabel = titleLabel;
    // 描述
    UILabel *descLabel = [[UILabel alloc] init];
    descLabel.font = ItemFont_Desc;
    descLabel.textAlignment = NSTextAlignmentLeft;
    descLabel.numberOfLines = 0;
    descLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [self.contentView addSubview:descLabel];
    self.descLabel = descLabel;
}

- (void)setTopicItemFrame:(LXTopicItemFrame *)topicItemFrame {
    _topicItemFrame = topicItemFrame;
    LXTopicItem *topicItem = self.topicItemFrame.topicItem;
    // 主题
    self.titleLabel.frame = self.topicItemFrame.titleLabelFrame;
    self.titleLabel.text = topicItem.title;
    // 描述
    self.descLabel.frame = self.topicItemFrame.descLabelFrame;
    self.descLabel.text = topicItem.desc;
}

@end
