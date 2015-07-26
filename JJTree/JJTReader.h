//
//  JJTReader.h
//  JJTree
//
//  Created by guojun on 7/26/15.
//  Copyright (c) 2015 guojunxu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "JJTRole.h"

@class JJTUser;

@interface JJTReader : JJTRole

@property (nonatomic, retain) NSNumber * viewArticlesCount;
@property (nonatomic, retain) NSNumber * rewardAmount;
@property (nonatomic, retain) NSNumber * markAsUsefulCount;
@property (nonatomic, retain) NSNumber * markAsUselessCount;
@property (nonatomic, retain) NSNumber * collectArticlesCount;
@property (nonatomic, retain) JJTUser *whichUser;

@end
