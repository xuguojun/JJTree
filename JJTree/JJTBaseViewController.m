//
//  JJTBaseViewController.m
//  JJTree
//
//  Created by guojun on 8/1/15.
//  Copyright (c) 2015 guojunxu. All rights reserved.
//

#import "JJTBaseViewController.h"

@interface JJTBaseViewController ()

@property (nonatomic, strong) NSUserDefaults *prefs;

@end

@implementation JJTBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

#pragma mark - Getters & Setters
- (NSUserDefaults *)prefs{
    if (!_prefs) {
        _prefs = [NSUserDefaults standardUserDefaults];
    }
    
    return _prefs;
}

@end
