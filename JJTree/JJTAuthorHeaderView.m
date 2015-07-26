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

@interface JJTAuthorHeaderView()

@property (nonatomic, weak) IBOutlet UIImageView *avatarImageView;
@property (nonatomic, weak) IBOutlet UILabel *authorNameLabel;
@property (nonatomic, weak) IBOutlet UILabel *createdAtLabel;
@property (nonatomic, weak) IBOutlet UILabel *statisticLabel;
@property (nonatomic, weak) IBOutlet JJTRateView *rateView;

@end

@implementation JJTAuthorHeaderView

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

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.avatarImageView.layer.cornerRadius = self.avatarImageView.bounds.size.width / 2.0f;
    self.avatarImageView.layer.masksToBounds = YES;
    self.avatarImageView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.avatarImageView.layer.borderWidth = 0.8f;
}
#pragma mark - Private Methods
- (void)loadView{
    UIView *view = [[[NSBundle bundleForClass:[self class]] loadNibNamed:NSStringFromClass([self class])
                                                                   owner:self
                                                                 options:nil] firstObject];
    
    view.frame = self.bounds;
    
    [self addSubview:view];
}

#pragma mark - Getters & Setters
- (void)setArticle:(JJTArticle *)article{
    if (_article != article) {
        _article = article;
        
        self.statisticLabel.text = [NSString stringWithFormat:@"👍%@,👇%@ | 👀%@", article.usefulValue, article.uselessValue, article.viewCount];
        self.rateView.rate = ([article.usefulValue integerValue] / ([article.usefulValue integerValue] + [article.uselessValue integerValue]));
        self.createdAtLabel.text = [article.createdAt toString];
    }
}

- (void)setAuthor:(JJTAuthor *)author{
    if (_author != author) {
        _author = author;
        
//        self.avatarImageView.image = author.avatarURL;
        self.authorNameLabel.text = author.roleName;
    }
}

@end
