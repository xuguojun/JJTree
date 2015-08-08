//
//  JJTLoginViewController.m
//  JJTree
//
//  Created by guojun on 7/27/15.
//  Copyright (c) 2015 guojunxu. All rights reserved.
//

#import "JJTLoginViewController.h"
#import "JJTCreateAccountViewController.h"
#import "JJTAboutViewController.h"
#import "JJTFormTableView.h"
#import "JJTAvatarCollectionView.h"
#import <MagicalRecord/MagicalRecord.h>
#import "JJTUser.h"
#import "NSManagedObject+JJTManagedObject.h"
#import "NSString+JJTString.h"

@interface JJTLoginViewController ()<JJTCreateAccountViewControllerDelegate, JJTAvatarCollectionViewDelegate>

@property (nonatomic, weak) IBOutlet JJTAvatarCollectionView *avatarCollectionView;
@property (nonatomic, weak) IBOutlet UIGestureRecognizer *bgGesture;

@property (nonatomic, weak) IBOutlet JJTFormTableView *formTableView;
@property (nonatomic, strong) UIBarButtonItem *closeButton;
@property (nonatomic, strong) UIBarButtonItem *aboutButton;
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
    self.navigationItem.rightBarButtonItem = self.aboutButton;
    
    self.avatarCollectionView.imagesURLs = @[@"http://d1oi7t5trwfj5d.cloudfront.net/91/a9/5a2c1503496da25094b88e9eda5f/avatar.jpeg", @"http://d1oi7t5trwfj5d.cloudfront.net/91/a9/5a2c1503496da25094b88e9eda5f/avatar.jpeg", @"http://d1oi7t5trwfj5d.cloudfront.net/91/a9/5a2c1503496da25094b88e9eda5f/avatar.jpeg", @"http://d1oi7t5trwfj5d.cloudfront.net/91/a9/5a2c1503496da25094b88e9eda5f/avatar.jpeg"];
    
    self.loginButton.layer.cornerRadius = 4.0f;
    self.loginButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.loginButton.layer.borderWidth = 0.5f;
    self.loginButton.layer.masksToBounds = YES;
}

- (void)closeButtonDidPress:(id)sender{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)aboutButtonDidPress:(id)sender{
    
    JJTAboutViewController *about = [JJTAboutViewController new];
    [self.navigationController pushViewController:about animated:YES];
}

#pragma mark - Core Data Operation
- (NSPredicate *)predicate:(NSNumber *)userID {
    return [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"userID == %@", userID]];
}

- (BOOL)isExisted:(NSNumber *)userID{
    
    JJTUser *userFound = [JJTUser MR_findFirstWithPredicate:[self predicate:userID]];
    BOOL existed = (userFound != nil);
    
    return existed;
}

#pragma mark - Helper
- (void)logoutOtherUsersExcept:(NSNumber *)userID{
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"userID != %@ AND hasLogined == 1", userID];
    NSArray *otherUsers = [JJTUser MR_findAllWithPredicate:predicate];
    if (otherUsers) {
        for (JJTUser *user in otherUsers) {
            user.hasLogined = @NO;
            [user saveAndWait];
        }
    }
}

- (IBAction)loginButtonDidPress:(id)sender {
    
    NSNumber *userID = @(12345);
    NSString *account = self.formTableView.account;
    NSString *password = self.formTableView.password;
    
    BOOL isExisted = [self isExisted:userID];
    JJTUser *userLogined;
    
    if (!isExisted) {
        userLogined = [JJTUser MR_createEntity];
        
        userLogined.userID = userID;
        userLogined.userEmail = [account isEmail] ? account : nil;
        userLogined.userMobile = [account isPhoneNumber] ? account : nil;
        userLogined.userPassword = password;
        userLogined.hasLogined = @YES;
    } else {
        userLogined = [JJTUser MR_findFirstWithPredicate:[self predicate:userID]];
    }
    
    [userLogined saveAndWait];
    
    [self logoutOtherUsersExcept:userID];
    
    if ([self.delegate respondsToSelector:@selector(loginViewController:didLoginSuccessWithAccount:)]) {
        [self.delegate loginViewController:self didLoginSuccessWithAccount:userLogined];
    }
    
    [self dismissViewControllerAnimated:YES completion:NULL];
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

- (IBAction)viewDidPress:(id)sender{
    self.formTableView.displayKeyboard = NO;
}

#pragma mark - JJTAvatarCollectionViewDelegate
- (void)avatarCollectionView:(JJTAvatarCollectionView *)collectionView didSelectRowAtIndex:(NSInteger)index{
    JJTUser *user = [JJTUser MR_createEntity];
    
    user.userEmail = [NSString stringWithFormat:@"example%ld@test.com", (long)index];
    user.userPassword = [NSString stringWithFormat:@"password"];
    
    self.formTableView.user = user;
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

- (UIBarButtonItem *)aboutButton{
    if (!_aboutButton) {
        _aboutButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:(UIBarButtonSystemItemBookmarks)
                                                                     target:self
                                                                     action:@selector(aboutButtonDidPress:)];
    }
    
    return _aboutButton;
}

@end
