//
//  JJTArticleTableView.m
//  JJTree
//
//  Created by guojun on 7/26/15.
//  Copyright (c) 2015 guojunxu. All rights reserved.
//

#import "JJTArticleTableView.h"
#import "JJTAuthorHeaderView.h"

@interface JJTArticleTableView()

@property (nonatomic, weak) IBOutlet UITableView *articleTableView;
@property (nonatomic, strong) JJTAuthorHeaderView *authorHeaderView;

@end

@implementation JJTArticleTableView

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        
        [self loadView];
        [self addTableHead];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self loadView];
        [self addTableHead];
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

- (void)addTableHead{
    self.articleTableView.tableHeaderView = self.authorHeaderView;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"cellIdentifier";
    
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                      reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.text = @"Paragraph";
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 48.f;
}

#pragma mark - Getters & Setters
- (JJTAuthorHeaderView *)authorHeaderView{
    if (!_authorHeaderView) {
        _authorHeaderView = [JJTAuthorHeaderView new];
        _authorHeaderView.frame = CGRectMake(0, 0, self.articleTableView.bounds.size.width, 66);
        
        _authorHeaderView.article = self.article;
        _authorHeaderView.author = self.author;
    }
    
    return _authorHeaderView;
}

- (void)setArticle:(JJTArticle *)article{
    if (_article != article) {
        _article = article;
        
        self.authorHeaderView.article = article;
    }
}

- (void)setAuthor:(JJTAuthor *)author{
    if (_author != author) {
        _author = author;
        
        self.authorHeaderView.author = author;
    }
}
@end
