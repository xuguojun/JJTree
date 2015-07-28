//
//  JJTAuthorHeader.h
//  JJTree
//
//  Created by guojun on 7/28/15.
//  Copyright (c) 2015 guojunxu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JJTAuthorHeader;
@protocol JJTAuthorHeaderDelegate <NSObject>

@required
- (void)authorHeaderDidPressWatchButton:(JJTAuthorHeader *)header;

@end
@interface JJTAuthorHeader : UIView

@property (nonatomic, copy) NSString *avatarURL;

@property (nonatomic, weak) IBOutlet id<JJTAuthorHeaderDelegate> delegate;

@end
