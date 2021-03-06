//
//  JJTBlockTableViewCell.m
//  JJTree
//
//  Created by guojun on 7/26/15.
//  Copyright (c) 2015 guojunxu. All rights reserved.
//

#import "JJTBlockParagraphTableViewCell.h"
#import "JJTBlockWebView.h"

@interface JJTBlockParagraphTableViewCell()

@property (nonatomic, weak) IBOutlet JJTBlockWebView *blockWebView;

@end
@implementation JJTBlockParagraphTableViewCell

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
- (void)setBlockURL:(NSString *)blockURL{
    if (_blockURL != blockURL) {
        _blockURL = blockURL;
        
        self.blockWebView.blockURL = blockURL;
    }
}
@end
