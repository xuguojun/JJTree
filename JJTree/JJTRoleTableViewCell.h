//
//  JJTRoleTableViewCell.h
//  JJTree
//
//  Created by guojun on 8/1/15.
//  Copyright (c) 2015 guojunxu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    RoleAuthor = 0,
    RoleRead = 1,
    RoleEditor =2
} JJTRole;
@interface JJTRoleTableViewCell : UITableViewCell

@property (nonatomic, assign) JJTRole role;
@property (nonatomic, assign, readonly) CGSize roleLabelSize;

@end
