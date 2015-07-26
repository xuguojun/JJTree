//
//  JJTRole.h
//  JJTree
//
//  Created by guojun on 7/26/15.
//  Copyright (c) 2015 guojunxu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface JJTRole : NSManagedObject

@property (nonatomic, retain) NSString * roleTitle;
@property (nonatomic, retain) NSString * roleName;
@property (nonatomic, retain) NSString * avatarURL;
@property (nonatomic, retain) NSNumber * roleID;

@end
