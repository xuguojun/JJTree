//
//  JJTFullReadViewController.m
//  JJTree
//
//  Created by guojun on 8/2/15.
//  Copyright (c) 2015 guojunxu. All rights reserved.
//

#import "JJTFullReadViewController.h"
#import "JJTSingleViewController.h"

@interface JJTFullReadViewController ()<UIPageViewControllerDataSource, UIPageViewControllerDelegate>

@property (nonatomic, strong) UIPageViewController *pageController;
@property (nonatomic, strong) NSMutableArray *viewControllers;

@property (nonatomic, assign) NSInteger nextIndex;
@property (nonatomic, assign) NSInteger currentIndex;

@end

@implementation JJTFullReadViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    for (int i = 0; i < 5; i++) {
        
        UILabel *plainText = [UILabel new];
        
        plainText.text = [NSString stringWithFormat:@"TEST %d", i];
        plainText.textAlignment = NSTextAlignmentCenter;
        plainText.backgroundColor = [UIColor redColor];
        
        JJTSingleViewController *single = [JJTSingleViewController new];
        single.zoomableView = plainText;
        single.index = i;
        
        [self.viewControllers addObject:single];
    }
    
    [self setTitleWithPageIndex:self.currentIndex];
    
    [self addChildViewController:self.pageController];
    [self.view addSubview:self.pageController.view];
    [self.pageController didMoveToParentViewController:self];
}

#pragma mark - UIPageViewControllerDataSource
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController
       viewControllerAfterViewController:(UIViewController *)viewController{
    
    JJTSingleViewController *single = (JJTSingleViewController *)viewController;
    
    if (single.index != (self.viewControllers.count - 1)) {
        return self.viewControllers[single.index + 1];
    }
    
    return nil;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController
      viewControllerBeforeViewController:(UIViewController *)viewController{
    
    JJTSingleViewController *single = (JJTSingleViewController *)viewController;
    
    if (!single.index == 0) {
        return self.viewControllers[single.index - 1];
    }
    
    return nil;
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController{
    return self.viewControllers.count;
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController{
    return self.currentIndex;
}

- (void)pageViewController:(UIPageViewController *)pageViewController
willTransitionToViewControllers:(NSArray *)pendingViewControllers{
    JJTSingleViewController *single = (JJTSingleViewController *)[pendingViewControllers firstObject];
    self.nextIndex = [self.viewControllers indexOfObject:single];
}

- (void)pageViewController:(UIPageViewController *)pageViewController
        didFinishAnimating:(BOOL)finished
   previousViewControllers:(NSArray *)previousViewControllers
       transitionCompleted:(BOOL)completed{
    
    if (completed) {
        self.currentIndex = self.nextIndex;
    }
    
    self.nextIndex = 0;
    
    [self setTitleWithPageIndex:self.currentIndex];
}

- (void)setTitleWithPageIndex:(NSInteger)index{
    self.title= [NSString stringWithFormat:@"%lu/%lu", ((long)index + 1), (unsigned long)self.viewControllers.count];
}

#pragma mark - Getters & Setters
- (UIPageViewController *)pageController{
    if (!_pageController) {
        _pageController = [[UIPageViewController alloc]
                           initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                           navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                           options:nil];
        
        _pageController.view.frame = self.view.bounds;
        
        _pageController.dataSource = self;
        _pageController.delegate = self;
        
        [_pageController setViewControllers:@[self.viewControllers[0]]
                                  direction:UIPageViewControllerNavigationDirectionForward
                                   animated:YES
                                 completion:^(BOOL finished) {
                                     ;
                                 }];
    }
    
    return _pageController;
}

- (NSMutableArray *)viewControllers{
    if (!_viewControllers) {
        _viewControllers = [NSMutableArray new];
    }
    
    return _viewControllers;
}

@end
