//
//  LXPopDestination.h
//  氢气球旅行
//
//  Created by 曾令轩 on 16/1/2.
//  Copyright © 2016年 曾令轩. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LXPopDestination : NSObject
// 目的地id
@property (nonatomic, strong) NSNumber *ID;
// 中文名
@property (nonatomic, copy) NSString *name;
// 英文名
@property (nonatomic, copy) NSString *name_en;
// 封面
@property (nonatomic, copy) NSString *photo_url;
@end
