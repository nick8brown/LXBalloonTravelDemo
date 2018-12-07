//
//  LXTravelContent.h
//  氢气球旅行
//
//  Created by 曾令轩 on 15/12/28.
//  Copyright © 2015年 曾令轩. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LXTravelContent : NSObject
// 附图id
@property (nonatomic, strong) NSNumber *ID;
// 字幕
@property (nonatomic, copy) NSString *caption;
// 图片
@property (nonatomic, copy) NSString *photo_url;
// 宽
@property (nonatomic, strong) NSNumber *width;
// 高
@property (nonatomic, strong) NSNumber *height;
// 显示位置
@property (nonatomic, strong) NSNumber *position;
@end
