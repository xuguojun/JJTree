//
//  JJTHttpManager.m
//  JJTree
//
//  Created by guojun on 8/15/15.
//  Copyright (c) 2015 guojunxu. All rights reserved.
//

#import "JJTHttpManager.h"

typedef void (^successBlock)(id result, AFHTTPRequestOperation *operation);
typedef void (^failureBlock)(id result, AFHTTPRequestOperation *operation);

#ifdef DEBUG
    #define HOST @"http://localhost:8080/JJTree/"
#else
    #define HOST @"http://localhost:8080/JJTree/"
#endif

static NSString *PREFIX_HTTP = @"http";

@implementation JJTHttpManager

#pragma mark - sharedInstance
+ (instancetype) sharedInstance {
    static JJTHttpManager *singleton = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        singleton = [[JJTHttpManager alloc] init];
        
        NSURLCache *cache = [[NSURLCache alloc] initWithMemoryCapacity:200 * 1024 * 1024
                                                          diskCapacity:320 * 1024 * 1024
                                                              diskPath:@"appCache"];
        [NSURLCache setSharedURLCache:cache];
    });
    
    return singleton;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        
        [self configure];
    }
    
    return self;
}

- (void)configure{
    // request
    self.requestSerializer = [AFJSONRequestSerializer serializer];
    self.requestSerializer.HTTPMethodsEncodingParametersInURI = [NSSet setWithObjects:@"GET", @"HEAD", nil];
    [self.requestSerializer setTimeoutInterval:30];
    
    // response
    AFJSONResponseSerializer *jsonSerializer = [AFJSONResponseSerializer serializer];
    jsonSerializer.removesKeysWithNullValues = YES;
    self.responseSerializer = jsonSerializer;
}

#pragma mark - Interface
- (void)requestUrlPath:(NSString *)urlPath
                method:(NSString *)method
                 param:(id)param
             fromCache:(BOOL)fromCache
        requestSuccess:(successBlock)responseSuccessBlock
        requestFailure:(failureBlock)responseFailureBlock {
    
    if (![urlPath hasPrefix:PREFIX_HTTP]) {
        urlPath = [NSString stringWithFormat:@"%@%@", PREFIX_HTTP, urlPath];
    }
    
    [self.requestSerializer setCachePolicy:fromCache ? NSURLRequestReturnCacheDataElseLoad : NSURLRequestReloadIgnoringCacheData];
    
    if ([method isEqualToString:METHOD_GET]) {
        [self GET:urlPath
       parameters:nil
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              responseSuccessBlock(responseObject, operation);
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              responseFailureBlock (error, operation);
          }];
    } else if ([method isEqualToString:METHOD_POST]) {
        [self configureHeaders];
        
        [self POST:urlPath
        parameters:param
           success:^(AFHTTPRequestOperation *operation, id responseObject) {
               responseSuccessBlock(responseObject, operation);
           }
           failure:^(AFHTTPRequestOperation *operation, NSError *error) {
               responseFailureBlock(error, operation);
           }];
    } else if ([method isEqualToString:METHOD_DELETE]){
        
        [self configureHeaders];
        
        [self DELETE:urlPath parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
            responseSuccessBlock(responseObject, operation);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            responseFailureBlock(error, operation);
        }];
    } else if ([method isEqualToString:METHOD_PUT]){
        
        [self configureHeaders];
        
        [self PUT:urlPath parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
            responseSuccessBlock(responseObject, operation);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            responseFailureBlock(error, operation);
        }];
    }
}

#pragma mark - Private Methods
- (void)configureHeaders{
    [self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
}

@end
