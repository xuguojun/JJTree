//
//  JJTBaseParser.m
//  JJTree
//
//  Created by guojun on 8/18/15.
//  Copyright (c) 2015 guojunxu. All rights reserved.
//

#import "JJTBaseParser.h"
#import "JJTUser.h"
#import "JJTParagraph.h"
#import <MagicalRecord.h>
#import "NSString+JJTString.h"

@implementation JJTBaseParser

+ (instancetype)sharedInstance {
    static JJTBaseParser *singleton = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        singleton = [[JJTBaseParser alloc] init];
    });
    
    return singleton;
}

+ (NSArray *)parseArticles:(NSDictionary *)dict{
    
    NSArray *articles = [dict objectForKey:@"articles"];
    
    NSMutableArray *as = [NSMutableArray new];
    for (NSDictionary *aD in articles) {
        
       JJTArticle *article = [self parseArticle:aD];
        [as addObject:article];
    }
    
    return as;
}

+ (JJTArticle *)parseArticle:(NSDictionary *)dict{
    
    NSNumber *articleID = [dict objectForKey:@"articleID"];
    NSString *title = [dict objectForKey:@"title"];
    
    NSNumber *usefulValue = [dict objectForKey:@"usefulValue"];
    NSNumber *uselessValue = [dict objectForKey:@"uselessValue"];
    NSNumber *viewCount = [dict objectForKey:@"viewCount"];
    
    NSString *createdAt = [dict objectForKey:@"createdAt"];
    NSString *updatedAt = [dict objectForKey:@"updatedAt"];
    
    NSDictionary *authorD = [dict objectForKey:@"author"];
    JJTUser *author = [self parseAccount:authorD];
    
    NSArray *paragraphs = [dict objectForKey:@"paragraphs"];
    
    NSMutableArray *ps = [NSMutableArray new];
    for (NSDictionary *pD in paragraphs) {
        JJTParagraph *p = [self  parseParagraph:pD];
        [ps addObject:p];
    }
    
    JJTArticle *article = [JJTArticle MR_createEntity];
    
    article.articleID = articleID;
    article.title = title;
    
    article.createdAt = [createdAt toDate];
    article.updatedAt = [updatedAt toDate];
    
    article.usefulValue = usefulValue;
    article.uselessValue = uselessValue;
    article.viewCount = viewCount;
    article.author = author;
    article.paragraphs = [[NSOrderedSet alloc] initWithArray:ps];
    
    return article;
}

+ (JJTUser *)parseAccount:(NSDictionary *)dict{
    
    NSNumber *accountID = [dict objectForKey:@"accountID"];
    NSString *password = [dict objectForKey:@"password"];
    NSString *avatarURL = [dict objectForKey:@"avatarURL"];
    NSString *mobile = [dict objectForKey:@"mobile"];
    NSString *name = [dict objectForKey:@"name"];
    NSString *email = [dict objectForKey:@"email"];
    
    JJTUser *account = [JJTUser MR_createEntity];
    account.userID = accountID;
    account.userPassword = password;
    account.userMobile = mobile;
    account.userEmail = email;
    account.userName = name;
    account.userAvatarURL = avatarURL;
    
    return account;
}

+ (JJTParagraph *)parseParagraph:(NSDictionary *)dict{
    NSNumber *pID = [dict objectForKey:@"paragraphID"];
    NSNumber *position = [dict objectForKey:@"position"];
    NSString *type = [dict objectForKey:@"type"];
    NSString *content = [dict objectForKey:@"content"];
    
    JJTParagraph *p = [JJTParagraph MR_createEntity];
    p.paragraphID = pID;
    p.position = position;
    p.type = type;
    p.content = content;
    
    return p;
}

@end
