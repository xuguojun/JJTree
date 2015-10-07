//
//  JJTArticleViewController.h
//  JJTree
//
//  Created by guojun on 7/26/15.
//  Copyright (c) 2015 guojunxu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JJTArticle.h"
#import "JJTUser.h"
#import "JJTBaseViewController.h"

@class JJTArticleViewController;
@protocol JJTArticleViewControllerDelegate <NSObject>

@required
- (void)articleViewController:(JJTArticleViewController *)controller didViewArticle:(JJTArticle *)article;

@end
@interface JJTArticleViewController : JJTBaseViewController

@property (nonatomic, strong) JJTArticle *article;
@property (nonatomic, strong) JJTUser *author;

@property (nonatomic, weak) IBOutlet id<JJTArticleViewControllerDelegate> delegate;

@end
