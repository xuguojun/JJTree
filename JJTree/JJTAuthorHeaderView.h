//
//  JJTAuthorHeaderView.h
//  JJTree
//
//  Created by guojun on 7/26/15.
//  Copyright (c) 2015 guojunxu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JJTArticle.h"
#import "JJTUser.h"

@class JJTAuthorHeaderView;

@protocol JJTAuthorHeaderViewDelegate <NSObject>

@required
- (void)authorHeaderViewDidPress:(JJTAuthorHeaderView *)header;

@end
@interface JJTAuthorHeaderView : UIView

@property (nonatomic, strong) JJTArticle *article;
@property (nonatomic, strong) JJTUser *author;

@property (nonatomic, weak) IBOutlet id<JJTAuthorHeaderViewDelegate> delegate;

@end
