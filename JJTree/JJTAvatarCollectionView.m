//
//  JJTAvatarSelectorView.m
//  JJTree
//
//  Created by guojun on 8/1/15.
//  Copyright (c) 2015 guojunxu. All rights reserved.
//

#import "JJTAvatarCollectionView.h"
#import "JJTAvatarCollectionViewCell.h"

static NSString *cellID = @"cellID";

@interface JJTAvatarCollectionView()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, weak) IBOutlet UICollectionView *avatarCollectionView;

@end
@implementation JJTAvatarCollectionView

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        
        [self loadView];
        [self configureView];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self loadView];
        [self configureView];
    }
    
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];;
    
    self.layer.shadowOffset = CGSizeMake(0.3f, 0.6f);
    self.layer.shadowRadius = 0.3f;
    self.layer.shadowOpacity = .6f;
    self.layer.shadowColor = [UIColor grayColor].CGColor;
}

#pragma mark - Private Methods
- (void)loadView{
    UIView *view = [[[NSBundle bundleForClass:[self class]] loadNibNamed:NSStringFromClass([self class])
                                                                   owner:self
                                                                 options:nil] firstObject];
    
    view.frame = self.bounds;
    
    [self addSubview:view];
}

- (void)configureView{
    self.avatarCollectionView.backgroundColor = [UIColor clearColor];
    [self.avatarCollectionView registerNib:[JJTAvatarCollectionViewCell cellNib]
                forCellWithReuseIdentifier:cellID];
    
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    JJTAvatarCollectionViewCell *cell = (JJTAvatarCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellID
                                                                                  forIndexPath:indexPath];
    
    cell.avatarURL = @"http://d1oi7t5trwfj5d.cloudfront.net/91/a9/5a2c1503496da25094b88e9eda5f/avatar.jpeg";
    
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    JJTAvatarCollectionViewCell *cell = (JJTAvatarCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.isSelected = YES;
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    JJTAvatarCollectionViewCell *cell = (JJTAvatarCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.isSelected = NO;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(55.f, 55.f);
}

#pragma mark - Getters & Setters
- (void)setImagesURLs:(NSArray *)imagesURLs{
    if (_imagesURLs != imagesURLs) {
        _imagesURLs = imagesURLs;
        
        [self.avatarCollectionView reloadData];
    }
}

@end
