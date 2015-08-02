//
//  JJTProfileViewController.h
//  JJTree
//
//  Created by guojun on 7/28/15.
//  Copyright (c) 2015 guojunxu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JJTBaseViewController.h"

@class JJTProfileViewController;
@protocol JJTProfileViewControllerDelegate <NSObject>

@required
- (void)profileViewController:(JJTProfileViewController *)controller didLogoutWithAccount:(JJTUser *)account;

@end
@interface JJTProfileViewController : JJTBaseViewController

@property (nonatomic, weak) IBOutlet id<JJTProfileViewControllerDelegate> delegate;

@end
