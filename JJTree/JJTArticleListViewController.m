//
//  ViewController.m
//  JJTree
//
//  Created by guojun on 7/22/15.
//  Copyright (c) 2015 guojunxu. All rights reserved.
//

#import "JJTArticleListViewController.h"
#import "JJTArticleListTableView.h"
#import "JJTArticle.h"
#import "JJTParagraph.h"
#import "JJTArticleViewController.h"
#import <MagicalRecord.h>

@interface JJTArticleListViewController ()<JJTArticleListTableViewDelegate>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *leftBarButtonItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *searchBarButtonItem;
@property (weak, nonatomic) IBOutlet UISegmentedControl *filterSegmentedControl;
@property (weak, nonatomic) IBOutlet JJTArticleListTableView *articleTableView;

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
        article.title = [NSString stringWithFormat:@"Article Title %d", (i + 1)];
        article.usefulValue = @(100 + i);
        article.uselessValue = @(10 + i);
        article.rewardGotAmount = @(99 + i);
        
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
        
        article.paragraphs = [[NSOrderedSet alloc] initWithArray:@[p1, p2, p3]];
        
        [articles addObject:article];
    }
    
    self.articleTableView.articles = articles;
}

- (NSString *)readFile{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"testText"
                                                     ofType:@"txt"];
    NSString *content = [NSString stringWithContentsOfFile:path
                                                  encoding:NSUTF8StringEncoding
                                                     error:NULL];
    
    return content;
}

#pragma mark - JJTArticleTableViewDelegate
- (void)articleTableView:(JJTArticleListTableView *)tableView didSelectRowAtIndex:(NSInteger)index withArticle:(JJTArticle *)article{
    JJTArticleViewController *articleVC = [JJTArticleViewController new];
    articleVC.article = article;
    [self.navigationController pushViewController:articleVC animated:YES];
}

@end
