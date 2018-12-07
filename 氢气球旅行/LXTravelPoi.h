//
//  LXTravelPoi.h
//  氢气球旅行
//
//  Created by 曾令轩 on 15/12/28.
//  Copyright © 2015年 曾令轩. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LXTravelPoi : NSObject
@property (nonatomic, strong) NSNumber *ID;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSNumber *district_id;
@property (nonatomic, strong) NSNumber *business_id;
// 网址
@property (nonatomic, copy) NSString *h5_url;
@end
