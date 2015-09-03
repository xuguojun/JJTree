//
//  JJTFansTableViewCell.m
//  JJTree
//
//  Created by guojun on 8/9/15.
//  Copyright (c) 2015 guojunxu. All rights reserved.
//

#import "JJTFansTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "UIColor+JJTColor.h"

static NSString *HAS_ARTICLE_COUNT = @"拥有%@篇机经";

@interface JJTFansTableViewCell()

@property (nonatomic, weak) IBOutlet UIImageView *fanAvatarImageView;
@property (nonatomic, weak) IBOutlet UILabel *fanNameLabel;
@property (nonatomic, weak) IBOutlet UILabel *articlesCountLabel;

@end

@implementation JJTFansTableViewCell

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

    self.fanAvatarImageView.layer.cornerRadius = self.fanAvatarImageView.bounds.size.width / 2.0f;
    self.fanAvatarImageView.layer.borderColor = UIColorFromRGB(0xE8A433).CGColor;
    self.fanAvatarImageView.layer.borderWidth = 1.6f;
    self.fanAvatarImageView.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - Getters & Setters
- (void)setFan:(JJTUser *)fan{
    if (_fan != fan) {
        _fan = fan;
        
        [self.fanAvatarImageView sd_setImageWithURL:[NSURL URLWithString:fan.userAvatarURL]
                                   placeholderImage:[UIImage imageNamed:@"Icon-Default"]];
        self.fanNameLabel.text = fan.userName;
        self.articlesCountLabel.text = [NSString stringWithFormat:HAS_ARTICLE_COUNT, fan.userArticleCountPublished];
    }
}

@end
