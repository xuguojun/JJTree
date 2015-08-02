//
//  NSManagedObject+JJTManagedObject.h
//  JJTree
//
//  Created by guojun on 8/2/15.
//  Copyright (c) 2015 guojunxu. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSManagedObject (JJTManagedObject)

- (void)saveAndWait;

@end
