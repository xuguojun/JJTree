//
//  JJTBlockStyleViewController.h
//  JJTree
//
//  Created by guojun on 7/28/15.
//  Copyright (c) 2015 guojunxu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JJTBaseViewController.h"

@class JJTBlockStyleViewController;
@protocol JJTBlockStyleViewControllerDelegate <NSObject>

@required
- (void)blockStyleViewController:(JJTBlockStyleViewController *)controller didSelectRowAtIndex:(NSInteger)index;

@end
@interface JJTBlockStyleViewController : JJTBaseViewController

@property (nonatomic, weak) IBOutlet id<JJTBlockStyleViewControllerDelegate> delegate;

@end
