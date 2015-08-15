//
//  JJTFormTableViewCell.m
//  JJTree
//
//  Created by guojun on 7/27/15.
//  Copyright (c) 2015 guojunxu. All rights reserved.
//

#import "JJTFormTableViewCell.h"
#import "NSString+JJTString.h"

static NSString *USER_PLACEHOLDER = @"邮箱/手机号";
static NSString *PASSWORD_PLACEHOLDER = @"密码";

@interface JJTFormTableViewCell()

@property (nonatomic, weak) IBOutlet UITextField *formTextField;

@end
@implementation JJTFormTableViewCell

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
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - Private Methods

- (IBAction)checkUserInput:(id)sender{
    
    BOOL matched = NO;
    
    if (self.isSecure) {
        matched = [self.formTextField.text matchPasswordFormat];
    } else {
        matched = [self.formTextField.text matchEmailFormat];
    }
    
    if ([self.delegate respondsToSelector:@selector(formTableViewCell:didFormatMatch:)]) {
        [self.delegate formTableViewCell:self didFormatMatch:matched];
    }
}

#pragma mark - Getters & Setters
- (void)setIsSecure:(BOOL)isSecure{
    if (_isSecure != isSecure) {
        _isSecure = isSecure;

        [self.formTextField setSecureTextEntry:isSecure];
        if (isSecure) {
            self.formTextField.placeholder = PASSWORD_PLACEHOLDER;
        } else {
            self.formTextField.placeholder = USER_PLACEHOLDER;
        }
    }
}

- (void)setText:(NSString *)text{
    self.formTextField.text = text;
}

- (NSString *)text{
    return self.formTextField.text;
}

- (void)setDisplayKeyboard:(BOOL)displayKeyboard{
    _displayKeyboard = displayKeyboard;
    if (displayKeyboard) {
        [self.formTextField becomeFirstResponder];
    } else {
        [self.formTextField resignFirstResponder];
    }
}

@end
