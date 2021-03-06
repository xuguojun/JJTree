//
//  JJTBehaviorsTableView.m
//  JJTree
//
//  Created by guojun on 8/9/15.
//  Copyright (c) 2015 guojunxu. All rights reserved.
//

#import "JJTBehaviorsTableView.h"
#import "JJTBehaviorTableViewCell.h"
#import "JJTUser.h"
#import "JJTArticle.h"

static NSString *HAS_ARTICLE_COUNT = @"共有%lu篇机经";

@interface JJTBehaviorsTableView()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) IBOutlet UITableView *behaviorsTableView;

@end
@implementation JJTBehaviorsTableView

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

#pragma mark - Private Methods
- (void)loadView{
    UIView *view = [[[NSBundle bundleForClass:[self class]] loadNibNamed:NSStringFromClass([self class])
                                                                   owner:self
                                                                 options:nil] firstObject];
    
    view.frame = self.bounds;
    
    [self addSubview:view];
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
    
    JJTBehaviorTableViewCell *cell = (JJTBehaviorTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = [[JJTBehaviorTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                      reuseIdentifier:cellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    JJTUser *author = self.authors[indexPath.row];
    JJTArticle *article = self.articles[indexPath.row];
    
    cell.author = author;
    cell.article = article;
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if ([self.delegate respondsToSelector:@selector(behaviorTableView:didSelectRowAtIndex:)]) {
        [self.delegate behaviorTableView:self didSelectRowAtIndex:indexPath.row];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55.f;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [NSString stringWithFormat:HAS_ARTICLE_COUNT, (unsigned long)self.articles.count];
}

#pragma mark - Getters & Setters
- (void)setArticles:(NSArray *)articles{
    if (_articles != articles) {
        _articles = articles;
        
        [self.behaviorsTableView reloadData];
    }
}

- (void)setAuthors:(NSArray *)authors{
    if (_authors != authors) {
        _authors = authors;
        
        [self.behaviorsTableView reloadData];
    }
}

@end
