//
//  LXTopicPage.h
//  氢气球旅行
//
//  Created by 曾令轩 on 15/12/31.
//  Copyright © 2015年 曾令轩. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LXTopicPage : NSObject
@property (nonatomic, strong) NSNumber *ID;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *summary;
@property (nonatomic, strong) NSArray *items;
@end
