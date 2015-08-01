//
//  JJTLoginViewController.m
//  JJTree
//
//  Created by guojun on 7/27/15.
//  Copyright (c) 2015 guojunxu. All rights reserved.
//

#import "JJTLoginViewController.h"
#import "JJTCreateAccountViewController.h"
#import "JJTFormTableView.h"
#import "JJTAvatarCollectionView.h"

@interface JJTLoginViewController ()<JJTCreateAccountViewControllerDelegate>

@property (nonatomic, weak) IBOutlet JJTAvatarCollectionView *avatarCollectionView;

@property (nonatomic, weak) IBOutlet JJTFormTableView *formView;
@property (nonatomic, strong) UIBarButtonItem *closeButton;
@property (nonatomic, strong) IBOutlet UIBarButtonItem *createAccountButton;

@property (nonatomic, strong) IBOutlet UIButton *loginButton;
@property (nonatomic, strong) IBOutlet UIButton *forgetPasswordButton;

@end

@implementation JJTLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"登录";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.leftBarButtonItem = self.closeButton;
    
    self.avatarCollectionView.imagesURLs = @[@"http://d1oi7t5trwfj5d.cloudfront.net/91/a9/5a2c1503496da25094b88e9eda5f/avatar.jpeg", @"http://d1oi7t5trwfj5d.cloudfront.net/91/a9/5a2c1503496da25094b88e9eda5f/avatar.jpeg", @"http://d1oi7t5trwfj5d.cloudfront.net/91/a9/5a2c1503496da25094b88e9eda5f/avatar.jpeg", @"http://d1oi7t5trwfj5d.cloudfront.net/91/a9/5a2c1503496da25094b88e9eda5f/avatar.jpeg"];
    
    self.loginButton.layer.cornerRadius = 4.0f;
    self.loginButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.loginButton.layer.borderWidth = 0.5f;
    self.loginButton.layer.masksToBounds = YES;
}

- (void)closeButtonDidPress:(id)sender{
    [self dismissViewControllerAnimated:YES completion:NULL];
}
- (IBAction)loginButtonDidPress:(id)sender {
    
}

- (IBAction)forgetPasswordButtonDidPress:(id)sender {
    
}

- (IBAction)createAccountButtonDidPress:(id)sender {
    JJTCreateAccountViewController *createVC = [JJTCreateAccountViewController new];
    createVC.delegate = self;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:createVC];
    nav.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
    [self presentViewController:nav animated:YES completion:NULL];
}

#pragma mark - JJTCreateAccountViewControllerDelegate
- (void)createAccountViewControllerDidClose:(JJTCreateAccountViewController *)controller{
    [self closeButtonDidPress:nil];
}

#pragma mark - Getters & Setters
- (UIBarButtonItem *)closeButton{
    if (!_closeButton) {
        _closeButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                     target:self
                                                                     action:@selector(closeButtonDidPress:)];
    }
    
    return _closeButton;
}

@end
