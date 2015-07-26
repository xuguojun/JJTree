//
//  ViewController.m
//  JJTree
//
//  Created by guojun on 7/22/15.
//  Copyright (c) 2015 guojunxu. All rights reserved.
//

#import "JJTArticleListViewController.h"

@interface JJTArticleListViewController ()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *leftBarButtonItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *searchBarButtonItem;
@property (weak, nonatomic) IBOutlet UISegmentedControl *filterSegmentedControl;

@end

@implementation JJTArticleListViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"JJTree";
}

@end
