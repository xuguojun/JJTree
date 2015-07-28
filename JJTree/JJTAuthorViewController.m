//
//  JJTAuthorViewController.m
//  JJTree
//
//  Created by guojun on 7/28/15.
//  Copyright (c) 2015 guojunxu. All rights reserved.
//

#import "JJTAuthorViewController.h"
#import "JJTAuthorTableView.h"

@interface JJTAuthorViewController ()

@property (nonatomic, weak) IBOutlet JJTAuthorTableView *authorTableView;
@property (nonatomic, weak) IBOutlet UIBarButtonItem *rewardAuthorButton;

@end

@implementation JJTAuthorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.author.roleName;
    self.authorTableView.author = self.author;
}

- (IBAction)rewardButtonDidPress:(id)sender {
}

@end
