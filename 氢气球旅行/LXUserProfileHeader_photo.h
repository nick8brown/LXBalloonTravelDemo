//
//  LXUserProfileHeader_photo.h
//  氢气球旅行
//
//  Created by 曾令轩 on 16/1/8.
//  Copyright © 2016年 曾令轩. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LXUserProfileHeader_photo : NSObject
// 封面图
@property (nonatomic, copy) NSString *photo_url;
// 宽
@property (nonatomic, strong) NSNumber *width;
// 高
@property (nonatomic, strong) NSNumber *height;
@end
