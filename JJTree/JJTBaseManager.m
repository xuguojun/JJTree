//
//  JJTBaseManager.m
//  JJTree
//
//  Created by guojun on 9/3/15.
//  Copyright (c) 2015 guojunxu. All rights reserved.
//

#import "JJTBaseManager.h"

@interface JJTBaseManager()

@property (nonatomic, strong) JJTHttpManager *httpManager;

@end
@implementation JJTBaseManager

+ (instancetype)sharedInstance {
    static JJTBaseManager *singleton = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        singleton = [[JJTBaseManager alloc] init];
    });
    
    return singleton;
}

- (JJTHttpManager *)httpManager{
    if (!_httpManager) {
        _httpManager = [JJTHttpManager sharedInstance];
    }
    
    return _httpManager;
}

@end
