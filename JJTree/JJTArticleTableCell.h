//
//  JJTArticleTableCell.h
//  JJTree
//
//  Created by guojun on 7/26/15.
//  Copyright (c) 2015 guojunxu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JJTArticle.h"
#import "JJTReadBehavior.h"

@interface JJTArticleTableCell : UITableViewCell

@property (nonatomic, strong) JJTArticle *article;
@property (nonatomic, strong) JJTReadBehavior *readBehavior;

@end
