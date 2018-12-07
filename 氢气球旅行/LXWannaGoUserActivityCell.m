//
//  LXWannaGoUserActivityCell.m
//  氢气球旅行
//
//  Created by 曾令轩 on 16/1/14.
//  Copyright © 2016年 曾令轩. All rights reserved.
//

#import "LXWannaGoUserActivityCell.h"
#import "LXTravelActivity.h"
#import "LXTravelContent.h"
#import "LXTravelUser.h"
#import "UIImageView+WebCache.h"
#import "Masonry.h"
#import "MJExtension.h"

@interface LXWannaGoUserActivityCell ()
// 大图
@property (nonatomic, weak) UIImageView *contentImgView;
// by
@property (nonatomic, weak) UILabel *byLabel;
// 用户
@property (nonatomic, weak) UILabel *userLabel;
// 主题
@property (nonatomic, weak) UILabel *topicLabel;
// 描述
@property (nonatomic, weak) UILabel *descLabel;
// 查看全文
@property (nonatomic, weak) UIButton *unfoldBtn;
@end

@implementation LXWannaGoUserActivityGroup

@end

@implementation LXWannaGoUserActivityCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    return [[[self class] alloc] initWithTableView:tableView];
}

- (instancetype)initWithTableView:(UITableView *)tableView {
    LXWannaGoUserActivityCell *cell = [tableView dequeueReusableCellWithIdentifier:WannaGoUserActivityCell_ID];
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
    WS(weakSelf);
    // 大图
    UIImageView *contentImgView = [[UIImageView alloc] init];
    contentImgView.contentMode = UIViewContentModeScaleAspectFill;
    contentImgView.clipsToBounds = YES;
    [self.contentView addSubview:contentImgView];
    [contentImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.contentView).with.offset(UserActivitySpacing_Text);
        make.top.equalTo(weakSelf.contentView).with.offset(UserActivitySpacing_Content);
        make.right.equalTo(weakSelf.contentView).with.offset(-UserActivitySpacing_Text);
        make.height.mas_equalTo(200);
    }];
    self.contentImgView = contentImgView;
    // by
    UILabel *byLabel = [[UILabel alloc] init];
    byLabel.text = @"by";
    byLabel.font = UserActivityFont_By;
    byLabel.textColor = [UIColor lightGrayColor];
    byLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:byLabel];
    [byLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentImgView.mas_left);
        make.top.equalTo(contentImgView.mas_bottom).with.offset(UserActivitySpacing_Text);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    self.byLabel = byLabel;
    // 用户
    UILabel *userLabel = [[UILabel alloc] init];
    userLabel.font = UserActivityFont_User;
    userLabel.textColor = mainThemeColor;
    userLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:userLabel];
    [userLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(byLabel.mas_right);
        make.top.equalTo(byLabel.mas_top);
        make.size.mas_equalTo(CGSizeMake(200, 20));
    }];
    self.userLabel = userLabel;
    // 主题
    UILabel *topicLabel = [[UILabel alloc] init];
    topicLabel.font = UserActivityFont_Topic;
    topicLabel.textAlignment = NSTextAlignmentLeft;
    topicLabel.numberOfLines = 0;
    topicLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [self.contentView addSubview:topicLabel];
    [topicLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(byLabel.mas_left);
        make.top.equalTo(byLabel.mas_bottom).with.offset(UserActivitySpacing_Text);
        make.right.equalTo(weakSelf.contentView.mas_right).with.offset(-UserActivitySpacing_Text);
    }];
    self.topicLabel = topicLabel;
    // 描述
    UILabel *descLabel = [[UILabel alloc] init];
    descLabel.font = UserActivityFont_Desc;
    descLabel.textAlignment = NSTextAlignmentLeft;
    descLabel.numberOfLines = 0;
    descLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [self.contentView addSubview:descLabel];
    [descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(topicLabel.mas_left);
        make.top.equalTo(topicLabel.mas_bottom).with.offset(UserActivitySpacing_Text);
        make.right.equalTo(weakSelf.contentView.mas_right).with.offset(-UserActivitySpacing_Text);
    }];
    self.descLabel = descLabel;
    // 查看全文
    UIButton *unfoldBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    unfoldBtn.titleLabel.font = UserActivityFont_Unfold;
    [unfoldBtn setTitleColor:mainThemeColor forState:UIControlStateNormal];
    unfoldBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
    [unfoldBtn setTitle:@"...查看全文" forState:UIControlStateNormal];
    [unfoldBtn addTarget:self action:@selector(unfoldBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:unfoldBtn];
    [unfoldBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(descLabel.mas_left);
        make.top.equalTo(descLabel.mas_bottom).with.offset(UserActivitySpacing_Text);
        make.size.mas_equalTo(CGSizeMake(80, 20));
    }];
    self.unfoldBtn = unfoldBtn;
}
// 查看全文
- (void)unfoldBtnClick:(UIButton *)sender {
    self.group.isUnfold = !self.group.isUnfold;
    if (self.block) {
        self.block(self.indexPath);
    }
    [self configCellWithModel:self.group];
    [self.contentView setNeedsUpdateConstraints];
    [self.contentView updateConstraintsIfNeeded];
    [self.contentView layoutIfNeeded];
}

+ (CGFloat)heightWithModel:(LXWannaGoUserActivityGroup *)group {
    LXWannaGoUserActivityCell *cell = [[LXWannaGoUserActivityCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@""];
    [cell configCellWithModel:group];
    [cell layoutIfNeeded];
    if (group.isUnfold) {
        return CGRectGetMaxY(cell.descLabel.frame)+UserActivitySpacing_Text;
    }
    return CGRectGetMaxY(cell.unfoldBtn.frame)+UserActivitySpacing_Text;
}

- (void)configCellWithModel:(LXWannaGoUserActivityGroup *)group {
    LXTravelActivity *activity = group.activity;
    LXTravelContent *content = [[LXTravelContent objectArrayWithKeyValuesArray:activity.contents] firstObject];
    LXTravelUser *user = activity.user;
    // 大图
    [self.contentImgView setImageWithURL:[NSURL URLWithString:content.photo_url] placeholderImage:[UIImage imageNamed:photo_placeholder]];
    // 用户
    self.userLabel.text = user.name;
    // 主题
    self.topicLabel.text = activity.topic;
    // 描述
    self.descLabel.text = activity.desc;
    WS(weakSelf);
    if (group.isUnfold) {
        [self.descLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.topicLabel.mas_left);
            make.top.equalTo(weakSelf.topicLabel.mas_bottom).with.offset(UserActivitySpacing_Text);
            make.right.equalTo(weakSelf.contentView.mas_right).with.offset(-UserActivitySpacing_Text);
        }];
        [self.unfoldBtn removeFromSuperview];
    } else {
        [self.descLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.topicLabel.mas_left);
            make.top.equalTo(weakSelf.topicLabel.mas_bottom).with.offset(UserActivitySpacing_Text);
            make.right.equalTo(weakSelf.contentView.mas_right).with.offset(-UserActivitySpacing_Text);
            make.height.mas_equalTo(120);
        }];
    }
    self.group = group;
}

@end
