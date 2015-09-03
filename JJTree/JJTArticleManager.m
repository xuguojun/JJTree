//
//  JJTArticleManager.m
//  JJTree
//
//  Created by guojun on 9/3/15.
//  Copyright (c) 2015 guojunxu. All rights reserved.
//

#import "JJTArticleManager.h"

@implementation JJTArticleManager

+ (instancetype)sharedInstance {
    static JJTArticleManager *singleton = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        singleton = [[JJTArticleManager alloc] init];
    });
    
    return singleton;
}

- (void)requestArticlesWithCategory:(NSString *)category
                       withPageSize:(NSInteger)pageSize
                      withPageIndex:(NSInteger)pageIndex{

    NSString *url = [NSString stringWithFormat:@"/articles?pageSize=%ld&pageIndex=%ld&category=%@", (long)pageSize, (long)pageIndex, category];
    
    
    [self.httpManager requestUrlPath:url method:METHOD_GET param:nil fromCache:NO requestSuccess:^(id result, AFHTTPRequestOperation *operation) {
        
        
    } requestFailure:^(id result, AFHTTPRequestOperation *operation) {
        
    }];
}

@end
