//
//  JJTEditor.h
//  JJTree
//
//  Created by guojun on 7/26/15.
//  Copyright (c) 2015 guojunxu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "JJTRole.h"

@class JJTUser;

@interface JJTEditor : JJTRole

@property (nonatomic, retain) NSNumber * editArticlesCount;
@property (nonatomic, retain) NSNumber * rewardGotAmount;
@property (nonatomic, retain) NSNumber * articlesAdoptedCount;
@property (nonatomic, retain) JJTUser *whichUser;

@end
