//
//  JJTFormView.h
//  JJTree
//
//  Created by guojun on 7/27/15.
//  Copyright (c) 2015 guojunxu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JJTUser.h"

@class JJTFormTableView;
@protocol JJFormViewDelegate <NSObject>

@required
- (void)formView:(JJTFormTableView *)formView didFormatMatch:(BOOL)matched;

@end
@interface JJTFormTableView : UIView

@property (nonatomic, strong) JJTUser *user;
@property (nonatomic, copy, readonly) NSString *account;
@property (nonatomic, copy, readonly) NSString *password;
@property (nonatomic, assign) BOOL displayKeyboard;

@property (nonatomic, weak) IBOutlet id<JJFormViewDelegate> delegate;

@end
