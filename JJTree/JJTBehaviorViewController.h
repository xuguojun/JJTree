//
//  JJTBehaviorViewController.h
//  JJTree
//
//  Created by guojun on 8/9/15.
//  Copyright (c) 2015 guojunxu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    JJTBehaviorArticle,
    JJTBehaviorAuthor
} JJTBehaviorType;

@interface JJTBehaviorViewController : UIViewController

@property (nonatomic, assign) JJTBehaviorType behaviorType;

@end
