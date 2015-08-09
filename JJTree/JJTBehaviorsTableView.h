//
//  JJTBehaviorsTableView.h
//  JJTree
//
//  Created by guojun on 8/9/15.
//  Copyright (c) 2015 guojunxu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JJTBehaviorsTableView;
@protocol JJTBehaviorsTableViewDelegate <NSObject>

@required
- (void)behaviorTableView:(JJTBehaviorsTableView *)tableView didSelectRowAtIndex:(NSInteger)index;

@end
@interface JJTBehaviorsTableView : UIView

@property (nonatomic, strong) NSArray *articles;
@property (nonatomic, strong) NSArray *authors;

@property (nonatomic, weak) IBOutlet id<JJTBehaviorsTableViewDelegate> delegate;

@end
