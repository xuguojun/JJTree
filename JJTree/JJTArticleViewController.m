//
//  JJTArticleViewController.m
//  JJTree
//
//  Created by guojun on 7/26/15.
//  Copyright (c) 2015 guojunxu. All rights reserved.
//

#import "JJTArticleViewController.h"

@interface JJTArticleViewController ()

@property (nonatomic, weak) IBOutlet UIWebView *blockWebView;
@property (nonatomic, weak) IBOutlet UIBarButtonItem *usefulBarButtonItem;
@property (nonatomic, weak) IBOutlet UIBarButtonItem *uselessBarButtonItem;
@property (nonatomic, strong) IBOutlet UIBarButtonItem *moreButton;

@end

@implementation JJTArticleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.article.title;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationItem.rightBarButtonItem = self.moreButton;
    [self loadWebPage];
}

- (NSString *)readFile{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"fakeData"
                                                     ofType:@"txt"];
    NSString *content = [NSString stringWithContentsOfFile:path
                                                  encoding:NSUTF8StringEncoding
                                                     error:NULL];
    
    return content;
}

- (void)loadWebPage{
    NSURL *url = [NSURL URLWithString:@"http://localhost:8080/JJTree/JJTreeServlet"];
    [self.blockWebView loadRequest:[NSURLRequest requestWithURL:url]];
}

#pragma mark - UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView{
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
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

- (void)moreButtonDidPress:(id)sender{
    
}

@end
