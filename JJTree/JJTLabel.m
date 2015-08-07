//
//  JJTLabel.m
//  JJTree
//
//  Created by guojun on 8/8/15.
//  Copyright (c) 2015 guojunxu. All rights reserved.
//

#import "JJTLabel.h"

@implementation JJTLabel

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.edgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    
    return self;
}

- (void)drawTextInRect:(CGRect)rect {
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, self.edgeInsets)];
}

@end
