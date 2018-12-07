//
//  LXActivitySectionHeaderView.m
//  氢气球旅行
//
//  Created by 曾令轩 on 16/1/9.
//  Copyright © 2016年 曾令轩. All rights reserved.
//

#import "LXActivitySectionHeaderView.h"
#import "LXLocationDistrict.h"

@interface LXActivitySectionHeaderView ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *duringLabel;
@end

@implementation LXActivitySectionHeaderView

+ (instancetype)view {
    return [[[self class] alloc] init];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"LXActivitySectionHeaderView" owner:self options:nil] lastObject];
    }
    return self;
}

- (void)setLocation:(LXLocationDistrict *)location {
    _location = location;
    self.nameLabel.text = self.location.name;
    self.duringLabel.text = self.location.during;
}

@end
