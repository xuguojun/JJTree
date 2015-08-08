//
//  JJTAuthorHeader.m
//  JJTree
//
//  Created by guojun on 7/28/15.
//  Copyright (c) 2015 guojunxu. All rights reserved.
//

#import "JJTAuthorHeader.h"
#import "UIColor+JJTColor.h"
#import <SDWebImage/UIImageView+WebCache.h>

static NSString *WATCH = @"关注TA";
static NSString *UNWATCH = @"取消关注";

@interface JJTAuthorHeader()

@property (nonatomic, weak) IBOutlet UIImageView *avatarImageView;
@property (nonatomic, weak) IBOutlet UIButton *watchButton;

@end

@implementation JJTAuthorHeader{
    BOOL watched;
}

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
    
    self.avatarImageView.layer.cornerRadius = self.avatarImageView.bounds.size.width / 2.0f;
    self.avatarImageView.layer.masksToBounds = YES;
    self.avatarImageView.layer.borderColor = UIColorFromRGB(0xE8A433).CGColor;
    self.avatarImageView.layer.borderWidth = 1.6f;
    
    self.watchButton.layer.cornerRadius = 4.0f;
    self.watchButton.layer.borderColor = [UIColor grayColor].CGColor;
    self.watchButton.layer.borderWidth = 0.4f;
    self.watchButton.layer.masksToBounds = YES;
}
- (IBAction)watchButtonDidPress:(id)sender {
    
    if (!watched) {
        [self.watchButton setTitle:UNWATCH forState:(UIControlStateNormal)];
    } else {
        [self.watchButton setTitle:WATCH forState:(UIControlStateNormal)];
    }
    
    watched = !watched;
    
    if ([self.delegate respondsToSelector:@selector(authorHeaderDidPressWatchButton:)]) {
        [self.delegate authorHeaderDidPressWatchButton:self];
    }
}

#pragma mark - Getters & Setters
- (void)setAvatarURL:(NSString *)avatarURL{
    if (_avatarURL != avatarURL) {
        _avatarURL = avatarURL;
        [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:avatarURL]
                                placeholderImage:[UIImage imageNamed:@"Icon-Default"]];
    }
}

@end
