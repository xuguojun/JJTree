//
//  ViewController.m
//  JJTree
//
//  Created by guojun on 7/22/15.
//  Copyright (c) 2015 guojunxu. All rights reserved.
//

#import "ViewController.h"
#import <MMMarkdown/MMMarkdown.h>

@interface ViewController ()

@property (nonatomic, weak) IBOutlet UITextView *blockTextView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSString *markdown = [self readFile];
    NSString *htmlString = [MMMarkdown HTMLStringWithMarkdown:markdown extensions:MMMarkdownExtensionsGitHubFlavored error:NULL];
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding]
                                                                            options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType }
                                                                 documentAttributes:nil
                                                                              error:nil];
    self.blockTextView.attributedText = attributedString;
}

- (NSString *)readFile{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"fakeData"
                                                     ofType:@"txt"];
    NSString *content = [NSString stringWithContentsOfFile:path
                                                  encoding:NSUTF8StringEncoding
                                                     error:NULL];
    
    return content;
}

@end
