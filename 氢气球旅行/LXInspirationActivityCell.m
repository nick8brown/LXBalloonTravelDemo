//
//  LXInspirationActivityCell.m
//  氢气球旅行
//
//  Created by 曾令轩 on 16/1/5.
//  Copyright © 2016年 曾令轩. All rights reserved.
//

#import "LXInspirationActivityCell.h"
#import "LXInspirationActivityGroup.h"
#import "LXInspirationActivity.h"
#import "LXTopicPhoto.h"
#import "LXInspirationActivityFrame.h"
#import "UIImageView+WebCache.h"

@interface LXInspirationActivityCell ()
// 附图
@property (nonatomic, weak) UIImageView *contentImgView;
// 介绍
@property (nonatomic, weak) UILabel *introduceLabel;
// 查看详情
@property (nonatomic, weak) UIView *detailView;
@property (nonatomic, weak) UIButton *detailBtn;
@end

@implementation LXInspirationActivityCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    return [[[self class] alloc] initWithTableView:tableView];
}

- (instancetype)initWithTableView:(UITableView *)tableView {
    LXInspirationActivityCell *cell = [tableView dequeueReusableCellWithIdentifier:InspirationActivityCell_ID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // 添加旅行灵感内部的子控件
        [self setupSubviews];
    }
    return self;
}
// 添加旅行灵感内部的子控件
- (void)setupSubviews {
    // 附图
    UIImageView *contentImgView = [[UIImageView alloc] init];
    [self.contentView addSubview:contentImgView];
    self.contentImgView = contentImgView;
    // 介绍
    UILabel *introduceLabel = [[UILabel alloc] init];
    introduceLabel.font = InspirationFont_Introduce;
    introduceLabel.textAlignment = NSTextAlignmentLeft;
    introduceLabel.numberOfLines = 0;
    introduceLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [self.contentView addSubview:introduceLabel];
    self.introduceLabel = introduceLabel;
    // 查看详情
    UIView *detailView = [[UIView alloc] init];
    [self.contentView addSubview:detailView];
    self.detailView = detailView;
}

- (void)setInspirationActivityFrame:(LXInspirationActivityFrame *)inspirationActivityFrame {
    _inspirationActivityFrame = inspirationActivityFrame;
    LXInspirationActivity *inspiration = self.inspirationActivityFrame.inspiration;
    // 附图
    self.contentImgView.frame = self.inspirationActivityFrame.contentImgViewFrame;
    LXTopicPhoto *photo = inspiration.photo;
    [self.contentImgView setImageWithURL:[NSURL URLWithString:photo.photo_url] placeholderImage:[UIImage imageNamed:photo_placeholder]];
    // 介绍
    self.introduceLabel.frame = self.inspirationActivityFrame.introduceLabelFrame;
    self.introduceLabel.text = inspiration.introduce;
    // 查看详情
    self.detailView.frame = self.inspirationActivityFrame.detailViewFrame;
    if (!self.detailBtn.frame.size.width) {
        [self setupDetailView];
    }
}

#pragma mark - 查看详情
- (void)setupDetailView {
    UIButton *detailBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat detailBtnY = 0.5*minimumSpacing;
    CGFloat detailBtnW = detailBtn_WIDTH;
    CGFloat detailBtnX = (self.detailView.frame.size.width-detailBtnW)*0.5;
    CGFloat detailBtnH = self.detailView.frame.size.height-2*detailBtnY;
    detailBtn.frame = CGRectMake(detailBtnX, detailBtnY, detailBtnW, detailBtnH);
    detailBtn.layer.borderWidth = 1;
    detailBtn.layer.borderColor = [UIColor blackColor].CGColor;
    detailBtn.layer.cornerRadius = 5;
    detailBtn.clipsToBounds = YES;
    [detailBtn setTitle:@"查看详情" forState:UIControlStateNormal];
    detailBtn.titleLabel.font = InspirationFont_Detail;
    [detailBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [detailBtn addTarget:self action:@selector(detailBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.detailView addSubview:detailBtn];
    self.detailBtn = detailBtn;
}
// 查看详情
- (void)detailBtnClick:(UIButton *)sender {
#warning todo
}

@end
