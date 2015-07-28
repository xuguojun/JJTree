//
//  JJTBlockLineTableViewCell.m
//  JJTree
//
//  Created by guojun on 7/28/15.
//  Copyright (c) 2015 guojunxu. All rights reserved.
//

#import "JJTBlockLineTableViewCell.h"

@interface JJTBlockLineTableViewCell()

@property (nonatomic, weak) IBOutlet UILabel *lineLabel;

@end
@implementation JJTBlockLineTableViewCell

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
- (void)setLine:(NSInteger)line{
    self.lineLabel.text = [NSString stringWithFormat:@"%ld", (long)line];
}

@end
