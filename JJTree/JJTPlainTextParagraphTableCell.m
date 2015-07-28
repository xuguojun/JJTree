//
//  JJTPlainTextParagraphTableCell.m
//  JJTree
//
//  Created by guojun on 7/26/15.
//  Copyright (c) 2015 guojunxu. All rights reserved.
//

#import "JJTPlainTextParagraphTableCell.h"

@interface JJTPlainTextParagraphTableCell()

@property (nonatomic, weak) IBOutlet UILabel *plainTextLabel;

@end
@implementation JJTPlainTextParagraphTableCell

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
    self.plainTextLabel.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - Getters & Setters
- (void)setText:(NSString *)text{
    if (_text != text) {
        _text = text;
        
        self.plainTextLabel.text = text;
    }
}

@end
