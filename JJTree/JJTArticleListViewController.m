//
//  ViewController.m
//  JJTree
//
//  Created by guojun on 7/22/15.
//  Copyright (c) 2015 guojunxu. All rights reserved.
//

#import "JJTArticleListViewController.h"
#import "JJTArticleListTableView.h"
#import "JJTUser.h"
#import "JJTArticle.h"
#import "JJTParagraph.h"
#import "JJTArticleViewController.h"
#import "JJTLoginViewController.h"
#import "JJTProfileViewController.h"
#import "JJTSearchViewController.h"
#import "JJTUser+JJTAddition.h"
#import "NSString+JJTString.h"
#import <MagicalRecord.h>

@interface JJTArticleListViewController ()<JJTArticleListTableViewDelegate, JJTLoginViewControllerDelegate, JJTProfileViewControllerDelegate, JJTArticleViewControllerDelegate>

@property (strong, nonatomic) UIBarButtonItem *loginButton;
@property (strong, nonatomic) UIBarButtonItem *profileButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *searchBarButtonItem;
@property (weak, nonatomic) IBOutlet UISegmentedControl *filterSegmentedControl;
@property (weak, nonatomic) IBOutlet JJTArticleListTableView *articleTableView;

@end

@implementation JJTArticleListViewController
- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"元机经";
    
    if (self.currentUser && [self.currentUser.hasLogined boolValue]) {
        self.navigationItem.leftBarButtonItem = self.profileButton;
    } else {
        self.navigationItem.leftBarButtonItem = self.loginButton;
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    NSInteger index = [self.prefs integerForKey:BLOCK_STYLE_INDEX];
    
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
        p2.content = [NSString stringWithFormat:@"http://localhost:8080/JJTree/Block.jsp?style=%@", [self css][index]];
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
        p5.content = [NSString stringWithFormat:@"http://localhost:8080/JJTree/Block.jsp?style=%@", [self css][index]];
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
#pragma mark - Private Methods
- (NSString *)readFile{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"testText"
                                                     ofType:@"txt"];
    NSString *content = [NSString stringWithContentsOfFile:path
                                                  encoding:NSUTF8StringEncoding
                                                     error:NULL];
    
    return content;
}

- (NSString *)readCSSFile{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"css"
                                                     ofType:@"txt"];
    NSString *content = [NSString stringWithContentsOfFile:path
                                                  encoding:NSUTF8StringEncoding
                                                     error:NULL];
    
    return content;
}

- (NSArray *)css{
    return [[self readCSSFile] splitByNewLine];
}

#pragma mark - IBAction
- (void)login {
    JJTLoginViewController *loginVC = [JJTLoginViewController new];
    loginVC.delegate = self;
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginVC];
    
    [self presentViewController:nav animated:YES completion:NULL];
}

- (IBAction)searchButtonDidPress:(id)sender {
    JJTSearchViewController *searchVC = [JJTSearchViewController new];
    [self.navigationController pushViewController:searchVC animated:YES];
}

- (void)profile{
    JJTProfileViewController *profileVC = [JJTProfileViewController new];
    profileVC.delegate = self;
    [self.navigationController pushViewController:profileVC animated:YES];
}

#pragma mark - JJTLoginViewControllerDelegate
- (void)loginViewController:(JJTLoginViewController *)controller didLoginSuccessWithAccount:(JJTUser *)user{
    self.navigationItem.leftBarButtonItem = self.profileButton;
    [self.articleTableView reloadData];
}

#pragma mark - JJTProfileViewController.h
- (void)profileViewController:(JJTProfileViewController *)controller didLogoutWithAccount:(JJTUser *)account{
    self.navigationItem.leftBarButtonItem = self.loginButton;
    [self.articleTableView reloadData];
}

#pragma mark - JJTArticleTableViewDelegate
- (void)articleTableView:(JJTArticleListTableView *)tableView didSelectRowAtIndex:(NSInteger)index withArticle:(JJTArticle *)article{
    JJTArticleViewController *articleVC = [JJTArticleViewController new];
    articleVC.delegate = self;
    articleVC.article = article;
    
    JJTUser *author = [JJTUser MR_createEntity];
    author.userName = @"Guojun";
    author.userAvatarURL = @"http://www.moviecricket.com/wp-content/uploads/2014/09/James-Cameron-Looking-To-Shoot-Avatar-Sequels-In-120-FPS.jpg";
    
    articleVC.author = author;
    [self.navigationController pushViewController:articleVC animated:YES];
}

- (void)articleTableView:(JJTArticleListTableView *)tableView didTriggerLoadMoreControl:(UIRefreshControl *)control{
    NSLog(@"loading more...");
    [control endRefreshing];
}

#pragma mark - JJTArticleViewControllerDelegate
- (void)articleViewController:(JJTArticleViewController *)controller didViewArticle:(JJTArticle *)article{
    [self.articleTableView reloadData];
}

#pragma mark - Getters & Setters
- (UIBarButtonItem *)profileButton{
    if (!_profileButton) {
        _profileButton = [[UIBarButtonItem alloc] initWithTitle:@"我"
                                                          style:(UIBarButtonItemStylePlain)
                                                         target:self
                                                         action:@selector(profile)];
    }
    
    return _profileButton;
}

- (UIBarButtonItem *)loginButton{
    if (!_loginButton) {
        _loginButton = [[UIBarButtonItem alloc] initWithTitle:@"登录"
                                                        style:(UIBarButtonItemStylePlain)
                                                       target:self
                                                       action:@selector(login)];
    }
    
    return _loginButton;
}

@end
