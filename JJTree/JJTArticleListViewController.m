//
//  ViewController.m
//  JJTree
//
//  Created by guojun on 7/22/15.
//  Copyright (c) 2015 guojunxu. All rights reserved.
//

#import "JJTArticleListViewController.h"
#import "JJTArticleTableView.h"
#import "JJTArticle.h"
#import <MagicalRecord.h>

@interface JJTArticleListViewController ()<JJTArticleTableViewDelegate>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *leftBarButtonItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *searchBarButtonItem;
@property (weak, nonatomic) IBOutlet UISegmentedControl *filterSegmentedControl;
@property (weak, nonatomic) IBOutlet JJTArticleTableView *articleTableView;

@end

@implementation JJTArticleListViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"JJTree";
    
    NSMutableArray *articles = [NSMutableArray new];
    for (int i = 0; i < 10; i++) {
        JJTArticle *article = [JJTArticle MR_createEntity];
        article.articleID = @(i);
        article.createdAt = [NSDate new];
        article.title = [NSString stringWithFormat:@"Artitle Title %d", (i + 1)];
        article.usefulValue = @(100 + i);
        article.rewardGotAmount = @(99 + i);
        
        [articles addObject:article];
    }
    
    self.articleTableView.articles = articles;
}

#pragma mark - JJTArticleTableViewDelegate
- (void)articleTableView:(JJTArticleTableView *)tableView didSelectRowAtIndex:(NSInteger)index{
    
}

@end
