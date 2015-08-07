//
//  JJTFullReadViewController.h
//  JJTree
//
//  Created by guojun on 8/2/15.
//  Copyright (c) 2015 guojunxu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JJTArticle.h"

@interface JJTFullReadViewController : UIViewController

@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, strong) JJTArticle *article;

@end
