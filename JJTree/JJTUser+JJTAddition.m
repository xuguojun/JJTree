//
//  JJTUser+JJTAddition.m
//  JJTree
//
//  Created by guojun on 8/2/15.
//  Copyright (c) 2015 guojunxu. All rights reserved.
//

#import "JJTUser+JJTAddition.h"
#import <MagicalRecord/MagicalRecord.h>

@implementation JJTUser (JJTAddition)

+ (JJTUser *)currentUser{
    
    static NSString *query = @"hasLogined == 1";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:query];
    
    JJTUser *currentUser = [JJTUser MR_findFirstWithPredicate:predicate];
    
    return currentUser;
}

@end
