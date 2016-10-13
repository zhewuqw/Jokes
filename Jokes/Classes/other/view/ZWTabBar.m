//
//  ZWTabBar.m
//  Jokes
//
//  Created by zhe wu on 9/29/16.
//  Copyright © 2016 zhe wu. All rights reserved.
//

#import "ZWTabBar.h"

@interface ZWTabBar()

/** common */
@property (nonatomic, strong) UIButton *publish;
@end

@implementation ZWTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setBackgroundImage:[UIImage imageNamed:@"tabbar-light"]];
        self.publish = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.publish setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [self.publish setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateSelected];
        self.publish.size = self.publish.currentBackgroundImage.size;
        [self addSubview:self.publish];
    }
    return self;
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat width = self.width;
    CGFloat heigh = self.height;
  
    self.publish.center = CGPointMake(width * 0.5, heigh * 0.5);
    
    CGFloat buttonY = 0;
    CGFloat buttonW = width / 5;
    CGFloat buttonH = heigh;
    NSInteger index = 0;
    for (UIView *button in self.subviews) {
        if (![button isKindOfClass:[UIControl class]] || button == self.publish ) continue;
        CGFloat buttonX = buttonW * ((index > 1)? (index + 1) : index);
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        index++;
    }
    
    
    
}

@end
