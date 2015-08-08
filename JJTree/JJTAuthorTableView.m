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

- (void)insertArticles{
    [self.titles insertObjects:[self titlesOfArticles] atIndexes:[self indexSet]];
}

- (NSArray *)indexes {
    
    NSMutableArray *indexes = [NSMutableArray new];
    for (int i = 0; i < self.articles.count; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:(1 + i) inSection:0];
        [indexes addObject:indexPath];
    }
    return indexes;
}

- (NSIndexSet *)indexSet{
    NSMutableIndexSet *indexes = [[NSMutableIndexSet alloc] init];
    for (int i = 0; i < self.articles.count; i++) {
        [indexes addIndex:(1 + i)];
    }
    
    return indexes;
}

- (void)insertRows:(UITableView *)tableView{
    [tableView insertRowsAtIndexPaths:[self indexes] withRowAnimation:(UITableViewRowAnimationAutomatic)];
}

- (void)removeArticles{
    if (self.titles.count > 2) {
        
        NSMutableIndexSet *indexes = [[NSMutableIndexSet alloc] init];
        for (int i = 0; i < self.articles.count; i++) {
            [indexes addIndex:(1 + i)];
        }
        
        [self.titles removeObjectsAtIndexes:indexes];
    }
}

- (void)removeRows:(UITableView *)tableView{
    if (self.titles.count > 2) {
        [tableView deleteRowsAtIndexPaths:[self indexes] withRowAnimation:(UITableViewRowAnimationMiddle)];
    }
}

- (NSArray *)titlesOfArticles{
    
    NSMutableArray *array = [NSMutableArray new];
    for (JJTArticle *article in self.articles) {
        [array addObject:article.title];
    }
    
    return array;
}

- (NSMutableAttributedString *)totalAmount:(BOOL)up{
    
    NSString *text = [NSString stringWithFormat:@"%lu篇 %@", (unsigned long)self.articles.count, up ? @"⊻" : @"⊼"];
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:text];
    
    NSRange rang = NSMakeRange(text.length - 1, 1);
    [string addAttribute:NSFontAttributeName
                   value:[UIFont boldSystemFontOfSize:20]
                   range:rang];
    
    [string addAttribute:NSForegroundColorAttributeName
                   value:[UIColor lightGrayColor]
                   range:rang];
    
    return string;
}

- (void)reloadData{
    [self.authorTableView reloadData];
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
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                      reuseIdentifier:cellIdentifier];
        
    }
    
    if (!self.isOpen) {
        cell.textLabel.text = self.titles[indexPath.row];

        if (indexPath.row == 0) {
            cell.detailTextLabel.attributedText = [self totalAmount:YES];
        } else {
            cell.detailTextLabel.text = @"💰￥999.00";
        }
        
        cell.accessoryType = UITableViewCellAccessoryNone;
    } else {
        if (indexPath.row == 0) {
            cell.textLabel.text = [self.titles firstObject];
            cell.detailTextLabel.attributedText = [self totalAmount:NO];
            cell.accessoryType = UITableViewCellAccessoryNone;
            
        } else if (indexPath.row == (self.articles.count + 1)) {
            cell.textLabel.text = [self.titles lastObject];
            cell.detailTextLabel.text = @"💰￥999.00";
            cell.accessoryType = UITableViewCellAccessoryNone;
            
        } else {
            JJTArticle *article = self.articles[indexPath.row - 1];
            cell.textLabel.text = article.title;
            cell.detailTextLabel.text = [NSString stringWithFormat:@"👍%@", article.usefulValue];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (!self.isOpen) {
        if (indexPath.row == 0) {
            if (self.articles.count > 0) {
                // add data and then open it
                self.isOpen = !self.isOpen;
                
                [self insertArticles];
                [self insertRows:tableView];
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
        } else {
            if ([self.delegate respondsToSelector:@selector(authorTableView:didSelectArticle:atIndex:)]) {
                
                NSInteger index = indexPath.row - 1;
                JJTArticle *article = self.articles[index];
                [self.delegate authorTableView:self didSelectArticle:article atIndex:(index)];
            }
        }
    }
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
