//
//  NSString+JJTString.m
//  JJTree
//
//  Created by guojun on 7/27/15.
//  Copyright (c) 2015 guojunxu. All rights reserved.
//

#import "NSString+JJTString.h"

@implementation NSString (JJTString)

- (BOOL)matchPasswordFormat{
    return (self.length >= 6);
}

- (BOOL)matchEmailFormat{
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [predicate evaluateWithObject:self];
}

- (BOOL)matchMobieFormat{
    
    NSString *phoneNumberRegex = @"[0-9]{11}";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneNumberRegex];

    return [predicate evaluateWithObject:self];
}

- (BOOL)looksLikeEmailFormat{
    if ([self rangeOfString:@"@"].location != NSNotFound) {
        return YES;
    }
    
    return NO;
}

- (NSArray *)splitByNewLine{
    return [self componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
}

@end
