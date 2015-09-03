//
//  JJTBaseParser.m
//  JJTree
//
//  Created by guojun on 8/18/15.
//  Copyright (c) 2015 guojunxu. All rights reserved.
//

#import "JJTBaseParser.h"
#import "JJTUser.h"
#import <MagicalRecord.h>
#import "NSString+JJTString.h"

@implementation JJTBaseParser

+ (JJTArticle *)parseArticle:(NSDictionary *)dict{
    
    NSNumber *articleID = [dict objectForKey:@"articleID"];
    
//    NSString *preface = [dict objectForKey:@"preface"];
    NSString *title = [dict objectForKey:@"title"];
//    NSString *refs = [dict objectForKey:@"refs"];
//    NSString *seeAlso = [dict objectForKey:@"seeAlso"];
    
    NSNumber *usefulValue = [dict objectForKey:@"usefulValue"];
    NSNumber *uselessValue = [dict objectForKey:@"uselessValue"];
    NSNumber *viewCount = [dict objectForKey:@"viewCount"];
    
    NSString *createdAt = [dict objectForKey:@"createdAt"];
    NSString *updatedAt = [dict objectForKey:@"updatedAt"];
    
    JJTArticle *article = [JJTArticle MR_createEntity];
    
    article.articleID = articleID;
    article.title = title;
    
    article.createdAt = [createdAt toDate];
    article.updatedAt = [updatedAt toDate];
    
    article.usefulValue = usefulValue;
    article.uselessValue = uselessValue;
    article.viewCount = viewCount;
    
    return article;
}

+ (JJTUser *)parserAccount:(NSDictionary *)dict{
    
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

@end
