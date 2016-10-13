//
//  ZWVerticalButton.m
//  Jokes
//
//  Created by zhe wu on 10/2/16.
//  Copyright © 2016 zhe wu. All rights reserved.
//

#import "ZWVerticalButton.h"

@implementation ZWVerticalButton

-(void)awakeFromNib
{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.imageView.x = 0;
    self.imageView.y = 0;
    self.imageView.width = self.width;
    self.imageView.height = self.imageView.height;
    
    self.titleLabel.x = 0;
    self.titleLabel.y = self.imageView.height;
    self.titleLabel.height = self.height - self.titleLabel.y;
    self.titleLabel.width = self.width;
}

@end
