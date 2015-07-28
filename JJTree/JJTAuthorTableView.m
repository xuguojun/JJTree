//
//  JJTAuthorTableView.m
//  JJTree
//
//  Created by guojun on 7/28/15.
//  Copyright (c) 2015 guojunxu. All rights reserved.
//

#import "JJTAuthorTableView.h"
#import "JJTAuthorHeader.h"

@interface JJTAuthorTableView()<JJTAuthorHeaderDelegate>

@property (nonatomic, weak) IBOutlet UITableView *authorTableView;
@property (nonatomic, strong) JJTAuthorHeader *authorHeader;
@property (nonatomic, strong) NSArray *titles;

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
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"cellIdentifier";
    
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:cellIdentifier];
        
    }
    
    cell.textLabel.text = self.titles[indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
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

- (NSArray *)titles{
    if (!_titles) {
        _titles = @[@"机经总量", @"获得打赏总金额"];
    }
    
    return _titles;
}

@end
