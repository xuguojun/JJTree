//
//  NSManagedObject+JJTManagedObject.m
//  JJTree
//
//  Created by guojun on 8/2/15.
//  Copyright (c) 2015 guojunxu. All rights reserved.
//

#import "NSManagedObject+JJTManagedObject.h"
#import <MagicalRecord.h>

@implementation NSManagedObject (JJTManagedObject)

- (void)saveAndWait{
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    });
}

@end
