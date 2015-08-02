//
//  JJTArticleViewController.m
//  JJTree
//
//  Created by guojun on 7/26/15.
//  Copyright (c) 2015 guojunxu. All rights reserved.
//

#import "JJTArticleViewController.h"
#import "JJTArticleTableView.h"
#import "JJTAuthorViewController.h"
#import "JJTReadBehavior.h"

@interface JJTArticleViewController ()<UIActionSheetDelegate, JJTArticleTableViewDelegate>

@property (nonatomic, weak) IBOutlet UIBarButtonItem *usefulBarButtonItem;
@property (nonatomic, weak) IBOutlet UIBarButtonItem *uselessBarButtonItem;
@property (nonatomic, strong) UIBarButtonItem *moreButton;
@property (nonatomic, strong) UIActionSheet *moreActionSheet;

@property (nonatomic, weak) IBOutlet JJTArticleTableView *articleTableView;

@property (nonatomic, strong) JJTReadBehavior *readBehavior;

@end

@implementation JJTArticleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.article.title;
    self.navigationItem.rightBarButtonItem = self.moreButton;
    
    self.articleTableView.article = self.article;
    self.articleTableView.author = self.author;
    
    [self insertReadBehaviorIfNeeded];
    [self didViewArticle];
}

#pragma mark - JJTArticleTableViewDelegate
- (void)articleTableViewDidSelectAuthorHeader:(JJTArticleTableView *)tableView{
    JJTAuthorViewController *authorVC = [JJTAuthorViewController new];
    authorVC.author = self.author;
    [self.navigationController pushViewController:authorVC animated:YES];
}

- (void)articleTableView:(JJTArticleTableView *)tableView didSelectRowAtIndex:(NSInteger)index{
    
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        // share
        NSLog(@"share");
    } else if (buttonIndex == 1){
        // collect
        NSLog(@"collect");
    } else if (buttonIndex == 2){
        // comment
        NSLog(@"comment");        
    }
}

#pragma mark - Private Methods
- (void)moreButtonDidPress:(id)sender{
    [self.moreActionSheet showFromBarButtonItem:self.moreButton animated:YES];
}

- (void)insertReadBehaviorIfNeeded{
    if (![self isExisted:self.article.articleID]) {
        self.readBehavior = [JJTReadBehavior MR_createEntity];
        
        self.readBehavior.userID = self.currentUser.userID;
        self.readBehavior.articleID = self.article.articleID;
        self.readBehavior.hasRead = @YES;
        
        [self.readBehavior saveAndWait];
    } else {
        self.readBehavior = [JJTReadBehavior MR_findFirstWithPredicate:[self predicate:self.article.articleID]];
    }
}

- (BOOL)isExisted:(NSNumber *)articleID{
    JJTReadBehavior *readBehavior = [JJTReadBehavior MR_findFirstWithPredicate:[self predicate:articleID]];
    BOOL existed = (readBehavior != nil);
    
    return existed;
}

- (NSPredicate *)predicate:(NSNumber *)articleID{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"userID = %@ AND articleID = %@", self.currentUser.userID, articleID];
    return predicate;
}

- (IBAction)markAsUsefull:(id)sender{
    self.readBehavior.markAsUseful = @YES;
    self.readBehavior.markAsUseless = @NO;
    
    [self.readBehavior saveAndWait];
    [self didViewArticle];
}

- (IBAction)markAsUseless:(id)sender{
    self.readBehavior.markAsUseless = @YES;
    self.readBehavior.markAsUseful = @NO;
   
    [self.readBehavior saveAndWait];
    [self didViewArticle];
}

- (void)didViewArticle{
    if ([self.delegate respondsToSelector:@selector(articleViewController:didViewArticle:)]) {
        [self.delegate articleViewController:self didViewArticle:self.article];
    }
}

#pragma mark - Getters & Setters
- (UIBarButtonItem *)moreButton{
    if (!_moreButton) {
        _moreButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction
                                                                    target:self
                                                                    action:@selector(moreButtonDidPress:)];
    }
    
    return _moreButton;
}

- (UIActionSheet *)moreActionSheet{
    if (!_moreActionSheet) {
        _moreActionSheet = [[UIActionSheet alloc] initWithTitle:@"更多操作"
                                                       delegate:self
                                              cancelButtonTitle:@"取消"
                                         destructiveButtonTitle:nil
                                              otherButtonTitles:@"分享", @"收藏", @"评论", nil];
    }
    
    return _moreActionSheet;
}

@end
