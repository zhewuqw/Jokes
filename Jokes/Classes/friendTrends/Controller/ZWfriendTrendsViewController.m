//
//  ZWfriendTrendsViewController.m
//  Jokes
//
//  Created by zhe wu on 9/29/16.
//  Copyright © 2016 zhe wu. All rights reserved.
//

#import "ZWfriendTrendsViewController.h"
#import "ZWRecommendViewController.h"
#import "ZWLoginOrRegisterViewController.h"

@interface ZWfriendTrendsViewController ()

@end

@implementation ZWfriendTrendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"my account";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWtihImage:@"friendsRecommentIcon" highImage:@"friendsRecommentIcon-click" target:self action:@selector(friendClick)];
    self.view.backgroundColor = ZWGlobalBG;
}

- (void)friendClick
{
    ZWRecommendViewController *vc = [[ZWRecommendViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


- (IBAction)loginOrRegister:(id)sender {
    
    ZWLoginOrRegisterViewController *login = [[ZWLoginOrRegisterViewController alloc] init];
    [self presentViewController:login animated:YES completion:nil];
}


@end
