//
//  JJTBaseParser.h
//  JJTree
//
//  Created by guojun on 8/18/15.
//  Copyright (c) 2015 guojunxu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JJTArticle.h"

@interface JJTBaseParser : NSObject

+ (instancetype)sharedInstance;

+ (NSArray *)parseArticles:(NSDictionary *)dict;
+ (JJTArticle *)parseArticle:(NSDictionary *)dict;

@end
