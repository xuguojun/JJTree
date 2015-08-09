//
//  JJTBehaviorViewController.m
//  JJTree
//
//  Created by guojun on 8/9/15.
//  Copyright (c) 2015 guojunxu. All rights reserved.
//

#import "JJTBehaviorViewController.h"
#import "JJTAuthorViewController.h"
#import "JJTArticleViewController.h"
#import "JJTFansTableView.h"
#import "JJTBehaviorsTableView.h"
#import "JJTAuthor.h"
#import <MagicalRecord.h>

@interface JJTBehaviorViewController ()<JJTFansTableViewDelegate, JJTBehaviorsTableViewDelegate>

@property (nonatomic, weak) IBOutlet JJTFansTableView *fansTableView;
@property (nonatomic, weak) IBOutlet JJTBehaviorsTableView *behaviorsTableView;

@end

@implementation JJTBehaviorViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    NSMutableArray *fans = [NSMutableArray new];
    NSMutableArray *articles = [NSMutableArray new];
    
    for (int i = 0; i < 10; i++) {
        JJTAuthor *author = [JJTAuthor MR_createEntity];
        author.avatarURL = @"http://img1.imgtn.bdimg.com/it/u=209848973,3062288546&fm=23&gp=0.jpg";
        author.roleName = @"GJ";
        author.articlePublishedCount = @(i + 1);
        
        [fans addObject:author];
        
        //
        JJTArticle *article = [JJTArticle MR_createEntity];
        article.title = @"Article";
        article.articleID = @(100 + i);
        article.createdAt = [NSDate new];
        article.usefulValue = @(i +19);
        article.uselessValue = @(i +10);
        article.viewCount = @(10 + i);
        
        [articles addObject:article];
    }
    
    self.fansTableView.fans = fans;
    
    self.behaviorsTableView.articles = articles;
    self.behaviorsTableView.authors = fans;
    
    if (self.behaviorType == JJTBehaviorArticle) {
        self.fansTableView.hidden = YES;
    } else if (self.behaviorType == JJTBehaviorAuthor) {
        self.behaviorsTableView.hidden = YES;
    }
}

#pragma mark - JJTFansTableViewDelegate
- (void)fansTableView:(JJTFansTableView *)tableView didSelectRowAtIndex:(NSInteger)index{
    JJTAuthorViewController *author = [JJTAuthorViewController new];
    author.author = self.fansTableView.fans[index];
    
    [self.navigationController pushViewController:author animated:YES];
}

#pragma mark - JJTBehaviorsTableViewDelegate
- (void)behaviorTableView:(JJTBehaviorsTableView *)tableView didSelectRowAtIndex:(NSInteger)index{
    JJTArticleViewController *article = [JJTArticleViewController new];
    article.article = self.behaviorsTableView.articles[index];
    
    [self.navigationController pushViewController:article animated:YES];
}

@end
