//
//  JJTFansTableView.h
//  JJTree
//
//  Created by guojun on 8/9/15.
//  Copyright (c) 2015 guojunxu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JJTFansTableView;
@protocol JJTFansTableViewDelegate <NSObject>

@required
- (void)fansTableView:(JJTFansTableView *)tableView didSelectRowAtIndex:(NSInteger)index;

@end
@interface JJTFansTableView : UIView

@property (nonatomic, strong) NSArray *fans;

@property (nonatomic, weak) IBOutlet id<JJTFansTableViewDelegate> delegate;

@end
