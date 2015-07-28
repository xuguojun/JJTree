//
//  JJTAuthorTableView.h
//  JJTree
//
//  Created by guojun on 7/28/15.
//  Copyright (c) 2015 guojunxu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JJTAuthorTableView;

@protocol JJTAuthorTableViewDelegate <NSObject>

@required
- (void)authorTableView:(JJTAuthorTableView *)tableView didSelectRowAtIndex:(NSInteger)index;

@end
@interface JJTAuthorTableView : UIView

@property (nonatomic, strong) NSArray *articles;

@property (nonatomic, weak) IBOutlet id<JJTAuthorTableViewDelegate> delegate;

@end
