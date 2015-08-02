//
//  UIColor+JJTColor.h
//  JJTree
//
//  Created by guojun on 8/2/15.
//  Copyright (c) 2015 guojunxu. All rights reserved.
//

#import <UIKit/UIKit.h>

#define UIColorRGB(r, g, b)                                                    \
    [UIColor colorWithRed:(r / 255.0)green:(g / 255.0)blue:(b / 255.0)alpha:1]
#define UIColorRGBA(r, g, b, a)                                                \
    [UIColor colorWithRed:(r / 255.0)green:(g / 255.0)blue:(b / 255.0)alpha:(a)]
#define UIColorFromRGB(rgbValue)                                               \
    [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0       \
                green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0          \
                blue:((float)(rgbValue & 0xFF)) / 255.0                   \
                alpha:1.0]

@interface UIColor (JJTColor)

@end
