//
//  JJTAuthorViewController.m
//  JJTree
//
//  Created by guojun on 7/28/15.
//  Copyright (c) 2015 guojunxu. All rights reserved.
//

#import "JJTAuthorViewController.h"
#import "JJTAuthorTableView.h"
#import "JJTArticleViewController.h"
#import "JJTArticle.h"
#import <MagicalRecord/MagicalRecord.h>

@interface JJTAuthorViewController ()<JJTAuthorTableViewDelegate>

@property (nonatomic, weak) IBOutlet JJTAuthorTableView *authorTableView;
@property (nonatomic, weak) IBOutlet UIBarButtonItem *rewardAuthorButton;

@end

@implementation JJTAuthorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableArray *articles = [NSMutableArray new];
    for (int i = 0; i < 10; i++) {
        JJTArticle *article = [JJTArticle MR_createEntity];
        article.articleID = @(i);
        article.title = [NSString stringWithFormat:@"Article %d", i];
        article.usefulValue = @(6);
        article.uselessValue = @(5);
        article.viewCount = @(99);
        
        [articles addObject:article];
    }
    
    self.title = self.author.roleName;
    self.authorTableView.author = self.author;
    self.authorTableView.articles = articles;
}

- (IBAction)rewardButtonDidPress:(id)sender {
}

#pragma mark - JJTAuthorTableViewDelegate
- (void)authorTableView:(JJTAuthorTableView *)tableView didSelectArticle:(JJTArticle *)article atIndex:(NSInteger)index{
    JJTArticleViewController *articleVC = [JJTArticleViewController new];
    articleVC.article = article;
    articleVC.author = self.author;
    
    [self.navigationController pushViewController:articleVC animated:YES];
}

@end
