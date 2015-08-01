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
#define CELL_LENGTH 60.0f

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

- (CGFloat)marginOfCell{
    NSInteger cellCount = MIN(4, self.imagesURLs.count);
    CGFloat width = (self.bounds.size.width - cellCount * CELL_LENGTH) / (2 * cellCount);
    
    return width;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.imagesURLs.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    JJTAvatarCollectionViewCell *cell = (JJTAvatarCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellID
                                                                                  forIndexPath:indexPath];
    
    cell.avatarURL = self.imagesURLs[indexPath.row];
    
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

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(CELL_LENGTH, CELL_LENGTH);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    CGFloat margin = [self marginOfCell];
    return UIEdgeInsetsMake(10, margin, 10, margin); // top, left, bottom, right
}

#pragma mark - Getters & Setters
- (void)setImagesURLs:(NSArray *)imagesURLs{
    if (_imagesURLs != imagesURLs) {
        _imagesURLs = imagesURLs;
        
        [self.avatarCollectionView reloadData];
    }
}

@end
