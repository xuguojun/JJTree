//
//  JJTSearchViewController.m
//  JJTree
//
//  Created by guojun on 7/29/15.
//  Copyright (c) 2015 guojunxu. All rights reserved.
//

#import "JJTSearchViewController.h"
#import "JJTArticleListTableView.h"
#import "JJTArticleViewController.h"
#import "JJTUser.h"
#import "JJTArticle.h"
#import "JJTParagraph.h"
#import <MagicalRecord/MagicalRecord.h>

@interface JJTSearchViewController ()<JJTArticleListTableViewDelegate, UISearchBarDelegate>

@property (nonatomic, weak) IBOutlet JJTArticleListTableView *articlesTableView;
@property (nonatomic, strong) UISearchBar *articleSearchBar;

@property (nonatomic, weak) IBOutlet UIToolbar *filterToolBar;

@property (nonatomic, weak) IBOutlet UIBarButtonItem *usefulButton;
@property (nonatomic, weak) IBOutlet UIBarButtonItem *uselessButton;
@property (nonatomic, weak) IBOutlet UIBarButtonItem *readButton;
@property (nonatomic, weak) IBOutlet UIBarButtonItem *unreadButton;

@end

@implementation JJTSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSMutableArray *articles = [NSMutableArray new];
    for (int i = 0; i < 10; i++) {
        JJTArticle *article = [JJTArticle MR_createEntity];
        article.articleID = @(i);
        article.createdAt = [NSDate new];
        article.title = [NSString stringWithFormat:@"Article Title %d", (i + 1)];
        article.usefulValue = @(100 + i);
        article.uselessValue = @(10 + i);
        article.rewardGotAmount = @(99 + i);
        article.viewCount = @(1009);
        
        JJTParagraph *p1 = [JJTParagraph MR_createEntity];
        p1.type = @(JJTParagraphPlainText);
        p1.content = [self readFile];
        p1.position = @0;
        
        JJTParagraph *p2 = [JJTParagraph MR_createEntity];
        p2.type = @(JJTParagraphBlock);
        p2.content = @"http://localhost:8080/JJTree/index.html";
        p2.position = @1;
        
        JJTParagraph *p3 = [JJTParagraph MR_createEntity];
        p3.type = @(JJTParagraphPicture);
        p3.content = @"https://upload.wikimedia.org/wikipedia/commons/d/d7/IPad_2_Smart_Cover_at_unveiling_crop.jpg";
        p3.position = @2;
        
        JJTParagraph *p4 = [JJTParagraph MR_createEntity];
        p4.type = @(JJTParagraphPicture);
        p4.content = @"https://upload.wikimedia.org/wikipedia/commons/d/d7/IPad_2_Smart_Cover_at_unveiling_crop.jpg";
        p4.position = @2;
        
        JJTParagraph *p5 = [JJTParagraph MR_createEntity];
        p5.type = @(JJTParagraphBlock);
        p5.content = @"http://localhost:8080/JJTree/index.html";
        p5.position = @1;
        
        JJTParagraph *p6 = [JJTParagraph MR_createEntity];
        p6.type = @(JJTParagraphPlainText);
        p6.content = [self readFile];
        p6.position = @0;
        
        article.paragraphs = [[NSOrderedSet alloc] initWithArray:@[p1, p2, p3, p4, p5, p6]];
        
        [articles addObject:article];
    }
    
    self.articlesTableView.articles = articles;
    self.articleSearchBar.inputAccessoryView = self.filterToolBar;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar addSubview:self.articleSearchBar];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.articleSearchBar removeFromSuperview];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.articleSearchBar.frame = [self articleSearchBarFrame];
}

#pragma mark - Private Methods
- (CGRect)articleSearchBarFrame {
    CGFloat height = 44.f;
    CGFloat marginLeft = 32.f;
    CGFloat marginRight = 8.f;
    CGRect navigaitonBarBounds = self.navigationController.navigationBar.bounds;
    CGRect barFrame = CGRectMake(marginLeft, navigaitonBarBounds.size.height - height, navigaitonBarBounds.size.width - marginLeft - marginRight, height);
    
    return barFrame;
}

- (NSString *)readFile{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"testText"
                                                     ofType:@"txt"];
    NSString *content = [NSString stringWithContentsOfFile:path
                                                  encoding:NSUTF8StringEncoding
                                                     error:NULL];
    
    return content;
}

- (IBAction)usefulButtonDidPress:(id)sender{
    
}

- (IBAction)uselessButtonDidPress:(id)sender{
    
}

- (IBAction)readButtonDidPress:(id)sender{
    
}

- (IBAction)unreadButtonDidPress:(id)sender{
    
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
}

#pragma mark - JJTArticleListTableViewDelegate
- (void)articleTableView:(JJTArticleListTableView *)tableView didSelectRowAtIndex:(NSInteger)index withArticle:(JJTArticle *)article{
    
    JJTArticleViewController *articleVC = [JJTArticleViewController new];
    articleVC.article = article;
    
    JJTUser *author = [JJTUser MR_createEntity];
    author.userName = @"Guojun";
    author.userAvatarURL = @"http://www.moviecricket.com/wp-content/uploads/2014/09/James-Cameron-Looking-To-Shoot-Avatar-Sequels-In-120-FPS.jpg";
    
    articleVC.author = author;
    [self.navigationController pushViewController:articleVC animated:YES];
    
}

#pragma mark - Getters & Setters
- (UISearchBar *)articleSearchBar{
    if (!_articleSearchBar) {
        CGRect frame = [self articleSearchBarFrame];
        _articleSearchBar = [[UISearchBar alloc] initWithFrame:frame];
        _articleSearchBar.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
        _articleSearchBar.showsCancelButton = YES;
        _articleSearchBar.placeholder = @"在线搜索机经，请输入关键词";
        _articleSearchBar.delegate = self;
    }
    
    return _articleSearchBar;
}

@end
