//
//  NSString+JJTString.m
//  JJTree
//
//  Created by guojun on 7/27/15.
//  Copyright (c) 2015 guojunxu. All rights reserved.
//

#import "NSString+JJTString.h"

static NSString *LETTERS = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";

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

- (BOOL)isEmail{
    if ([self rangeOfString:@"@"].location != NSNotFound) {
        return YES;
    } else {
        return NO;
    }
}
- (BOOL)isPhoneNumber{
    if (self.length == 11 && [self integerValue] > 0) {
        return YES;
    } else {
        return NO;
    }
}

- (NSArray *)splitByNewLine{
    return [self componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
}

+ (NSString *)randomStringWithLength:(int)length{
    
    NSMutableString *s = [NSMutableString stringWithCapacity:length];
    
    for (NSUInteger i = 0U; i < length; i++) {
        u_int32_t r = arc4random() % [LETTERS length];
        unichar c = [LETTERS characterAtIndex:r];
        [s appendFormat:@"%C", c];
    }
    
    return s;
}

- (NSDate *)toDate{

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    // this is imporant - we set our input date format to match our input string
    // if format doesn't match you'll get nil from your string, so be careful
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.SSS"];
    NSDate *dateFromString = [dateFormatter dateFromString:self];
    
    return dateFromString;
}
@end
