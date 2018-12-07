//
//  LXInspirationSectionFooterView.m
//  氢气球旅行
//
//  Created by 曾令轩 on 16/1/5.
//  Copyright © 2016年 曾令轩. All rights reserved.
//

#import "LXInspirationSectionFooterView.h"

@implementation LXInspirationSectionFooterView

+ (instancetype)view {
    LXInspirationSectionFooterView *footerView = [[[NSBundle mainBundle] loadNibNamed:@"LXInspirationSectionFooterView" owner:self options:nil] lastObject];
    return footerView;
}

+ (instancetype)viewWithFrame:(CGRect)frame {
    LXInspirationSectionFooterView *footerView = [self view];
    footerView.frame = frame;
    return footerView;
}

@end
