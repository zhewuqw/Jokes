//
//  UIBarButtonItem+ZWExtesion.m
//  Jokes
//
//  Created by zhe wu on 9/29/16.
//  Copyright © 2016 zhe wu. All rights reserved.
//

#import "UIBarButtonItem+ZWExtesion.h"

@implementation UIBarButtonItem (ZWExtesion)

+(instancetype)itemWtihImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    button.size = button.currentBackgroundImage.size;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[self alloc] initWithCustomView:button];
}


@end
