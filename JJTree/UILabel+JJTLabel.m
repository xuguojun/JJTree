//
//  UILabel+JJTLabel.m
//  JJTree
//
//  Created by guojun on 8/6/15.
//  Copyright (c) 2015 guojunxu. All rights reserved.
//

#import "UILabel+JJTLabel.h"

@implementation UILabel (JJTLabel)

-(CGSize)sizeOfMultiLineLabel{
    
    //Label text
    NSString *aLabelTextString = [self text];
    
    //Label font
    UIFont *aLabelFont = [self font];
    
    //Width of the Label
    CGFloat aLabelSizeWidth = self.frame.size.width;
    
    
    if (SYSTEM_VERSION_LESS_THAN(iOS7_0)) {
        //version < 7.0
        
        return [aLabelTextString sizeWithFont:aLabelFont
                            constrainedToSize:CGSizeMake(aLabelSizeWidth, MAXFLOAT)
                                lineBreakMode:NSLineBreakByWordWrapping];
    } else if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(iOS7_0)) {
        //version >= 7.0
        
        //Return the calculated size of the Label
        return [aLabelTextString boundingRectWithSize:CGSizeMake(aLabelSizeWidth, MAXFLOAT)
                                              options:NSStringDrawingUsesLineFragmentOrigin
                                           attributes:@{ NSFontAttributeName : aLabelFont }
                                              context:nil].size;
        
    }
    
    return [self bounds].size;
}

@end
