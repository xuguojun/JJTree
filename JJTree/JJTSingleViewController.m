//
//  JJTSingleViewController.m
//  JJTree
//
//  Created by guojun on 8/2/15.
//  Copyright (c) 2015 guojunxu. All rights reserved.
//

#import "JJTSingleViewController.h"

@interface JJTSingleViewController ()<UIScrollViewDelegate>

@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;
@property (nonatomic, weak) IBOutlet UIView *container;
@property (nonatomic, weak) IBOutlet UITapGestureRecognizer *gesture;

@end

@implementation JJTSingleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.container addSubview:self.zoomableView];
    [self addConstraints];
}

- (IBAction)doubleTap:(id)sender{
    if(self.scrollView.zoomScale > self.scrollView.minimumZoomScale){
        [self.scrollView setZoomScale:self.scrollView.minimumZoomScale animated:YES];
    } else {
        [self.scrollView setZoomScale:self.scrollView.maximumZoomScale animated:YES];
    }
}

#pragma mark - UIScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return self.container;
}

- (void)addConstraints {
    
    [self.zoomableView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    // leading
    NSLayoutConstraint *leadingSpacing = [NSLayoutConstraint constraintWithItem:self.zoomableView
                                                                      attribute:NSLayoutAttributeLeading
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:self.container
                                                                      attribute:NSLayoutAttributeLeading
                                                                     multiplier:1.f
                                                                       constant:0.f];
    
    // trailing
    NSLayoutConstraint *trailingSpacing = [NSLayoutConstraint constraintWithItem:self.zoomableView
                                                                       attribute:NSLayoutAttributeTrailing
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:self.container
                                                                       attribute:NSLayoutAttributeTrailing
                                                                      multiplier:1.f
                                                                        constant:0.f];
    
    // top
    NSLayoutConstraint *topSpacing = [NSLayoutConstraint constraintWithItem:self.zoomableView
                                                                  attribute:NSLayoutAttributeTop
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:self.container
                                                                  attribute:NSLayoutAttributeTop
                                                                 multiplier:1.f
                                                                   constant:0.f];
    // bottom
    NSLayoutConstraint *bottomSpacing = [NSLayoutConstraint constraintWithItem:self.zoomableView
                                                                     attribute:NSLayoutAttributeBottom
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.container
                                                                     attribute:NSLayoutAttributeBottom
                                                                    multiplier:1.f
                                                                      constant:0.f];
    [self.container addConstraint:leadingSpacing];
    [self.container addConstraint:trailingSpacing];
    [self.container addConstraint:topSpacing];
    [self.container addConstraint:bottomSpacing];
}

@end
