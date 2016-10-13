//
//  ZWRecommedUserCell.m
//  Jokes
//
//  Created by zhe wu on 9/30/16.
//  Copyright © 2016 zhe wu. All rights reserved.
//

#import "ZWRecommendUserCell.h"
#import "ZWRecommendUser.h"
#import <UIImageView+WebCache.h>

@interface ZWRecommedUserCell()
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;

@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *fansCountLabel;

@end

@implementation ZWRecommedUserCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setUser:(ZWRecommendUser *)user
{
    _user = user;
    self.screenNameLabel.text = user.screen_name;
    self.fansCountLabel.text = [NSString stringWithFormat:@"%zd fllow", user.fans_count];
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:user.header] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
}

@end
