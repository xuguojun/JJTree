//
//  JJTHttpManager.h
//  JJTree
//
//  Created by guojun on 8/15/15.
//  Copyright (c) 2015 guojunxu. All rights reserved.
//

#import "AFHTTPRequestOperationManager.h"

static NSString *METHOD_GET = @"GET";
static NSString *METHOD_POST = @"POST";
static NSString *METHOD_DELETE = @"DELETE";
static NSString *METHOD_PUT = @"PUT";

@interface JJTHttpManager : AFHTTPRequestOperationManager

+ (instancetype) sharedInstance;

@end
