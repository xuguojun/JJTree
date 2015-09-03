//
//  JJTArticleTableViewCell.h
//  JJTree
//
//  Created by guojun on 8/9/15.
//  Copyright (c) 2015 guojunxu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JJTArticle.h"
#import "JJTUser.h"

@class JJTBehaviorTableViewCell;

@interface JJTBehaviorTableViewCell : UITableViewCell

@property (nonatomic, strong) JJTArticle *article;
@property (nonatomic, strong) JJTUser *author;

@end
