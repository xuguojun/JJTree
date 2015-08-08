//
//  JJTPlainTextParagraphTableCell.h
//  JJTree
//
//  Created by guojun on 7/26/15.
//  Copyright (c) 2015 guojunxu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JJTPlainTextParagraphTableCell : UITableViewCell

@property (nonatomic, copy) NSString *text;
@property (nonatomic, assign, readonly) CGSize plainTextLabelSize;

@end
