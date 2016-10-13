//
//  ZWLoginOrRegisterViewController.m
//  Jokes
//
//  Created by zhe wu on 10/2/16.
//  Copyright © 2016 zhe wu. All rights reserved.
//

#import "ZWLoginOrRegisterViewController.h"

@interface ZWLoginOrRegisterViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *bgView;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UITextField *phoneView;
@property (weak, nonatomic) IBOutlet UITextField *pwdView;

@property (weak, nonatomic) IBOutlet UIView *loginView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *margin;


@end

@implementation ZWLoginOrRegisterViewController
- (IBAction)loginOrRegister:(id)sender {
    [self.view endEditing: YES];
    
    if (self.margin.constant == 0) {
        self.margin.constant = - self.view.width;
        [sender setTitle: @"Login" forState:UIControlStateNormal];
    } else {
        self.margin.constant = 0;
        [sender setTitle: @"Register" forState:UIControlStateNormal];
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        [self.view layoutSubviews];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view insertSubview:self.bgView atIndex:0];
//    self.loginButton.layer.cornerRadius = 5;
//    self.loginButton.layer.masksToBounds = YES;
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = [UIColor whiteColor];

    NSMutableAttributedString *plactholder = [[NSMutableAttributedString alloc] initWithString:@"phone number" attributes:attrs];
    
    self.phoneView.attributedPlaceholder = plactholder;
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
- (IBAction)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
