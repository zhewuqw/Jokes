//
//  UIBarButtonItem+ZWExtesion.h
//  Jokes
//
//  Created by zhe wu on 9/29/16.
//  Copyright © 2016 zhe wu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (ZWExtesion)

+(instancetype)itemWtihImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action;
@end
