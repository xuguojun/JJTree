//
//  JJTRoleTableViewCell.m
//  JJTree
//
//  Created by guojun on 8/1/15.
//  Copyright (c) 2015 guojunxu. All rights reserved.
//

#import "JJTRoleTableViewCell.h"
#import "UILabel+JJTLabel.h"

@interface JJTRoleTableViewCell()

@property (nonatomic, weak) IBOutlet UIImageView *roleImageView;
@property (nonatomic, weak) IBOutlet UIImageView *roleTagImageView;
@property (nonatomic, weak) IBOutlet UILabel *roleDescLabel;

@property (nonatomic, assign) CGSize roleLabelSize;

@end

@implementation JJTRoleTableViewCell

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
    self.roleImageView.layer.cornerRadius = self.roleImageView.bounds.size.width / 2.0f;
    self.roleImageView.layer.borderColor = [UIColor grayColor].CGColor;
    self.roleImageView.layer.borderWidth = 0.4f;
    self.roleImageView.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (NSString *)roleAuthor{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"roleAuthor"
                                                     ofType:@"txt"];
    NSString *content = [NSString stringWithContentsOfFile:path
                                                  encoding:NSUTF8StringEncoding
                                                     error:NULL];
    
    return content;
}

- (NSString *)roleRead{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"roleRead"
                                                     ofType:@"txt"];
    NSString *content = [NSString stringWithContentsOfFile:path
                                                  encoding:NSUTF8StringEncoding
                                                     error:NULL];
    
    return content;
}

- (NSString *)roleEditor{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"roleEditor"
                                                     ofType:@"txt"];
    NSString *content = [NSString stringWithContentsOfFile:path
                                                  encoding:NSUTF8StringEncoding
                                                     error:NULL];
    
    return content;
}

#pragma mark - Getters & Setters
- (void)setRole:(JJTRole)role{
    if (role == RoleAuthor) {
        self.roleImageView.image = [UIImage imageNamed:@"author"];
        self.roleTagImageView.image = [UIImage imageNamed:@"author_tag"];
        self.roleDescLabel.text = [self roleAuthor];
    } else if (role == RoleRead){
        self.roleImageView.image = [UIImage imageNamed:@"read"];
        self.roleTagImageView.image = [UIImage imageNamed:@"read_tag"];
        self.roleDescLabel.text = [self roleRead];
    } else if (role == RoleEditor){
        self.roleImageView.image = [UIImage imageNamed:@"editor"];
        self.roleTagImageView.image = [UIImage imageNamed:@"editor_tag"];
        self.roleDescLabel.text = [self roleEditor];
    }
}

- (CGSize)roleLabelSize{
    return [self.roleDescLabel sizeOfMultiLineLabel];
}

@end
