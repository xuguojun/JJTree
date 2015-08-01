//
//  JJTCreateAccountViewController.m
//  JJTree
//
//  Created by guojun on 7/27/15.
//  Copyright (c) 2015 guojunxu. All rights reserved.
//

#import "JJTCreateAccountViewController.h"
#import "JJTFormTableView.h"
#import <MWPhotoBrowser.h>
#import <SDWebImage/UIImageView+WebCache.h>

@interface JJTCreateAccountViewController ()<UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, MWPhotoBrowserDelegate>

@property (nonatomic, weak) IBOutlet JJTFormTableView *formTableView;
@property (nonatomic, weak) IBOutlet UIImageView *avatarImageView;
@property (nonatomic, weak) IBOutlet UIGestureRecognizer *avatarGesture;
@property (nonatomic, weak) IBOutlet UIGestureRecognizer *bgGesture;

@property (nonatomic, weak) IBOutlet UIView *avatarContainer;
@property (nonatomic, strong) UIBarButtonItem *closeButton;
@property (nonatomic, strong) UIBarButtonItem *videoButton;
@property (nonatomic, strong) IBOutlet UIBarButtonItem *loginButton;
@property (nonatomic, strong) IBOutlet UIButton *createAccountButton;

@property (nonatomic, strong) UIImagePickerController *imagePickerController;
@property (nonatomic, strong) UIActionSheet *actionSheet;

@property (nonatomic, strong) NSArray *videos;

@end

@implementation JJTCreateAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"创建新账号";
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.leftBarButtonItem = self.closeButton;
    self.navigationItem.rightBarButtonItem = self.videoButton;
    
    self.createAccountButton.layer.cornerRadius = 4.0f;
    self.createAccountButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.createAccountButton.layer.borderWidth = 0.5f;
    self.createAccountButton.layer.masksToBounds = YES;
    
    self.avatarImageView.layer.cornerRadius = self.avatarImageView.bounds.size.width / 2;
    self.avatarImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.avatarImageView.layer.borderWidth = 1.f;
    self.avatarImageView.layer.masksToBounds = YES;
    
    self.avatarContainer.layer.shadowOffset = CGSizeMake(.0f, 0.25f);
    self.avatarContainer.layer.shadowRadius = 0.25f;
    self.avatarContainer.layer.shadowOpacity = .55f;
    self.avatarContainer.layer.shadowColor = [UIColor grayColor].CGColor;
    
    [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:@"http://d1oi7t5trwfj5d.cloudfront.net/91/a9/5a2c1503496da25094b88e9eda5f/avatar.jpeg"] placeholderImage:nil];
    
    MWPhoto *video = [MWPhoto photoWithImage:[UIImage imageNamed:@"demo.png"]];
    
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *path = [bundle pathForResource:@"iPadDemo" ofType:@"m4v"];
    NSURL *url = [NSURL fileURLWithPath:path];
    video.videoURL = url;
    
    self.videos = @[video];
}

- (void)closeButtonDidPress:(id)sender{
    [self dismissViewControllerAnimated:NO completion:NULL];
    if ([self.delegate respondsToSelector:@selector(createAccountViewControllerDidClose:)]) {
        [self.delegate createAccountViewControllerDidClose:self];
    }
}

- (void)videoButtonDidPress:(id)sender{
    
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] init];
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

- (IBAction)createAccountButtonDidPress:(id)sender {

}

- (IBAction)loginButtonDidPress:(id)sender {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction)avatarDidPress:(id)sender{
    [self.actionSheet showInView:self.view];
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

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *image = info[UIImagePickerControllerEditedImage];
    self.avatarImageView.image = image;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{

    [picker dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        // camera
        self.imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:self.imagePickerController animated:YES completion:NULL];
    } else if (buttonIndex == 1){
        // album
        self.imagePickerController.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        [self presentViewController:self.imagePickerController animated:YES completion:NULL];
    } else if (buttonIndex == 2){
        // library
        self.imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:self.imagePickerController animated:YES completion:NULL];
    }
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

- (UIActionSheet *)actionSheet{
    if (!_actionSheet) {
        
//        BOOL supportCamera = NO;
//        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
//            supportCamera = YES;
//        }
//        
//        BOOL supportAlbum = NO;
//        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]){
//            supportAlbum = YES;
//        }
//        
//        BOOL supportLib = NO;
//        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]){
//            supportLib = YES;
//        }
        
        _actionSheet = [[UIActionSheet alloc] initWithTitle:@"请选择操作"
                                                   delegate:self
                                          cancelButtonTitle:@"取消"
                                     destructiveButtonTitle:nil
                                          otherButtonTitles:@"拍照", @"从相册中选择", @"从图库中选择", nil];
    }
    
    return _actionSheet;
}

- (UIImagePickerController *)imagePickerController{
    if (!_imagePickerController) {
        _imagePickerController = [[UIImagePickerController alloc] init];
        _imagePickerController.view.backgroundColor = [UIColor orangeColor];
        _imagePickerController.delegate = self;
        _imagePickerController.allowsEditing = YES;
    }
    
    return _imagePickerController;
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
