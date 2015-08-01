//
//  JJTAvatarCollectionViewCell.h
//  JJTree
//
//  Created by guojun on 8/1/15.
//  Copyright (c) 2015 guojunxu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JJTAvatarCollectionViewCell : UICollectionViewCell

@property (nonatomic, copy) NSString *avatarURL;
@property (nonatomic, assign) BOOL isSelected;

+ (UINib *)cellNib;

@end
