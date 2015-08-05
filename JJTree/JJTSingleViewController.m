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

@end

@implementation JJTSingleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.zoomableView.frame = self.scrollView.bounds;
    [self.container addSubview:self.zoomableView];
}

#pragma mark - UIScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return self.container;
}

@end
