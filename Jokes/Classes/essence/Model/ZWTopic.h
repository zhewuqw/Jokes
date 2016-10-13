//
//  ZWTopic.h
//  Jokes
//
//  Created by zhe wu on 10/4/16.
//  Copyright © 2016 zhe wu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZWTopic : NSObject
/** common */
@property (nonatomic, strong) NSString *name;
/** common */
@property (nonatomic, strong) NSString *profile_image;
/** common */
@property (nonatomic, strong) NSString *create_time;
/** common */
@property (nonatomic, strong) NSString *text;
/** common */
@property (nonatomic, assign) NSInteger ding;
/** common */
@property (nonatomic, assign) NSInteger cai;
/** common */
@property (nonatomic, assign) NSInteger repost;
/** common */
@property (nonatomic, assign) NSInteger comment;

@property (nonatomic, assign,getter=isSina_v) BOOL sina_v;

/** common */
@property (nonatomic, assign) CGFloat cellH;

/** common */
@property (nonatomic, assign) CGFloat width;
/** common */
@property (nonatomic, assign) CGFloat height;

@property (nonatomic, copy) NSString *small_image;
@property (nonatomic, copy) NSString *large_image;
@property (nonatomic, copy) NSString *middle_image;

/** common */
@property (nonatomic, assign) ZWTopicType type;

@end
