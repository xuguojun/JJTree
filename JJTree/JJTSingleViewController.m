//
//  JJTSingleViewController.m
//  JJTree
//
//  Created by guojun on 8/2/15.
//  Copyright (c) 2015 guojunxu. All rights reserved.
//

#import "JJTSingleViewController.h"
#import "JJTLabel.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface JJTSingleViewController ()<UIScrollViewDelegate>

@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;
@property (nonatomic, weak) IBOutlet UIView *contentView;

@property (nonatomic, weak) IBOutlet JJTLabel *plainTextLabel;
@property (nonatomic, weak) IBOutlet UIImageView *photoImageView;
@property (nonatomic, weak) IBOutlet UIWebView *blockWebView;

@property (nonatomic, weak) IBOutlet UITapGestureRecognizer *doubleTapGesture;
@property (nonatomic, weak) IBOutlet UITapGestureRecognizer *singleTapGesture;

@end

@implementation JJTSingleViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    CGFloat margin = 8.f;
    self.plainTextLabel.edgeInsets = UIEdgeInsetsMake(margin, margin, margin, margin);
    
    self.blockWebView.scrollView.backgroundColor = [UIColor clearColor];
    
    [self show];
    [self.singleTapGesture requireGestureRecognizerToFail:self.doubleTapGesture];
}

- (IBAction)doubleTap:(id)sender{
    if(self.scrollView.zoomScale > self.scrollView.minimumZoomScale){
        [self.scrollView setZoomScale:self.scrollView.minimumZoomScale animated:YES];
    } else {
        [self.scrollView setZoomScale:(self.scrollView.maximumZoomScale / 2) animated:YES];
    }
}

- (IBAction)singleTap:(id)sender{
    /*
    BOOL hidden = self.navigationController.navigationBar.hidden;
    [self.navigationController setNavigationBarHidden:!hidden animated:YES];
    [[UIApplication sharedApplication] setStatusBarHidden:!hidden
                                            withAnimation:UIStatusBarAnimationSlide];
    
    BOOL navigationBarHidden = self.navigationController.navigationBarHidden;
    if (navigationBarHidden) {
        self.plainTextLabel.textColor = [UIColor lightGrayColor];
        self.blockWebView.backgroundColor = [UIColor blackColor];
    } else {
        self.plainTextLabel.textColor = [UIColor blackColor];
        self.blockWebView.backgroundColor = [UIColor clearColor];
    }
    
    if ([self.delegate respondsToSelector:@selector(singleViewController:didHideNavigationBar:)]) {
        [self.delegate singleViewController:self didHideNavigationBar:navigationBarHidden];
    }*/
}

- (void)hideAll{
    self.plainTextLabel.hidden = YES;
    self.photoImageView.hidden = YES;
    self.blockWebView.hidden = YES;
}

- (void)showView:(UIView *)view{
    [self hideAll];
    view.hidden = NO;
}

- (void)show{
    if ([self.paragraph.type isEqualToString:JJTParagraphPlainText]) {
        // plain text
        self.plainTextLabel.text = self.paragraph.content;
        [self showView:self.plainTextLabel];
    }
    
    if ([self.paragraph.type isEqualToString:JJTParagraphBlock]) {
        // block
        [self.blockWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.paragraph.content]]];
        [self showView:self.blockWebView];
    }
    
    if ([self.paragraph.type isEqualToString:JJTParagraphPicture]) {
        [self.photoImageView sd_setImageWithURL:[NSURL URLWithString:self.paragraph.content]];
        [self showView:self.photoImageView];
    }

}
#pragma mark - UIScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return self.contentView;
}

@end
