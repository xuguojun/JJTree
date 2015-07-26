//
//  JJTArticleTableCell.m
//  JJTree
//
//  Created by guojun on 7/26/15.
//  Copyright (c) 2015 guojunxu. All rights reserved.
//

#import "JJTArticleTableCell.h"
#import "NSDate+JJTDate.h"

@interface JJTArticleTableCell()

@property (nonatomic, weak) IBOutlet UILabel *articleTitleLabel;
@property (nonatomic, weak) IBOutlet UILabel *publishDateLabel;
@property (nonatomic, weak) IBOutlet UILabel *tagLabel;
@property (nonatomic, weak) IBOutlet UILabel *usefulValueLabel;
@property (nonatomic, weak) IBOutlet UILabel *amountValueLabel;

@end

@implementation JJTArticleTableCell

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
- (void)setArticle:(JJTArticle *)article{
    if (_article != article) {
        _article = article;
        
        self.articleTitleLabel.text = article.title;
        self.publishDateLabel.text = [article.createdAt toString];
        self.usefulValueLabel.text = [NSString stringWithFormat:@"👍%@", article.usefulValue];
        self.amountValueLabel.text = [NSString stringWithFormat:@"💰%@", article.rewardGotAmount];
    }
}

@end
