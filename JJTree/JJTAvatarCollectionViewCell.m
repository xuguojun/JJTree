//
//  JJTAvatarCollectionViewCell.m
//  JJTree
//
//  Created by guojun on 8/1/15.
//  Copyright (c) 2015 guojunxu. All rights reserved.
//

#import "JJTAvatarCollectionViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface JJTAvatarCollectionViewCell()

@property (nonatomic, weak) IBOutlet UIImageView *avatarImageView;

@end
@implementation JJTAvatarCollectionViewCell

- (instancetype)init{
    
    self = [super init];
    
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class])
                                              owner:self
                                            options:nil] lastObject];
    }
    
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)highlightView:(UIView *)view{
    view.layer.cornerRadius = view.bounds.size.width / 2;
    view.layer.borderColor = [UIColor orangeColor].CGColor;
    view.layer.borderWidth = 3.f;
    view.layer.masksToBounds = YES;
}

- (void)unhighlightView:(UIView *)view{
    view.layer.cornerRadius = view.bounds.size.width / 2;
    view.layer.borderColor = [UIColor whiteColor].CGColor;
    view.layer.borderWidth = 1.f;
    view.layer.masksToBounds = YES;
}

#pragma mark - Getters & Setters
- (void)setIsSelected:(BOOL)isSelected{
    _isSelected = isSelected;
    
    if (isSelected) {
        [self highlightView:self.avatarImageView];
    } else {
        [self unhighlightView:self.avatarImageView];
    }
}

- (void)setAvatarURL:(NSString *)avatarURL{
    if (_avatarURL != avatarURL) {
        _avatarURL = avatarURL;
        
        [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:avatarURL] placeholderImage:nil];
    }
}

@end
