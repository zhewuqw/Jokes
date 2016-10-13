//
//  ZWMeViewController.m
//  Jokes
//
//  Created by zhe wu on 9/29/16.
//  Copyright © 2016 zhe wu. All rights reserved.
//

#import "ZWMeViewController.h"

@interface ZWMeViewController ()

@end

@implementation ZWMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"Mine";
    UIBarButtonItem *settingItem = [UIBarButtonItem itemWtihImage:@"mine-setting-icon" highImage:@"mine-setting-icon-click" target:self action:@selector(settingClick)];
    UIBarButtonItem *moonItem = [UIBarButtonItem itemWtihImage:@"mine-moon-icon" highImage:@"mine-moon-icon-click" target:self action:@selector(moonClick)];
    self.navigationItem.rightBarButtonItems = @[settingItem, moonItem];
    self.view.backgroundColor = ZWGlobalBG;
}

- (void)settingClick
{
    
}

- (void)moonClick
{
    
}

@end
