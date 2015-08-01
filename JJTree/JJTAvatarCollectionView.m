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

@interface JJTAvatarCollectionView()<UICollectionViewDataSource, UICollectionViewDelegate>

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

#pragma mark - Private Methods
- (void)loadView{
    UIView *view = [[[NSBundle bundleForClass:[self class]] loadNibNamed:NSStringFromClass([self class])
                                                                   owner:self
                                                                 options:nil] firstObject];
    
    view.frame = self.bounds;
    
    [self addSubview:view];
}

- (void)configureView{
//    [self.avatarCollectionView registerNib:[JJTAvatarCollectionViewCell cellNib]
//                forCellWithReuseIdentifier:cellID];
//        [self.avatarCollectionView registerNib:[UINib nibWithNibName:@"UICollectionViewCell" bundle:nil]
//                    forCellWithReuseIdentifier:cellID];
    [self.avatarCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellID];
    
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID
                                                                                  forIndexPath:indexPath];
//    if (!cell) {
//        cell = [[UICollectionViewCell alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
//    }
    
//    cell.avatarURL = @"http://d1oi7t5trwfj5d.cloudfront.net/91/a9/5a2c1503496da25094b88e9eda5f/avatar.jpeg";
    
    cell.backgroundColor = [UIColor redColor];
    
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
