//
//  JJTAvatarSelectorView.h
//  JJTree
//
//  Created by guojun on 8/1/15.
//  Copyright (c) 2015 guojunxu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JJTAvatarCollectionView;
@protocol JJTAvatarCollectionViewDelegate <NSObject>

@required
- (void)avatarCollectionView:(JJTAvatarCollectionView *)collectionView
         didSelectRowAtIndex:(NSInteger)index;

@end
@interface JJTAvatarCollectionView : UIView

@property (nonatomic, strong) NSArray *imagesURLs;
@property (nonatomic, weak) IBOutlet id<JJTAvatarCollectionViewDelegate> delegate;

@end
