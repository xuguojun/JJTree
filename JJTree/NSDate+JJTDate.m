//
//  NSDate+JJTDate.m
//  JJTree
//
//  Created by guojun on 7/26/15.
//  Copyright (c) 2015 guojunxu. All rights reserved.
//

#import "NSDate+JJTDate.h"

@implementation NSDate (JJTDate)

- (NSString *)toString{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *dateString = [formatter stringFromDate:self];
    
    return dateString;
}

@end
