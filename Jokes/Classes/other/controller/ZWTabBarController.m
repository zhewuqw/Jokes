//
//  ZWTabBarController.m
//  Jokes
//
//  Created by zhe wu on 9/29/16.
//  Copyright © 2016 zhe wu. All rights reserved.
//

#import "ZWTabBarController.h"
#import "ZWGessenceViewController.h"
#import "ZWNewViewController.h"
#import "ZWfriendTrendsViewController.h"
#import "ZWMeViewController.h"
#import "ZWTabBar.h"
#import "ZWNavigationController.h"

@interface ZWTabBarController ()

@end

@implementation ZWTabBarController

+(void)initialize
{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupChildVC:[[ZWGessenceViewController alloc] init] title:@"jinghua" image:@"tabBar_essence_icon" selectedImage:@"tabBar_essence_click_icon"];
    
    [self setupChildVC:[[ZWNewViewController alloc] init] title:@"new" image:@"tabBar_new_icon" selectedImage:@"tabBar_new_click_icon"];
    
    [self setupChildVC:[[ZWfriendTrendsViewController alloc] init] title:@"guanzhu" image:@"tabBar_friendTrends_icon" selectedImage:@"tabBar_friendTrends_click_icon"];
    
    [self setupChildVC:[[ZWMeViewController alloc] init] title:@"me" image:@"tabBar_me_icon" selectedImage:@"tabBar_me_click_icon"];
    [self setValue:[[ZWTabBar alloc] init] forKey:@"tabBar"];
 
}

- (void)setupChildVC:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    vc.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    ZWNavigationController *nav = [[ZWNavigationController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
}


@end
