//
//  JJTArticleTableView.m
//  JJTree
//
//  Created by guojun on 7/26/15.
//  Copyright (c) 2015 guojunxu. All rights reserved.
//

#import "JJTArticleListTableView.h"
#import "JJTArticleTableCell.h"
#import <MagicalRecord/MagicalRecord.h>
#import "JJTUser.h"
#import "JJTUser+JJTAddition.h"
#import <CCBottomRefreshControl/UIScrollView+BottomRefreshControl.h>

@interface JJTArticleListTableView()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) IBOutlet UITableView *articlesTableView;
@property (nonatomic, strong) UIRefreshControl *loadMoreControl;

@property (nonatomic, strong) NSIndexPath *selectedIndexPath;

@end

@implementation JJTArticleListTableView

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        
        [self loadView];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self loadView];
    }
    
    return self;
}

- (void)reloadData{
    [self.articlesTableView reloadData];
}

#pragma mark - Private Methods
- (void)loadView{
    UIView *view = [[[NSBundle bundleForClass:[self class]] loadNibNamed:NSStringFromClass([self class])
                                                                   owner:self
                                                                 options:nil] firstObject];
    
    view.frame = self.bounds;
    
    [self addSubview:view];
}

- (void)loadMore{
    if ([self.delegate respondsToSelector:@selector(articleTableView:didTriggerLoadMoreControl:)]) {
        [self.delegate articleTableView:self didTriggerLoadMoreControl:self.loadMoreControl];
    }
}

- (NSPredicate *)predicate:(NSNumber *)articleID{
    NSPredicate *preficate = [NSPredicate predicateWithFormat:@"userID = %@ AND articleID = %@", [JJTUser currentUser].userID, articleID];
    
    return preficate;
}

- (JJTReadBehavior *)readBehavior:(NSNumber *)articleID{
    JJTReadBehavior *readBehavior = [JJTReadBehavior MR_findFirstWithPredicate:[self predicate:articleID]];
    
    return readBehavior;
}

- (void)keepSelectedCellAsHighlighted {
    if (self.selectedIndexPath) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.articlesTableView selectRowAtIndexPath:self.selectedIndexPath
                                                animated:NO
                                          scrollPosition:UITableViewScrollPositionNone];
        });
    }
}
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.articles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"cellIdentifier";
    
    JJTArticleTableCell *cell = (JJTArticleTableCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = [[JJTArticleTableCell alloc] initWithStyle:UITableViewCellStyleValue1
                                      reuseIdentifier:cellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    JJTArticle *article = self.articles[indexPath.row];
    cell.article = article;
    cell.readBehavior = [self readBehavior:article.articleID];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    self.selectedIndexPath = indexPath;
    
    if ([self.delegate respondsToSelector:@selector(articleTableView:didSelectRowAtIndex:withArticle:)]) {
        [self.delegate articleTableView:self
                    didSelectRowAtIndex:indexPath.row
                            withArticle:self.articles[indexPath.row]];
    }
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01f;
}

#pragma mark - Getters & Setters

- (void)setArticles:(NSArray *)articles{
    if (_articles != articles) {
        _articles = articles;
        
        [self.articlesTableView reloadData];
        
        [self keepSelectedCellAsHighlighted];
    }
}

- (UIRefreshControl *)loadMoreControl{
    if (!_loadMoreControl) {
        _loadMoreControl = [UIRefreshControl new];
        _loadMoreControl.triggerVerticalOffset = 100.;
        _loadMoreControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"上拉加载更多"];
        [_loadMoreControl addTarget:self action:@selector(loadMore) forControlEvents:UIControlEventValueChanged];
    }
    
    return _loadMoreControl;
}

#pragma mark - Getters & Setters
- (void)setAllowLoadMore:(BOOL)allowLoadMore{
    _allowLoadMore = allowLoadMore;
    if (allowLoadMore) {
        self.articlesTableView.bottomRefreshControl = self.loadMoreControl;
    } else {
        self.articlesTableView.bottomRefreshControl = nil;
    }
}

@end
