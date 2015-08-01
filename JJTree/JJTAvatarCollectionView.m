//
//  JJTAvatarSelectorView.m
//  JJTree
//
//  Created by guojun on 8/1/15.
//  Copyright (c) 2015 guojunxu. All rights reserved.
//

#import "JJTAvatarCollectionView.h"
#import "JJTAvatarCollectionViewCell.h"

@interface JJTAvatarCollectionView()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, weak) IBOutlet UICollectionView *avatarCollectionView;

@end
@implementation JJTAvatarCollectionView

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        
        [self loadView];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self loadView];
    }
    
    return self;
}

#pragma mark - Private Methods
- (void)loadView{
    UIView *view = [[[NSBundle bundleForClass:[self class]] loadNibNamed:NSStringFromClass([self class])
                                                                   owner:self
                                                                 options:nil] firstObject];
    
    view.frame = self.bounds;
    
    [self addSubview:view];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"cellID";
    
    JJTAvatarCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID
                                                                                  forIndexPath:indexPath];
    
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark - Getters & Setters
- (void)setImagesURLs:(NSArray *)imagesURLs{
    if (_imagesURLs != imagesURLs) {
        _imagesURLs = imagesURLs;
        
        [self.avatarCollectionView reloadData];
    }
}

@end
