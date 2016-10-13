//
//  ZWRecommendCategory.m
//  Jokes
//
//  Created by zhe wu on 9/30/16.
//  Copyright © 2016 zhe wu. All rights reserved.
//

#import "ZWRecommendCategory.h"
#import <MJExtension.h>
@implementation ZWRecommendCategory


+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"ID" : @"id"};
}

- (NSMutableArray *)users
{
    if (!_users) {
        _users = [NSMutableArray array];
    }
    return _users;
}

@end
