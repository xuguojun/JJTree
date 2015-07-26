//
//  JJTArticleTableView.h
//  JJTree
//
//  Created by guojun on 7/26/15.
//  Copyright (c) 2015 guojunxu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JJTArticle.h"

@class JJTArticleListTableView;
@protocol JJTArticleListTableViewDelegate <NSObject>

@required
- (void)articleTableView:(JJTArticleListTableView *)tableView
     didSelectRowAtIndex:(NSInteger)index
             withArticle:(JJTArticle *)article;

@end
@interface JJTArticleListTableView : UIView

@property (nonatomic, strong) NSArray *articles;
@property (nonatomic, weak) IBOutlet id<JJTArticleListTableViewDelegate> delegate;

@end
