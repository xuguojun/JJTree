//
//  JJTSingleViewController.h
//  JJTree
//
//  Created by guojun on 8/2/15.
//  Copyright (c) 2015 guojunxu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JJTParagraph.h"

@interface JJTSingleViewController : UIViewController

@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) JJTParagraph *paragraph;

@end
