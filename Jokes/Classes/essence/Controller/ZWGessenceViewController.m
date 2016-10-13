//
//  ZWGessenceViewController.m
//  Jokes
//
//  Created by zhe wu on 9/29/16.
//  Copyright © 2016 zhe wu. All rights reserved.
//

#import "ZWGessenceViewController.h"
#import "ZWRecommendTagsViewController.h"
#import "ZWTopicViewController.h"

@interface ZWGessenceViewController () <UIScrollViewDelegate>
/** common */
@property (nonatomic, weak) UIView *indicatorView;
/** common */
@property (nonatomic, weak) UIButton *selectedBtn;
/** common */
@property (nonatomic, weak) UIView *titleView;

/** common */
@property (nonatomic, weak) UIScrollView *contentView;
@end

@implementation ZWGessenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupNav];
    [self setupChildVCs];
    [self setuptitleView];
    [self setupContentView];
    
}

- (void)setuptitleView
{
    UIView *titleView = [[UIView alloc] init];
    titleView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    titleView.width = self.view.width;
    titleView.height = ZWTitlesViewH;
    titleView.y = ZWTitlesViewY;
    [self.view addSubview:titleView];
    self.titleView = titleView;
    
    UIView *indicatorView = [[UIView alloc] init];
    indicatorView.backgroundColor = [UIColor redColor];
    indicatorView.height = 2;
    indicatorView.tag = -1;
    indicatorView.y = titleView.height - indicatorView.height;
    [titleView addSubview:indicatorView];
    self.indicatorView = indicatorView;
    
    NSArray *titles = @[@"all", @"videos", @"sounds", @"pics", @"duanzi"];
//    NSArray *titles = @[@"全部全部", @"视频", @"声音", @"图片", @"段子"];
    for (NSInteger i = 0; i < titles.count; i++) {
        UIButton *button = [[UIButton alloc] init];
        button.width = titleView.width / titles.count;
        button.height = titleView.height;
        button.x = i * button.width;
        button.tag = i;
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button layoutIfNeeded];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
       
        [button addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        [titleView addSubview:button];
        if (i == 0) {
            self.selectedBtn.enabled = NO;
            button.enabled = YES;
            [button.titleLabel sizeToFit];
            self.indicatorView.width = button.titleLabel.width;
            self.indicatorView.centerX = button.centerX;
        }
    }
    [titleView addSubview:indicatorView];
}

- (void)titleClick:(UIButton *)button
{
    self.selectedBtn.enabled = YES;
    button.enabled = NO;
    self.selectedBtn = button;
    [UIView animateWithDuration:0.2 animations:^{
        self.indicatorView.width = button.titleLabel.width;
        self.indicatorView.centerX = button.centerX;
    }];
    
    CGPoint offset = self.contentView.contentOffset;
    offset.x = button.tag * self.contentView.width;
    [self.contentView setContentOffset:offset animated:YES];
}

- (void)setupNav
{
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWtihImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" target:self action:@selector(tagClick)];
    self.view.backgroundColor = ZWGlobalBG;
}

-(void)tagClick
{
    [self.navigationController pushViewController:[[ZWRecommendTagsViewController alloc] init] animated:YES];
}

-(void)setupContentView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIScrollView *contentView = [[UIScrollView alloc] init];
    contentView.frame = self.view.bounds;
    contentView.delegate = self;
    [self.view insertSubview:contentView atIndex:0];
    contentView.contentSize = CGSizeMake(contentView.width * self.childViewControllers.count, 0);
    self.contentView = contentView;
    [self scrollViewDidEndScrollingAnimation:contentView];

}

-(void)setupChildVCs
{

    ZWTopicViewController *allVC = [[ZWTopicViewController alloc] init];
    allVC.type = ZWTopicTypeAll;
    [self addChildViewController:allVC];
    
    ZWTopicViewController *videoVC = [[ZWTopicViewController alloc] init];
    videoVC.type = ZWTopicTypeVideo;
    [self addChildViewController:videoVC];
    
    ZWTopicViewController *voiceVC = [[ZWTopicViewController alloc] init];
    voiceVC.type = ZWTopicTypeVoice;
    [self addChildViewController:voiceVC];
    
    ZWTopicViewController *picsVC = [[ZWTopicViewController alloc] init];
    picsVC.type = ZWTopicTypePicture;
    [self addChildViewController:picsVC];
    
    ZWTopicViewController *wordVC = [[ZWTopicViewController alloc] init];
    wordVC.type = ZWTopicTypeWord;
    [self addChildViewController:wordVC];
    

}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    UITableViewController *vc = self.childViewControllers[index];
    vc.view.x = scrollView.contentOffset.x;
    vc.view.y = 0;
    vc.view.height = scrollView.height;
    
    [scrollView addSubview:vc.view];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    [self titleClick: self.titleView.subviews[index]];
}

@end
