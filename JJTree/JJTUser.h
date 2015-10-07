//
//  JJTUser.h
//  JJTree
//
//  Created by guojun on 9/3/15.
//  Copyright (c) 2015 guojunxu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class JJTArticle;

@interface JJTUser : NSManagedObject

@property (nonatomic, retain) NSNumber * hasLogined;
@property (nonatomic, retain) NSNumber * userArticleCountAdopter;
@property (nonatomic, retain) NSNumber * userArticleCountEdited;
@property (nonatomic, retain) NSNumber * userArticleCountMarkAsUseful;
@property (nonatomic, retain) NSNumber * userArticleCountMarkAsUseless;
@property (nonatomic, retain) NSNumber * userArticleCountPublished;
@property (nonatomic, retain) NSNumber * userArticleCountViewed;
@property (nonatomic, retain) NSNumber * userArticlesCountCollected;
@property (nonatomic, retain) NSString * userAvatarURL;
@property (nonatomic, retain) NSString * userEmail;
@property (nonatomic, retain) NSNumber * userID;
@property (nonatomic, retain) NSString * userMobile;
@property (nonatomic, retain) NSString * userName;
@property (nonatomic, retain) NSString * userPassword;
@property (nonatomic, retain) NSNumber * userRewardAmount;
@property (nonatomic, retain) NSNumber * userRewardedAmount;
@property (nonatomic, retain) JJTArticle *whichArticle;

@end
