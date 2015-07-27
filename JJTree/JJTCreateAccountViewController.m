//
//  JJTCreateAccountViewController.m
//  JJTree
//
//  Created by guojun on 7/27/15.
//  Copyright (c) 2015 guojunxu. All rights reserved.
//

#import "JJTCreateAccountViewController.h"
#import "JJTFormTableView.h"

@interface JJTCreateAccountViewController ()

@property (nonatomic, weak) IBOutlet JJTFormTableView *formTableView;
@property (nonatomic, strong) UIBarButtonItem *closeButton;
@property (nonatomic, strong) IBOutlet UIBarButtonItem *loginButton;
@property (nonatomic, strong) IBOutlet UIButton *createAccountButton;

@end

@implementation JJTCreateAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"创建新账号";
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.leftBarButtonItem = self.closeButton;
    
    self.createAccountButton.layer.cornerRadius = 4.0f;
    self.createAccountButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.createAccountButton.layer.borderWidth = 0.5f;
    self.createAccountButton.layer.masksToBounds = YES;
}

- (void)closeButtonDidPress:(id)sender{
    [self dismissViewControllerAnimated:NO completion:NULL];
    if ([self.delegate respondsToSelector:@selector(createAccountViewControllerDidClose:)]) {
        [self.delegate createAccountViewControllerDidClose:self];
    }
}
- (IBAction)createAccountButtonDidPress:(id)sender {

}
- (IBAction)loginButtonDidPress:(id)sender {
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
