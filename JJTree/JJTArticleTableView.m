//
//  JJTArticleTableView.m
//  JJTree
//
//  Created by guojun on 7/26/15.
//  Copyright (c) 2015 guojunxu. All rights reserved.
//

#import "JJTArticleTableView.h"
#import "JJTAuthorHeaderView.h"

#import "JJTParagraph.h"

#import "JJTPlainTextParagraphTableCell.h"
#import "JJTBlockParagraphTableViewCell.h"
#import "JJTPictureParagraphTableViewCell.h"

static NSString *PLAIN_TEXT = @"PLAINTEXT";
static NSString *BLOCK = @"BLOCK";
static NSString *PICTURE = @"PICTURE";

@interface JJTArticleTableView()<JJTAuthorHeaderViewDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) IBOutlet UITableView *articleTableView;
@property (nonatomic, strong) JJTAuthorHeaderView *authorHeaderView;
@property (nonatomic, strong) NSArray *paragraphs;

@property (nonatomic, strong) JJTPlainTextParagraphTableCell *plainTextParagraphTableCell;

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
    view.backgroundColor = [UIColor clearColor];
    self.backgroundColor = [UIColor clearColor];
    
    [self addSubview:view];
}

- (void)addTableHead{
    self.articleTableView.tableHeaderView = self.authorHeaderView;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.paragraphs.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    JJTParagraph *paragrah = self.paragraphs[indexPath.section];
    if ([paragrah.type isEqualToNumber:@(JJTParagraphPlainText)]) {// PLAIN TEXT
        JJTPlainTextParagraphTableCell *cell = (JJTPlainTextParagraphTableCell *)[tableView dequeueReusableCellWithIdentifier:PLAIN_TEXT];
    
        if (!cell) {
            cell = [[JJTPlainTextParagraphTableCell alloc] initWithStyle:UITableViewCellStyleValue1
                                                         reuseIdentifier:PLAIN_TEXT];
        }
        
        self.plainTextParagraphTableCell = cell;
        cell.text = paragrah.content;
        
        return cell;
    } else if ([paragrah.type isEqualToNumber:@(JJTParagraphBlock)]){// BLOCK
        JJTBlockParagraphTableViewCell *cell = (JJTBlockParagraphTableViewCell *)[tableView dequeueReusableCellWithIdentifier:BLOCK];
        
        if (!cell) {
            cell = [[JJTBlockParagraphTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                                         reuseIdentifier:PLAIN_TEXT];
        }

        cell.blockURL = paragrah.content;
        
        return cell;
    } else if ([paragrah.type isEqualToNumber:@(JJTParagraphPicture)]){
        JJTPictureParagraphTableViewCell *cell = (JJTPictureParagraphTableViewCell *)[tableView dequeueReusableCellWithIdentifier:BLOCK];
        
        if (!cell) {
            cell = [[JJTPictureParagraphTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                                         reuseIdentifier:PICTURE];
        }
        
        cell.pictureURL = paragrah.content;
        
        return cell;
    }
    
    return nil;
}


#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if ([self.delegate respondsToSelector:@selector(articleTableView:didSelectRowAtIndex:)]) {
        [self.delegate articleTableView:self didSelectRowAtIndex:indexPath.section];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    JJTParagraph *paragrah = self.paragraphs[indexPath.section];
    if ([paragrah.type isEqualToNumber:@(JJTParagraphPlainText)]) {// PLAIN TEXT
        
        return 16 + self.plainTextParagraphTableCell.plainTextLabelSize.height;
    } else if ([paragrah.type isEqualToNumber:@(JJTParagraphBlock)]){// BLOCK
        return 240;
    } else if ([paragrah.type isEqualToNumber:@(JJTParagraphPicture)]){
        return 120;
    }
    
    return 0.0f;;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01f;
}
#pragma mark - JJTAuthorHeaderViewDelegate
- (void)authorHeaderViewDidPress:(JJTAuthorHeaderView *)header{
    if ([self.delegate respondsToSelector:@selector(articleTableViewDidSelectAuthorHeader:)]) {
        [self.delegate articleTableViewDidSelectAuthorHeader:self];
    }
}

#pragma mark - Getters & Setters
- (JJTAuthorHeaderView *)authorHeaderView{
    if (!_authorHeaderView) {
        _authorHeaderView = [JJTAuthorHeaderView new];
        _authorHeaderView.frame = CGRectMake(0, 0, self.articleTableView.bounds.size.width, 66);
        
        _authorHeaderView.article = self.article;
        _authorHeaderView.author = self.author;
        
        _authorHeaderView.delegate = self;
    }
    
    return _authorHeaderView;
}

- (void)setArticle:(JJTArticle *)article{
    _article = article;
    
    self.authorHeaderView.article = article;
    self.paragraphs = [article.paragraphs array];
    
    [self.articleTableView reloadData];
}

- (void)setAuthor:(JJTUser *)author{
    if (_author != author) {
        _author = author;
        
        self.authorHeaderView.author = author;
    }
}

//- (NSMutableArray *)cells{
//    if (!_cells) {
//        _cells = [NSMutableArray new];
//    }
//    
//    return _cells;
//}
@end
