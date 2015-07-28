//
//  JJTArticleTableView.h
//  JJTree
//
//  Created by guojun on 7/26/15.
//  Copyright (c) 2015 guojunxu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JJTArticle.h"
#import "JJTAuthor.h"

@class JJTArticleTableView;
@protocol JJTArticleTableViewDelegate <NSObject>

@required
- (void)articleTableView:(JJTArticleTableView *)tableView didSelectRowAtIndex:(NSInteger)index;
- (void)articleTableViewDidSelectAuthorHeader:(JJTArticleTableView *)tableView;

@end
@interface JJTArticleTableView : UIView

@property (nonatomic, strong) JJTArticle *article;
@property (nonatomic, strong) JJTAuthor *author;

@property (nonatomic, weak) IBOutlet id<JJTArticleTableViewDelegate> delegate;

@end
