//
//  JJTBaseViewController.h
//  JJTree
//
//  Created by guojun on 8/1/15.
//  Copyright (c) 2015 guojunxu. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *ARRANGE_BY_USELESS_VALUE = @"ARRANGE_BY_USELESS_VALUE";
static NSString *ARRANGE_BY_UPDATE_DATE = @"ARRANGE_BY_UPDATE_DATE";
static NSString *BLOCK_STYLE_INDEX = @"BLOCK_STYLE_INDEX";

@interface JJTBaseViewController : UIViewController

@property (nonatomic, strong, readonly) NSUserDefaults *prefs;

@end
