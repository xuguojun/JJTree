//
//  JJTArticleManager.h
//  JJTree
//
//  Created by guojun on 9/3/15.
//  Copyright (c) 2015 guojunxu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JJTBaseManager.h"

#define TOP_ARTICLES @"top"
#define RECENT_ARTICLES @"recent"

@interface JJTArticleManager : JJTBaseManager

+ (instancetype)sharedInstance;

- (void)requestArticlesWithCategory:(NSString *)category
                       withPageSize:(NSInteger)pageSize
                      withPageIndex:(NSInteger)pageIndex;

@end
