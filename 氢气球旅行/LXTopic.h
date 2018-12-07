//
//  LXTopic.h
//  氢气球旅行
//
//  Created by 曾令轩 on 15/12/27.
//  Copyright © 2015年 曾令轩. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LXTopicPhoto;

@interface LXTopic : NSObject
@property (nonatomic, strong) LXTopicPhoto *photo;
@property (nonatomic, copy) NSString *ios_url;
@property (nonatomic, copy) NSString *target_id;
@property (nonatomic, copy) NSString *advert_type;
@property (nonatomic, copy) NSString *topic;
@end
