//
//  ZWPushGuideView.m
//  Jokes
//
//  Created by zhe wu on 10/2/16.
//  Copyright © 2016 zhe wu. All rights reserved.
//

#import "ZWPushGuideView.h"

@implementation ZWPushGuideView

+(instancetype)guideView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (IBAction)close:(id)sender {
    [self removeFromSuperview];
    
}

+(void)show
{
    NSString *key = @"CFBundleShortVersionString";
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    NSString *sanboxVersion = [[NSUserDefaults standardUserDefaults] stringForKey:key];
    
    if (![currentVersion isEqualToString:sanboxVersion] ) {
        
        ZWPushGuideView *guideView = [ZWPushGuideView guideView];
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        guideView.frame = window.bounds;
        [window addSubview:guideView];
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

@end
