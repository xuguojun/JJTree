//
//  JJTBaseViewController.h
//  JJTree
//
//  Created by guojun on 8/1/15.
//  Copyright (c) 2015 guojunxu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MagicalRecord.h>
#import "NSManagedObject+JJTManagedObject.h"
#import "JJTUser.h"
#import "JJTUser+JJTAddition.h"
#import "JJTHttpManager.h"

static NSString *ARRANGE_BY_USELESS_VALUE = @"ARRANGE_BY_USELESS_VALUE";
static NSString *ARRANGE_BY_UPDATE_DATE = @"ARRANGE_BY_UPDATE_DATE";
static NSString *BLOCK_STYLE_INDEX = @"BLOCK_STYLE_INDEX";

@interface JJTBaseViewController : UIViewController

@property (nonatomic, strong, readonly) NSUserDefaults *prefs;
@property (nonatomic, strong, readonly) JJTUser *currentUser;
@property (nonatomic, strong, readonly) JJTHttpManager *httpManager;

@end
