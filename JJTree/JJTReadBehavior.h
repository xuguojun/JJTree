//
//  JJTReadBehavior.h
//  JJTree
//
//  Created by guojun on 8/2/15.
//  Copyright (c) 2015 guojunxu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface JJTReadBehavior : NSManagedObject

@property (nonatomic, retain) NSNumber * userID;
@property (nonatomic, retain) NSNumber * articleID;
@property (nonatomic, retain) NSNumber * markAsUseful;
@property (nonatomic, retain) NSNumber * markAsUseless;
@property (nonatomic, retain) NSNumber * hasRead;

@end
