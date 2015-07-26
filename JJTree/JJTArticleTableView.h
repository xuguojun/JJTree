//
//  JJTArticleTableView.h
//  JJTree
//
//  Created by guojun on 7/26/15.
//  Copyright (c) 2015 guojunxu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JJTArticleTableView;
@protocol JJTArticleTableViewDelegate <NSObject>

@required
- (void)articleTableView:(JJTArticleTableView *)tableView didSelectRowAtIndex:(NSInteger)index;

@end
@interface JJTArticleTableView : UIView

@property (nonatomic, strong) NSArray *articles;
@property (nonatomic, weak) IBOutlet id<JJTArticleTableViewDelegate> delegate;

@end
