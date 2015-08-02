//
//  JJTArticleTableCell.m
//  JJTree
//
//  Created by guojun on 7/26/15.
//  Copyright (c) 2015 guojunxu. All rights reserved.
//

#import "JJTArticleTableCell.h"
#import "NSDate+JJTDate.h"

static NSString *USEFUL = @"有用";
static NSString *USELESS = @"无用";
static NSString *READ = @"已阅";

@interface JJTArticleTableCell()

@property (nonatomic, weak) IBOutlet UILabel *articleTitleLabel;
@property (nonatomic, weak) IBOutlet UILabel *publishDateLabel;
@property (nonatomic, weak) IBOutlet UILabel *tagLabel;
@property (nonatomic, weak) IBOutlet UILabel *statisticLabel;

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
    self.tagLabel.textColor = [UIColor whiteColor];
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
    
        self.statisticLabel.text = [NSString stringWithFormat:@"👍%@, 💰%@", article.usefulValue, article.rewardGotAmount];
    }
}

- (void)setReadBehavior:(JJTReadBehavior *)readBehavior{
    if (_readBehavior != readBehavior) {
        _readBehavior = readBehavior;
        
        if (!readBehavior) {
            self.tagLabel.hidden = YES;
            return;
        } else {
            self.tagLabel.hidden = NO;
        }
        
        BOOL useful = [readBehavior.markAsUseful boolValue];
        if (useful) {
            self.tagLabel.text = USEFUL;
            self.tagLabel.backgroundColor = [UIColor greenColor];
        }
        
        BOOL useless = [readBehavior.markAsUseless boolValue];
        if (useless) {
            self.tagLabel.text = USELESS;
            self.tagLabel.backgroundColor = [UIColor lightGrayColor];
        }
        
        BOOL read = [readBehavior.hasRead boolValue];
        if ((!useful && !useless) && read) {
            self.tagLabel.text = READ;
            self.tagLabel.backgroundColor = [UIColor blueColor];
        }
    }
}

@end
