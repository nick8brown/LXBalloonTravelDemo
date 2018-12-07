//
//  LXActivitySectionFooterView.m
//  氢气球旅行
//
//  Created by 曾令轩 on 16/1/9.
//  Copyright © 2016年 曾令轩. All rights reserved.
//

#import "LXActivitySectionFooterView.h"

@implementation LXActivitySectionFooterView

+ (instancetype)view {
    return [[[self class] alloc] init];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"LXActivitySectionFooterView" owner:self options:nil] lastObject];
    }
    return self;
}

@end
