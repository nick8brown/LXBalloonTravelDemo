//
//  LXUserDB.h
//  网络_06
//
//  Created by 曾令轩 on 15/11/24.
//  Copyright © 2015年 曾令轩. All rights reserved.
//

#import "LXDBManager.h"

@interface LXUserDB : LXDBManager
- (void)createTable;
- (void)addUserWithParams:(NSArray *)params;
- (void)deleteUsers:(NSArray *)users;
- (NSArray *)selectUser:(NSArray *)users;

+ (instancetype)allocWithZone:(struct _NSZone *)zone;
+ (instancetype)shareUserDB;
@end
