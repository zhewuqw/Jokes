//
//  ZWRecommendCell.m
//  Jokes
//
//  Created by zhe wu on 10/1/16.
//  Copyright © 2016 zhe wu. All rights reserved.
//

#import "ZWRecommendCell.h"
#import "zwRecommendTag.h"
#import <UIImageView+WebCache.h>

@interface ZWRecommendCell()

@property (weak, nonatomic) IBOutlet UIImageView *imageListImageView;

@property (weak, nonatomic) IBOutlet UILabel *themeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *subNumberLael;

@end

@implementation ZWRecommendCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setRecommendTag:(ZWRecommendTag *)recommendTag
{
    _recommendTag = recommendTag;
    [self.imageListImageView sd_setImageWithURL:[NSURL URLWithString:recommendTag.image_list]];
    self.themeNameLabel.text = recommendTag.theme_name;
    self.subNumberLael.text = [NSString stringWithFormat:@"%zd人订阅", recommendTag.sub_number];
}


@end
