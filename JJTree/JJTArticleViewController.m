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

@end

@implementation JJTArticleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"JJTree";
    self.automaticallyAdjustsScrollViewInsets = NO;
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

@end
