//
//  JJTAuthorTableView.m
//  JJTree
//
//  Created by guojun on 7/28/15.
//  Copyright (c) 2015 guojunxu. All rights reserved.
//

#import "JJTAuthorTableView.h"
#import "JJTAuthorHeader.h"
#import "JJTArticle.h"

@interface JJTAuthorTableView()<JJTAuthorHeaderDelegate>

@property (nonatomic, weak) IBOutlet UITableView *authorTableView;
@property (nonatomic, strong) JJTAuthorHeader *authorHeader;
@property (nonatomic, strong) NSMutableArray *titles;

@property (nonatomic, assign) BOOL isOpen;

@end

@implementation JJTAuthorTableView

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
    self.authorTableView.tableHeaderView = self.authorHeader;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.isOpen) {
        return self.articles.count + 2;
    } else {
        return 2;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"cellIdentifier";
    
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:cellIdentifier];
        
    }
    
    if (!self.isOpen) {
        cell.textLabel.text = self.titles[indexPath.row];
    } else {
        if (indexPath.row == 0) {
            cell.textLabel.text = [self.titles firstObject];
        } else if (indexPath.row == (self.articles.count + 1)) {
            cell.textLabel.text = [self.titles lastObject];
        } else {
            JJTArticle *article = self.articles[indexPath.row - 1];
            cell.textLabel.text = article.title;
        }
    }
//    if (indexPath.row == 0 || indexPath.row == (self.articles.count + 1)) {
//        cell.textLabel.text = self.titles[indexPath.row];
//    } else {
//        
//        JJTArticle *article = self.articles[indexPath.row - 1];
//        cell.textLabel.text = article.title;
//    }
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (!self.isOpen) {
        if (indexPath.row == 0) {
            if (self.articles.count > 0) {
                // add data and then open it
                self.isOpen = !self.isOpen;
                
                [self insertArticles];
                [self insertRows:tableView];
                
                [tableView reloadData];
            } else {
                // do nothing
            }
        } else if (indexPath.row == 1){
            // do nothing
        }
    } else {
        if (indexPath.row == 0) {
            if (self.articles.count > 0) {
                // remove data and then close it
                self.isOpen = !self.isOpen;
                
                [self removeArticles];
                [self removeRows:tableView];
                
                [tableView reloadData];
            } else {
                // do nothing
            }
        } else if (indexPath.row == self.articles.count + 1) {
            // do nothing
        }
    }
}

- (void)insertArticles{
    [self.titles insertObject:[self titlesOfArticles] atIndex:1];
}

- (NSArray *)indexes {

    NSMutableArray *indexes = [NSMutableArray new];
    for (int i = 0; i < self.articles.count; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:(1 + i) inSection:0];
        [indexes addObject:indexPath];
    }
    return indexes;
}

- (void)insertRows:(UITableView *)tableView{
    [tableView insertRowsAtIndexPaths:[self indexes] withRowAnimation:(UITableViewRowAnimationAutomatic)];
}

- (void)removeArticles{
    if (self.titles.count > 2) {

        NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndexesInRange:NSMakeRange(1, self.articles.count)];
        [self.titles removeObjectsAtIndexes:indexSet];
    }
}

- (void)removeRows:(UITableView *)tableView{
    if (self.titles.count > 2) {
        [tableView deleteRowsAtIndexPaths:[self indexes] withRowAnimation:(UITableViewRowAnimationAutomatic)];
    }
}

- (NSArray *)titlesOfArticles{
    
    NSMutableArray *array = [NSMutableArray new];
    for (JJTArticle *article in self.articles) {
        [array addObject:article.title];
    }
    
    return array;
}

#pragma mark - JJTAuthorHeaderDelegate
- (void)authorHeaderDidPressWatchButton:(JJTAuthorHeader *)header{
    
}

#pragma mark - Getters & Setters
- (JJTAuthorHeader *)authorHeader{
    if (!_authorHeader) {
        CGRect frame = CGRectMake(0, 0, self.bounds.size.width, 66.f);
        _authorHeader = [[JJTAuthorHeader alloc] initWithFrame:frame];
        _authorHeader.delegate = self;
    }
    
    return _authorHeader;
}

- (void)setArticles:(NSArray *)articles{
    if (_articles != articles) {
        _articles = articles;
        
        [self.authorTableView reloadData];
    }
}

- (void)setAuthor:(JJTAuthor *)author{
    if (_author != author) {
        _author = author;
        
        self.authorHeader.avatarURL = author.avatarURL;
    }
}

- (NSArray *)titles{
    if (!_titles) {
        _titles = [[NSMutableArray alloc] initWithArray:@[@"机经总量", @"获得打赏总金额"]];
    }
    
    return _titles;
}

@end
