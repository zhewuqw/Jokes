//
//  ZWRecommonedCategoryCell.m
//  Jokes
//
//  Created by zhe wu on 9/30/16.
//  Copyright © 2016 zhe wu. All rights reserved.
//

#import "ZWRecommonedCategoryCell.h"
#import "ZWRecommendCategory.h"

@interface ZWRecommonedCategoryCell()

@property (weak, nonatomic) IBOutlet UIView *selectedIndicator;

@end

@implementation ZWRecommonedCategoryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backgroundColor = ZWRGBColor(244, 244, 244);
    self.selectedIndicator.backgroundColor = ZWRGBColor(219, 21, 26);
   
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    [super setSelected:selected animated:animated];
    self.selectedIndicator.hidden = !selected;
    self.textLabel.textColor = selected ? self.selectedIndicator.backgroundColor : ZWRGBColor(78, 78, 78);
}


- (void)setCategoryList:(ZWRecommendCategory *)categoryList
{
    _categoryList = categoryList;
    self.textLabel.text = categoryList.name;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    self.textLabel.y = 2;
    self.textLabel.height = self.contentView.height - 2 * self.textLabel.y;
    
}

@end
