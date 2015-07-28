//
//  JJTBlockWebView.m
//  JJTree
//
//  Created by guojun on 7/28/15.
//  Copyright (c) 2015 guojunxu. All rights reserved.
//

#import "JJTBlockWebView.h"
#import "JJTBlockLineTableViewCell.h"

static float CELL_HEIGHT = (26.5f);

@interface JJTBlockWebView()<UITableViewDataSource, UITableViewDelegate, UIWebViewDelegate, UIScrollViewDelegate>

@property (nonatomic, weak) IBOutlet UITableView *lineTableView;
@property (nonatomic, weak) IBOutlet UIWebView *blockWebView;

@property (nonatomic, strong) UIScrollView *webScrollView;

@end
@implementation JJTBlockWebView

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        
        [self loadView];
        [self configureView];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self loadView];
        [self configureView];
    }
    
    return self;
}

#pragma mark - Private Methods
- (void)loadView{
    UIView *view = [[[NSBundle bundleForClass:[self class]] loadNibNamed:NSStringFromClass([self class])
                                                                   owner:self
                                                                 options:nil] firstObject];
    
    view.frame = self.bounds;
    
    [self addSubview:view];
}

- (void)configureView{
    
    self.webScrollView = self.blockWebView.scrollView;
    self.webScrollView.delegate = self;
    
    [self.webScrollView setShowsHorizontalScrollIndicator:NO];
}
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 999;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"cellIdentifier";
    
    JJTBlockLineTableViewCell *cell = (JJTBlockLineTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = [[JJTBlockLineTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.line = indexPath.row + 1;
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"content size height = %f",     self.blockWebView.scrollView.contentSize.height);
    
    return CELL_HEIGHT;
}

#pragma mark - 
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == self.lineTableView) {
        CGPoint lineScrollViewContentOffset = self.lineTableView.contentOffset;
        lineScrollViewContentOffset.y = scrollView.contentOffset.y;
        self.webScrollView.contentOffset = lineScrollViewContentOffset;
    } else if (scrollView == self.webScrollView){
        CGPoint webScrollViewContentOffset = self.webScrollView.contentOffset;
        webScrollViewContentOffset.y = scrollView.contentOffset.y;
        self.lineTableView.contentOffset = webScrollViewContentOffset;
    }
}

#pragma mark - Getters & Setters
- (void)setBlockURL:(NSString *)blockURL{
    if (_blockURL != blockURL) {
        _blockURL = blockURL;
        
        [self.blockWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:blockURL]]];
        [self.lineTableView reloadData];
    }
}

@end
