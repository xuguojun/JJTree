//
//  JJTHttpManager.h
//  JJTree
//
//  Created by guojun on 8/15/15.
//  Copyright (c) 2015 guojunxu. All rights reserved.
//

#import "AFHTTPRequestOperationManager.h"
#import "JJTBaseParser.h"

typedef void (^successBlock)(id result, AFHTTPRequestOperation *operation);
typedef void (^failureBlock)(id result, AFHTTPRequestOperation *operation);

static NSString *METHOD_GET = @"GET";
static NSString *METHOD_POST = @"POST";
static NSString *METHOD_DELETE = @"DELETE";
static NSString *METHOD_PUT = @"PUT";

@interface JJTHttpManager : AFHTTPRequestOperationManager

+ (instancetype) sharedInstance;

- (void)requestUrlPath:(NSString *)urlPath
                method:(NSString *)method
                 param:(id)param
             fromCache:(BOOL)fromCache
        requestSuccess:(successBlock)responseSuccessBlock
        requestFailure:(failureBlock)responseFailureBlock;

@end
