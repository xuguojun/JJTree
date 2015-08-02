//
//  JJTLoginViewController.h
//  JJTree
//
//  Created by guojun on 7/27/15.
//  Copyright (c) 2015 guojunxu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JJTUser.h"

@class JJTLoginViewController;
@protocol JJTLoginViewControllerDelegate <NSObject>

@required
- (void)loginViewController:(JJTLoginViewController *)controller didLoginSuccessWithAccount:(JJTUser *)user;

@end
@interface JJTLoginViewController : UIViewController

@property (nonatomic, weak) IBOutlet id<JJTLoginViewControllerDelegate> delegate;

@end
