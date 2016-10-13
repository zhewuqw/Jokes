//
//  ZWRecommendCategory.h
//  Jokes
//
//  Created by zhe wu on 9/30/16.
//  Copyright © 2016 zhe wu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZWRecommendCategory : NSObject
/** common */
@property (nonatomic, assign) NSInteger ID;
/** common */
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, strong) NSString *name;
/** common */
@property (nonatomic, assign) NSInteger total;
/** common */
@property (nonatomic, assign) NSInteger current_page;
/** common */
@property (nonatomic, strong) NSMutableArray *users;

@end
