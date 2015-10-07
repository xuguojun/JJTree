//
//  JJTArticleTableViewCell.m
//  JJTree
//
//  Created by guojun on 8/9/15.
//  Copyright (c) 2015 guojunxu. All rights reserved.
//

#import "JJTBehaviorTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "NSDate+JJTDate.h"
#import "UIColor+JJTColor.h"

@interface JJTBehaviorTableViewCell()

@property (nonatomic, weak) IBOutlet UIImageView *avatarImageView;
@property (nonatomic, weak) IBOutlet UILabel *authorNameLabel;
@property (nonatomic, weak) IBOutlet UILabel *articleTitleLabel;
@property (nonatomic, weak) IBOutlet UILabel *valueLabel;
@property (nonatomic, weak) IBOutlet UILabel *dateLabel;

@end
@implementation JJTBehaviorTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class])
                                              owner:self
                                            options:nil] lastObject];
    }
    
    return self;
}

- (void)awakeFromNib {
    self.avatarImageView.layer.cornerRadius = self.avatarImageView.bounds.size.width / 2.0f;
    self.avatarImageView.layer.borderColor = UIColorFromRGB(0xE8A433).CGColor;
    self.avatarImageView.layer.borderWidth = 1.6f;
    self.avatarImageView.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - Getters & Setters
- (void)setArticle:(JJTArticle *)article{
    if (_article != article) {
        _article = article;
        
        self.articleTitleLabel.text = article.title;
        self.valueLabel.text = [article.usefulValue stringValue];
        self.dateLabel.text = [article.createdAt toString];
    }
}

- (void)setAuthor:(JJTUser *)author{
    if (_author != author) {
        _author = author;
        
        [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:author.userAvatarURL]
                                placeholderImage:[UIImage imageNamed:@"Icon-Default"]];
        self.authorNameLabel.text = author.userName;

    }
}

@end
