//
//  JJTCreateAccountViewController.m
//  JJTree
//
//  Created by guojun on 7/27/15.
//  Copyright (c) 2015 guojunxu. All rights reserved.
//

#import "JJTCreateAccountViewController.h"
#import "JJTAboutViewController.h"
#import "JJTFormTableView.h"

@interface JJTCreateAccountViewController ()<UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, weak) IBOutlet JJTFormTableView *formTableView;
@property (nonatomic, weak) IBOutlet UIImageView *avatarImageView;
@property (nonatomic, weak) IBOutlet UIGestureRecognizer *avatarGesture;
@property (nonatomic, weak) IBOutlet UIGestureRecognizer *bgGesture;

@property (nonatomic, weak) IBOutlet UIView *avatarContainer;
@property (nonatomic, strong) UIBarButtonItem *closeButton;
@property (nonatomic, strong) UIBarButtonItem *aboutButton;
@property (nonatomic, strong) IBOutlet UIBarButtonItem *loginButton;
@property (nonatomic, strong) IBOutlet UIButton *createAccountButton;

@property (nonatomic, strong) UIImagePickerController *imagePickerController;
@property (nonatomic, strong) UIActionSheet *actionSheet;

@end

@implementation JJTCreateAccountViewController

#pragma mar - Life Cycle Methods
- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"创建新账号";
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.leftBarButtonItem = self.closeButton;
    self.navigationItem.rightBarButtonItem = self.aboutButton;
    
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
    
    self.avatarImageView.image = [UIImage imageNamed:@"Icon-Avatar"];
}

#pragma mark - Private Methods
- (void)closeButtonDidPress:(id)sender{
    [self dismissViewControllerAnimated:NO completion:NULL];
    if ([self.delegate respondsToSelector:@selector(createAccountViewControllerDidClose:)]) {
        [self.delegate createAccountViewControllerDidClose:self];
    }
}

- (void)aboutButtonDidPress:(id)sender{
    
    JJTAboutViewController *about = [JJTAboutViewController new];
    [self.navigationController pushViewController:about animated:YES];
}

- (IBAction)createAccountButtonDidPress:(id)sender {
    
    static NSString *url = @"accounts";
    
    NSDictionary *params = @{@"account" : self.formTableView.account, @"password" : self.formTableView.password};
    
    [self.httpManager requestUrlPath:url method:METHOD_POST param:params fromCache:NO requestSuccess:^(id result, AFHTTPRequestOperation *operation) {
        ;
    } requestFailure:^(id result, AFHTTPRequestOperation *operation) {
        ;
    }];
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

- (UIBarButtonItem *)aboutButton{
    if (!_aboutButton) {
        _aboutButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:(UIBarButtonSystemItemBookmarks)
                                                                     target:self
                                                                     action:@selector(aboutButtonDidPress:)];
    }
    
    return _aboutButton;
}

@end
