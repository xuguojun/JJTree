//
//  JJTArticleViewController.m
//  JJTree
//
//  Created by guojun on 7/26/15.
//  Copyright (c) 2015 guojunxu. All rights reserved.
//

#import "JJTArticleViewController.h"
#import "JJTArticleTableView.h"

@interface JJTArticleViewController ()<UIActionSheetDelegate>

@property (nonatomic, weak) IBOutlet UIWebView *blockWebView;
@property (nonatomic, weak) IBOutlet UIBarButtonItem *usefulBarButtonItem;
@property (nonatomic, weak) IBOutlet UIBarButtonItem *uselessBarButtonItem;
@property (nonatomic, strong) UIBarButtonItem *moreButton;
@property (nonatomic, strong) UIActionSheet *moreActionSheet;

@property (nonatomic, weak) IBOutlet JJTArticleTableView *articleTableView;

@end

@implementation JJTArticleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.article.title;
    self.navigationItem.rightBarButtonItem = self.moreButton;
    
    self.articleTableView.article = self.article;
    self.articleTableView.author = self.author;
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
