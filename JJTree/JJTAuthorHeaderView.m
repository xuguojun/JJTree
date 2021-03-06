//
//  JJTAuthorHeaderView.m
//  JJTree
//
//  Created by guojun on 7/26/15.
//  Copyright (c) 2015 guojunxu. All rights reserved.
//

#import "JJTAuthorHeaderView.h"
#import "JJTRateView.h"
#import "NSDate+JJTDate.h"
#import "UIColor+JJTColor.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface JJTAuthorHeaderView()

@property (nonatomic, weak) IBOutlet UIImageView *avatarImageView;
@property (nonatomic, weak) IBOutlet UILabel *authorNameLabel;
@property (nonatomic, weak) IBOutlet UILabel *createdAtLabel;
@property (nonatomic, weak) IBOutlet UILabel *statisticLabel;
@property (nonatomic, weak) IBOutlet JJTRateView *rateView;

@property (nonatomic, strong) UIGestureRecognizer *gesture;

@end

@implementation JJTAuthorHeaderView

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        
        [self loadView];
        [self addAction];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self loadView];
        [self addAction];
    }
    
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.avatarImageView.layer.cornerRadius = self.avatarImageView.bounds.size.width / 2.0f;
    self.avatarImageView.layer.masksToBounds = YES;
    self.avatarImageView.layer.borderColor = UIColorFromRGB(0xE8A433).CGColor;
    self.avatarImageView.layer.borderWidth = 1.6f;
    
    self.layer.shadowOffset = CGSizeMake(.0f, 0.3f);
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

- (void)addAction{
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:self.gesture];
}

- (void)headerViewDidTouch{
    if ([self.delegate respondsToSelector:@selector(authorHeaderViewDidPress:)]) {
        [self.delegate authorHeaderViewDidPress:self];
    }
}

- (NSAttributedString *)statisticValue:(JJTArticle *)article{
    NSString *value = [NSString stringWithFormat:@"👍%@👎%@ | 👀%@", article.usefulValue, article.uselessValue, article.viewCount];
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:value];

    // up
    NSRange rang1 = NSMakeRange(2, [article.usefulValue stringValue].length);
    [string addAttribute:NSFontAttributeName
                   value:[UIFont boldSystemFontOfSize:20]
                   range:rang1];
    
    [string addAttribute:NSForegroundColorAttributeName
                   value:UIColorFromRGB(0x308B16)
                   range:rang1];
    
    // down
    NSRange rang2 = NSMakeRange([article.usefulValue stringValue].length + 4, [article.uselessValue stringValue].length);
    [string addAttribute:NSFontAttributeName
                   value:[UIFont systemFontOfSize:14]
                   range:rang2];
    
    [string addAttribute:NSForegroundColorAttributeName
                   value:[UIColor grayColor]
                   range:rang2];
    
    // separator line
    NSRange rang3 = NSMakeRange([article.usefulValue stringValue].length + 4 + [article.uselessValue stringValue].length + 1, 1);
    [string addAttribute:NSFontAttributeName
                   value:[UIFont systemFontOfSize:21]
                   range:rang3];
    
    [string addAttribute:NSForegroundColorAttributeName
                   value:[UIColor lightGrayColor]
                   range:rang3];
    
    return string;
}

#pragma mark - Getters & Setters
- (void)setArticle:(JJTArticle *)article{
    _article = article;
    
    self.statisticLabel.attributedText = [self statisticValue:article];
    self.rateView.rate = ([article.usefulValue floatValue] / ([article.usefulValue floatValue] + [article.uselessValue floatValue]));
    self.createdAtLabel.text = [article.createdAt toString];
}

- (void)setAuthor:(JJTUser *)author{
    if (_author != author) {
        _author = author;
        
        [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:author.userAvatarURL]
                                placeholderImage:[UIImage imageNamed:@"Icon-Default"]];
        self.authorNameLabel.text = author.userName;
    }
}

- (UIGestureRecognizer *)gesture{
    if (!_gesture) {
        _gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headerViewDidTouch)];
    }
    
    return _gesture;
}
@end
