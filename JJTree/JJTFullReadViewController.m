//
//  JJTFullReadViewController.m
//  JJTree
//
//  Created by guojun on 8/2/15.
//  Copyright (c) 2015 guojunxu. All rights reserved.
//

#import "JJTFullReadViewController.h"
#import "JJTSingleViewController.h"

@interface JJTFullReadViewController ()<UIPageViewControllerDataSource, UIPageViewControllerDelegate, JJTSingleViewControllerDelegate>

@property (nonatomic, strong) UIPageViewController *pageController;
@property (nonatomic, strong) NSMutableArray *viewControllers;

@property (nonatomic, assign) NSInteger nextIndex;
@property (nonatomic, assign) NSInteger currentIndex;

@end

@implementation JJTFullReadViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    for (int i = 0; i < self.article.paragraphs.count; i++) {
        
        JJTSingleViewController *single = [JJTSingleViewController new];
        single.paragraph = [self.article.paragraphs array][i];
        single.delegate = self;
        single.index = i;
        
        [self.viewControllers addObject:single];
    }
    
    [self setTitleWithPageIndex:self.selectedIndex];
    
    [self addChildViewController:self.pageController];
    [self.view addSubview:self.pageController.view];
    [self.pageController didMoveToParentViewController:self];
    
    [self turnToPage:self.selectedIndex];
//    self.title = self.article.title;
}

#pragma mark - Private Methods
- (void)setTitleWithPageIndex:(NSInteger)index{
    self.title= [NSString stringWithFormat:@"%lu/%lu", ((long)index + 1), (unsigned long)self.viewControllers.count];
}

- (void)turnToPage:(NSInteger)index{
    
    if (index >= 0 && index < self.viewControllers.count) {
        [self.pageController setViewControllers:@[self.viewControllers[index]]
                                      direction:UIPageViewControllerNavigationDirectionForward
                                       animated:YES
                                     completion:NULL];
        self.currentIndex = self.selectedIndex;
        [self setTitleWithPageIndex:self.currentIndex];
    }
}

#pragma mark - JJTSingleViewControllerDelegate
- (void)singleViewController:(JJTSingleViewController *)controller didHideNavigationBar:(BOOL)hidden{
    if (hidden) {
        self.view.backgroundColor = [UIColor blackColor];
    } else {
        self.view.backgroundColor = [UIColor whiteColor];
    }
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
