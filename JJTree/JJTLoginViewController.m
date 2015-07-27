//
//  JJTLoginViewController.m
//  JJTree
//
//  Created by guojun on 7/27/15.
//  Copyright (c) 2015 guojunxu. All rights reserved.
//

#import "JJTLoginViewController.h"
#import "JJTFormTableView.h"

@interface JJTLoginViewController ()

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
    
    self.loginButton.layer.cornerRadius = 4.0f;
    self.loginButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.loginButton.layer.borderWidth = 0.5f;
    self.loginButton.layer.masksToBounds = YES;
}

- (void)closeButtonDidPress:(id)sender{
    [self dismissViewControllerAnimated:YES completion:NULL];
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
