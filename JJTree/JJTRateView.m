//
//  JJTRateView.m
//  JJTree
//
//  Created by guojun on 7/26/15.
//  Copyright (c) 2015 guojunxu. All rights reserved.
//

#import "JJTRateView.h"

@interface JJTRateView()

@property (nonatomic, weak) IBOutlet UIView *usefulValueView;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *usefulTrailingSpaceConstraint;

@end

@implementation JJTRateView

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        
        [self loadView];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self loadView];
    }
    
    return self;
}

#pragma mark - Private Methods
- (void)loadView{
    UIView *view = [[[NSBundle bundleForClass:[self class]] loadNibNamed:NSStringFromClass([self class])
                                                                   owner:self
                                                                 options:nil] firstObject];
    
    view.frame = self.bounds;
    
    [self addSubview:view];
}

#pragma mark - Getters & Setters
- (void)setRate:(float)rate{
    if (_rate != rate) {
        _rate = rate;
        
        if (rate >=0.0f && rate <= 1.0f) {
            self.usefulTrailingSpaceConstraint.constant = self.bounds.size.width * (1 - rate);
        }
    }
}
@end
