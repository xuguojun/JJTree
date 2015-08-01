//
//  ViewController.m
//  JJTree
//
//  Created by guojun on 7/22/15.
//  Copyright (c) 2015 guojunxu. All rights reserved.
//

#import "JJTArticleListViewController.h"
#import "JJTArticleListTableView.h"
#import "JJTAuthor.h"
#import "JJTArticle.h"
#import "JJTParagraph.h"
#import "JJTArticleViewController.h"
#import "JJTLoginViewController.h"
#import "JJTProfileViewController.h"
#import "JJTSearchViewController.h"
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

    self.title = @"元机经";
    
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

#pragma mark - IBAction
- (IBAction)leftButtonDidPress:(id)sender {
//    JJTLoginViewController *loginVC = [JJTLoginViewController new];
//    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginVC];
//    [self presentViewController:nav animated:YES completion:NULL];
    
    JJTProfileViewController *profileVC = [JJTProfileViewController new];
    [self.navigationController pushViewController:profileVC animated:YES];
}

- (IBAction)searchButtonDidPress:(id)sender {
    JJTSearchViewController *searchVC = [JJTSearchViewController new];
//    [self presentViewController:searchVC animated:YES completion:NULL];
    [self.navigationController pushViewController:searchVC animated:YES];
}

#pragma mark - JJTArticleTableViewDelegate
- (void)articleTableView:(JJTArticleListTableView *)tableView didSelectRowAtIndex:(NSInteger)index withArticle:(JJTArticle *)article{
    JJTArticleViewController *articleVC = [JJTArticleViewController new];
    articleVC.article = article;
    
    JJTAuthor *author = [JJTAuthor MR_createEntity];
    author.roleName = @"Guojun";
    author.avatarURL = @"http://www.moviecricket.com/wp-content/uploads/2014/09/James-Cameron-Looking-To-Shoot-Avatar-Sequels-In-120-FPS.jpg";
    
    articleVC.author = author;
    [self.navigationController pushViewController:articleVC animated:YES];
}

- (void)articleTableView:(JJTArticleListTableView *)tableView didTriggerLoadMoreControl:(UIRefreshControl *)control{
    NSLog(@"loading more...");
    [control endRefreshing];
}

@end
