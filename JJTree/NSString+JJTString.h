//
//  NSString+JJTString.h
//  JJTree
//
//  Created by guojun on 7/27/15.
//  Copyright (c) 2015 guojunxu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (JJTString)

- (BOOL)matchPasswordFormat;
- (BOOL)matchEmailFormat;
- (BOOL)matchMobieFormat;

- (BOOL)isPhoneNumber;
- (BOOL)isEmail;

- (BOOL)looksLikeEmailFormat;
- (NSArray *)splitByNewLine;

+ (NSString *)randomStringWithLength:(int)length;

- (NSDate *)toDate;

@end
