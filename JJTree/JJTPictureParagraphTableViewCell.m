//
//  JJTPictureParagraphTableViewCell.m
//  JJTree
//
//  Created by guojun on 7/26/15.
//  Copyright (c) 2015 guojunxu. All rights reserved.
//

#import "JJTPictureParagraphTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface JJTPictureParagraphTableViewCell()

@property (nonatomic, weak) IBOutlet UIImageView *pictureImageView;

@end
@implementation JJTPictureParagraphTableViewCell

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
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - Getters & Setters
- (void)setPictureURL:(NSString *)pictureURL{
    if (_pictureURL != pictureURL) {
        _pictureURL = pictureURL;
        
        [self.pictureImageView sd_setImageWithURL:[NSURL URLWithString:pictureURL]];
    }
}
@end
