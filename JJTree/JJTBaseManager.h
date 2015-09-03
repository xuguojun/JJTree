//
//  JJTBaseManager.h
//  JJTree
//
//  Created by guojun on 9/3/15.
//  Copyright (c) 2015 guojunxu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JJTHttpManager.h"

@class JJTBaseManager;
@protocol JJTBaseManagerDelegate <NSObject>

@required
- (void)manager:(JJTBaseManager *)manager didFetchDataSuccess:(NSArray *)list;
- (void)manager:(JJTBaseManager *)manager didFetchDataFailure:(NSString *)error;

@end

@interface JJTBaseManager : NSObject

@property (nonatomic, strong, readonly) JJTHttpManager *httpManager;
@property (nonatomic, weak) IBOutlet id<JJTBaseManagerDelegate> delegate;

+ (instancetype)sharedInstance;

@end
