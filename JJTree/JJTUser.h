//
//  JJTUser.h
//  JJTree
//
//  Created by guojun on 7/26/15.
//  Copyright (c) 2015 guojunxu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class NSManagedObject;

@interface JJTUser : NSManagedObject

@property (nonatomic, retain) NSNumber * userID;
@property (nonatomic, retain) NSString * userName;
@property (nonatomic, retain) NSString * userEmail;
@property (nonatomic, retain) NSString * userMobile;
@property (nonatomic, retain) NSNumber * hasLogined;
@property (nonatomic, retain) NSManagedObject *roleAuthor;
@property (nonatomic, retain) NSManagedObject *roleReader;
@property (nonatomic, retain) NSManagedObject *roleEditor;

@end
