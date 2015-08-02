//
//  UIPageMarker.m
//  UIPageSlider
//
//  Created by guojun on 4/7/15.
//  Copyright (c) 2015 guojunxu. All rights reserved.
//

#import "JJTPlusView.h"
#import "UIColor+JJTColor.h"

static const CGFloat STROKE_WIDTH = 0.6f;
static const CGFloat CIRCLE_RADIUS = 18.0f;

@interface JJTPlusView()

@property (nonatomic, strong) UILabel *titleLabel;

@end


@implementation JJTPlusView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addTitleLabel:@"+1"];
        self.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self addTitleLabel:@"+1"];
        self.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}

- (void)addTitleLabel:(NSString *)text{
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:self.bounds];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = text;
    titleLabel.font = [UIFont systemFontOfSize:12];
    titleLabel.textColor = [UIColor whiteColor];
    
    self.titleLabel = titleLabel;
    [self addSubview:titleLabel];
}

- (void)drawRect:(CGRect)rect{
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSaveGState(context);
    
    {
        UIColor *strokeColor = UIColorFromRGB(0xD8D8D8);
        UIColor *fillColor = self.circleColor;
        
        CGContextSetStrokeColorWithColor(context, strokeColor.CGColor);
        CGContextSetLineWidth(context, STROKE_WIDTH);
        CGContextSetFillColorWithColor(context, fillColor.CGColor);
        
        CGFloat rectWidth = sqrtf(2) * (CIRCLE_RADIUS - STROKE_WIDTH);
        CGFloat rectHeight = rectWidth;
        CGFloat rectX = (CGRectGetWidth(self.bounds) / 2) - (rectWidth / 2);
        CGFloat rectY = rectX;
        
        rect = CGRectMake(rectX, rectY, rectWidth, rectHeight);
        CGContextStrokeEllipseInRect(context, rect);
        
        CGSize offset = CGSizeMake(0, 2.0);
        CGContextSetShadow(context, offset, 4.0);
        
        CGContextFillEllipseInRect(context, rect);
    }
    
    CGContextRestoreGState(context);
}

- (void)setCircleColor:(UIColor *)circleColor{
    _circleColor = circleColor;
    
    [self setNeedsDisplay];
}

@end

