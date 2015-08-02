//
//  JJTFormView.m
//  JJTree
//
//  Created by guojun on 7/27/15.
//  Copyright (c) 2015 guojunxu. All rights reserved.
//

#import "JJTFormTableView.h"
#import "JJTFormTableViewCell.h"

static NSString *ACCOUNT_ERROR = @"请输入合法有效的邮箱号/手机号";
static NSString *PASSWORD_ERROR = @"请输入至少6位字符";

@interface JJTFormTableView()<JJTFormTableViewCellDelegate>

@property (nonatomic, weak) IBOutlet UITableView *formTableView;
@property (nonatomic, strong) UILabel *errorHintLabel;

@property (nonatomic, strong) JJTFormTableViewCell *userCell;
@property (nonatomic, strong) JJTFormTableViewCell *passwordCell;

@property (nonatomic, copy) NSString *account;
@property (nonatomic, copy) NSString *password;

@end

@implementation JJTFormTableView

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        
        [self loadView];
        [self configureView];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self loadView];
        [self configureView];
    }
    
    return self;
}

#pragma mark - Private Methods
- (void)loadView{
    UIView *view = [[[NSBundle bundleForClass:[self class]] loadNibNamed:NSStringFromClass([self class])
                                                                   owner:self
                                                                 options:nil] firstObject];
    
    view.frame = self.bounds;
    
    [self addSubview:view];
}

- (void)configureView{
    self.formTableView.tableHeaderView = self.errorHintLabel;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"cellIdentifier";
    
    JJTFormTableViewCell *cell = (JJTFormTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = [[JJTFormTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                           reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    if (indexPath.row == 0) {
        cell.isSecure = NO;
        self.userCell = cell;
    } else {
        cell.isSecure = YES;
        self.passwordCell = cell;
    }
    
    cell.delegate = self;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44.f;
}

#pragma mark - JJTFormTableViewCellDelegate
- (void)formTableViewCell:(JJTFormTableViewCell *)cell didFormatMatch:(BOOL)matched{
    if (cell == self.userCell) {
        if (!matched) {
            self.errorHintLabel.text = ACCOUNT_ERROR;
        } else {
            self.errorHintLabel.text = nil;
        }
    } else {
        if (!matched) {
            self.errorHintLabel.text = PASSWORD_ERROR;
        } else {
            self.errorHintLabel.text = nil;
        }
    }
    
    if ([self.delegate respondsToSelector:@selector(formView:didFormatMatch:)]) {
        [self.delegate formView:self didFormatMatch:matched];
    }
}

#pragma mark - Getters & Setters
- (UILabel *)errorHintLabel{
    if (!_errorHintLabel) {
        
        CGRect frame = CGRectMake(0, 0, self.bounds.size.width, 21);
        
        _errorHintLabel = [[UILabel alloc] initWithFrame:frame];
        _errorHintLabel.font = [UIFont boldSystemFontOfSize:12];
        _errorHintLabel.textColor = [UIColor orangeColor];
        _errorHintLabel.backgroundColor = [UIColor clearColor];
        _errorHintLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    return _errorHintLabel;
}

- (void)setUser:(JJTUser *)user{
    if (_user != user) {
        _user = user;
        
        NSString *text = nil;
        if (user.userEmail) {
            text = user.userEmail;
        }
        
        if (user.userMobile) {
            text = user.userMobile;
        }
        
        self.userCell.text = text;
        self.passwordCell.text = user.userPassword;
    }
}

- (void)setDisplayKeyboard:(BOOL)displayKeyboard{
    _displayKeyboard = displayKeyboard;
    
    self.userCell.displayKeyboard = displayKeyboard;
    self.passwordCell.displayKeyboard = displayKeyboard;
}

- (NSString *)account{
    return self.userCell.text;
}

- (NSString *)password{
    return self.passwordCell.text;
}
@end
