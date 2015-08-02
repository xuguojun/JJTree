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
#import <MWPhotoBrowser/MWPhoto.h>
#import <MWPhotoBrowser/MWPhotoBrowser.h>
#import <MagicalRecord/MagicalRecord.h>
#import "JJTUser.h"
#import "NSManagedObject+JJTManagedObject.h"
#import "NSString+JJTString.h"

@interface JJTLoginViewController ()<JJTCreateAccountViewControllerDelegate, JJTAvatarCollectionViewDelegate, MWPhotoBrowserDelegate>

@property (nonatomic, weak) IBOutlet JJTAvatarCollectionView *avatarCollectionView;
@property (nonatomic, weak) IBOutlet UIGestureRecognizer *bgGesture;

@property (nonatomic, weak) IBOutlet JJTFormTableView *formTableView;
@property (nonatomic, strong) UIBarButtonItem *closeButton;
@property (nonatomic, strong) UIBarButtonItem *videoButton;
@property (nonatomic, strong) IBOutlet UIBarButtonItem *createAccountButton;

@property (nonatomic, strong) IBOutlet UIButton *loginButton;
@property (nonatomic, strong) IBOutlet UIButton *forgetPasswordButton;

@property (nonatomic, strong) NSArray *videos;

@end

@implementation JJTLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"登录";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.leftBarButtonItem = self.closeButton;
    self.navigationItem.rightBarButtonItem = self.videoButton;
    
    self.avatarCollectionView.imagesURLs = @[@"http://d1oi7t5trwfj5d.cloudfront.net/91/a9/5a2c1503496da25094b88e9eda5f/avatar.jpeg", @"http://d1oi7t5trwfj5d.cloudfront.net/91/a9/5a2c1503496da25094b88e9eda5f/avatar.jpeg", @"http://d1oi7t5trwfj5d.cloudfront.net/91/a9/5a2c1503496da25094b88e9eda5f/avatar.jpeg", @"http://d1oi7t5trwfj5d.cloudfront.net/91/a9/5a2c1503496da25094b88e9eda5f/avatar.jpeg"];
    
    self.loginButton.layer.cornerRadius = 4.0f;
    self.loginButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.loginButton.layer.borderWidth = 0.5f;
    self.loginButton.layer.masksToBounds = YES;
    

    MWPhoto *video = [MWPhoto photoWithImage:[UIImage imageNamed:@"demo.png"]];
    
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *path = [bundle pathForResource:@"iPadDemo" ofType:@"m4v"];
    NSURL *url = [NSURL fileURLWithPath:path];
    video.videoURL = url;
    
    self.videos = @[video];
}

- (void)closeButtonDidPress:(id)sender{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)videoButtonDidPress:(id)sender{
    
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithPhotos:self.videos];
    browser.delegate = self;
    
    // Set options
    browser.displayActionButton = NO; // Show action button to allow sharing, copying, etc (defaults to YES)
    browser.displayNavArrows = YES; // Whether to display left and right nav arrows on toolbar (defaults to NO)
    browser.displaySelectionButtons = NO; // Whether selection buttons are shown on each image (defaults to NO)
    browser.zoomPhotosToFill = YES; // Images that almost fill the screen will be initially zoomed to fill (defaults to YES)
    browser.alwaysShowControls = NO; // Allows to control whether the bars and controls are always visible or whether they fade away to show the photo full (defaults to NO)
    browser.enableGrid = YES; // Whether to allow the viewing of all the photo thumbnails on a grid (defaults to YES)
    browser.startOnGrid = NO; // Whether to start on the grid of thumbnails instead of the first photo (defaults to NO)
    browser.autoPlayOnAppear = NO; // Auto-play first video
    
    // Present
    [self.navigationController pushViewController:browser animated:YES];
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

#pragma mark - MWPhotoBrowserDelegate
- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser{
    return 1;
}

- (id<MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index{
    return self.videos[index];
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

- (UIBarButtonItem *)videoButton{
    if (!_videoButton) {
        _videoButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:(UIBarButtonSystemItemBookmarks)
                                                                     target:self
                                                                     action:@selector(videoButtonDidPress:)];
    }
    
    return _videoButton;
}

@end
