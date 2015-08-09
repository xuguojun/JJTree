//
//  JJTBehaviorViewController.m
//  JJTree
//
//  Created by guojun on 8/9/15.
//  Copyright (c) 2015 guojunxu. All rights reserved.
//

#import "JJTBehaviorViewController.h"
#import "JJTAuthorViewController.h"
#import "JJTFansTableView.h"
#import "JJTAuthor.h"
#import <MagicalRecord.h>

@interface JJTBehaviorViewController ()<JJTFansTableViewDelegate>

@property (nonatomic, weak) IBOutlet JJTFansTableView *fansTableView;

@end

@implementation JJTBehaviorViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    NSMutableArray *fans = [NSMutableArray new];
    for (int i = 0; i < 10; i++) {
        JJTAuthor *author = [JJTAuthor MR_createEntity];
        author.avatarURL = @"http://img1.imgtn.bdimg.com/it/u=209848973,3062288546&fm=23&gp=0.jpg";
        author.roleName = @"GJ";
        author.articlePublishedCount = @(i + 1);
        
        [fans addObject:author];
    }
    
    self.fansTableView.fans = fans;
}

#pragma mark - JJTFansTableViewDelegate
- (void)fansTableView:(JJTFansTableView *)tableView didSelectRowAtIndex:(NSInteger)index{
    JJTAuthorViewController *author = [JJTAuthorViewController new];
    author.author = self.fansTableView.fans[index];
    
    [self.navigationController pushViewController:author animated:YES];
}

@end
