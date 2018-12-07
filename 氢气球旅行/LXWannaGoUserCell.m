//
//  LXWannaGoUserCell.m
//  氢气球旅行
//
//  Created by 曾令轩 on 16/1/4.
//  Copyright © 2016年 曾令轩. All rights reserved.
//

#import "LXWannaGoUserCell.h"
#import "LXTravelUser.h"
#import "UIImageView+WebCache.h"

@interface LXWannaGoUserCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@end

@implementation LXWannaGoUserCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    return [[[self class] alloc] initWithTableView:tableView];
}

- (instancetype)initWithTableView:(UITableView *)tableView {
    if (self = [super init]) {
        self = [tableView dequeueReusableCellWithIdentifier:WannaGoUserCell_ID];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setUser:(LXTravelUser *)user {
    _user = user;
    self.iconImgView.layer.cornerRadius = self.iconImgView.frame.size.width*0.5;
    self.iconImgView.clipsToBounds = YES;
    self.iconImgView.contentMode = UIViewContentModeScaleAspectFill;
    [self.iconImgView setImageWithURL:[NSURL URLWithString:user.photo_url] placeholderImage:[UIImage imageNamed:photo_placeholder]];
    self.nameLabel.text = user.name;
}

@end
