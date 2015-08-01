//
//  JJTFormTableViewCell.h
//  JJTree
//
//  Created by guojun on 7/27/15.
//  Copyright (c) 2015 guojunxu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JJTFormTableViewCell;
@protocol JJTFormTableViewCellDelegate <NSObject>

@required
- (void)formTableViewCell:(JJTFormTableViewCell *)cell didFormatMatch:(BOOL)matched;

@end
@interface JJTFormTableViewCell : UITableViewCell

@property (nonatomic, assign) BOOL isSecure;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, assign) BOOL displayKeyboard;
@property (nonatomic, weak) IBOutlet id<JJTFormTableViewCellDelegate> delegate;

@end
