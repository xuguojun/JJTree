//
//  JJTCreateAccountViewController.h
//  JJTree
//
//  Created by guojun on 7/27/15.
//  Copyright (c) 2015 guojunxu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JJTBaseViewController.h"

@class JJTCreateAccountViewController;

@protocol JJTCreateAccountViewControllerDelegate <NSObject>

@required
- (void)createAccountViewControllerDidClose:(JJTCreateAccountViewController *)controller;

@end
@interface JJTCreateAccountViewController : JJTBaseViewController

@property (nonatomic, weak) IBOutlet id<JJTCreateAccountViewControllerDelegate> delegate;

@end
