//
//  ZWTopic.m
//  Jokes
//
//  Created by zhe wu on 10/4/16.
//  Copyright © 2016 zhe wu. All rights reserved.
//

#import "ZWTopic.h"
#import <MJExtension.h>

@implementation ZWTopic


+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"small_image" : @"image0",
             @"large_image" : @"image1",
             @"mdiile_image" : @"image2"
             };
}

-(CGFloat)cellH
{
    if (!_cellH) {
        CGSize maxSize = CGSizeMake([UIScreen mainScreen].bounds.size.width - 40, MAXFLOAT);
        CGFloat textH = [self.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil].size.height;
        _cellH = ZWTopiceCellTextY + textH + ZWTopiceBottomBarH + 2 * ZWTopicCellMargin + self.height;

        if (self.type == ZWTopicTypePicture) {
            _cellH += self.height; 
        }
    }
    
    
    
    return _cellH;
}


@end
