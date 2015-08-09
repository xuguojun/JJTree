//
//  JJTProfileViewController.m
//  JJTree
//
//  Created by guojun on 7/28/15.
//  Copyright (c) 2015 guojunxu. All rights reserved.
//

#import "JJTProfileViewController.h"
#import "JJTPreferenceViewController.h"
#import "JJTBehaviorViewController.h"
#import "JJTAboutViewController.h"

static NSString *LOGOUT = @"退出登录";

@interface JJTProfileViewController ()<UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>

@property (nonatomic, strong) NSArray *sectionTitles;
@property (nonatomic, strong) NSArray *readerSectionTitles;
@property (nonatomic, strong) NSArray *authorSectionTitles;
@property (nonatomic, strong) NSArray *editorSectionTitles;
@property (nonatomic, copy) NSString *logoutTitle;

@property (nonatomic, weak) IBOutlet UITableView *profileTableView;
@property (nonatomic, strong) UIBarButtonItem *preferenceButton;
@property (nonatomic, strong) UIButton *logoutButton;
@property (nonatomic, strong) UIAlertView *logoutAlertView;

@end

@implementation JJTProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"我";
    self.navigationItem.rightBarButtonItem = self.preferenceButton;
    self.profileTableView.tableFooterView = self.logoutButton;
    
    self.sectionTitles = @[@"作为读者",@"作为作者", @"作为编辑者"];
    self.readerSectionTitles = @[@"打赏过的机经", @"收藏的机经", @"亲测有用的机经"];
    self.authorSectionTitles = @[@"拥有粉丝", @"获得打赏"];
    self.editorSectionTitles = @[@"编辑过的机经"];
}

- (void)showAlertView{
    [self.logoutAlertView show];
}

- (void)preference{
    JJTPreferenceViewController *prefrence = [JJTPreferenceViewController new];
    [self.navigationController pushViewController:prefrence animated:YES];
}

- (void)about{
    JJTAboutViewController *aboutVC = [JJTAboutViewController new];
    [self.navigationController pushViewController:aboutVC animated:YES];
}

- (void)logout{
    self.currentUser.hasLogined = @NO;
    
    if ([self.delegate respondsToSelector:@selector(profileViewController:didLogoutWithAccount:)]) {
        [self.delegate profileViewController:self didLogoutWithAccount:self.currentUser];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.sectionTitles.count + 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return self.readerSectionTitles.count;
    } else if (section == 1){
        return self.authorSectionTitles.count;
    } else if (section == 2){
        return self.editorSectionTitles.count;
    }
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"cellIdentifier";
    
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                      reuseIdentifier:cellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    if (indexPath.section == 0) {
        cell.textLabel.text = self.readerSectionTitles[indexPath.row];
    } else if (indexPath.section == 1){
        cell.textLabel.text = self.authorSectionTitles[indexPath.row];
    } else if (indexPath.section == 2){
        cell.textLabel.text = self.editorSectionTitles[indexPath.row];
    } else if (indexPath.section == 3){
        cell.textLabel.text = @"关于元机经";
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        JJTBehaviorViewController *behavior = [JJTBehaviorViewController new];
        [self.navigationController pushViewController:behavior animated:YES];
    }
    
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            // fans
            JJTBehaviorViewController *behavior = [JJTBehaviorViewController new];
            behavior.behaviorType = JJTBehaviorAuthor;
            [self.navigationController pushViewController:behavior animated:YES];
        }
        
        if (indexPath.row == 1) {
            JJTBehaviorViewController *behavior = [JJTBehaviorViewController new];
            [self.navigationController pushViewController:behavior animated:YES];
        }
    }
    
    if (indexPath.section == 2) {
        JJTBehaviorViewController *behavior = [JJTBehaviorViewController new];
        [self.navigationController pushViewController:behavior animated:YES];
    }
    
    if (indexPath.section == 3) {
        [self about];
    }
}

#pragma mark - UITableViewDelegate
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 3) {
        return nil;
    }
    
    return self.sectionTitles[section];
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        
    } else if (buttonIndex == 1){
        [self logout];
    }
}

#pragma mark - Getters & Setters
- (UIButton *)logoutButton{
    if (!_logoutButton) {
        _logoutButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 44)];
        [_logoutButton setTitle:LOGOUT forState:(UIControlStateNormal)];
        [_logoutButton setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];
        [_logoutButton setTitleColor:[UIColor grayColor] forState:(UIControlStateHighlighted | UIControlStateSelected)];
        [_logoutButton addTarget:self action:@selector(showAlertView) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _logoutButton;
}

- (UIBarButtonItem *)preferenceButton{
    if (!_preferenceButton) {
        _preferenceButton = [[UIBarButtonItem alloc] initWithTitle:@"偏好"
                                                             style:(UIBarButtonItemStylePlain)
                                                            target:self
                                                            action:@selector(preference)];
    }
    
    return _preferenceButton;
}

- (UIAlertView *)logoutAlertView{
    if (!_logoutAlertView) {
        _logoutAlertView = [[UIAlertView alloc] initWithTitle:@"退出"
                                                      message:@"确定要退出么？"
                                                     delegate:self
                                            cancelButtonTitle:@"取消"
                                            otherButtonTitles:@"确定", nil];
    }
    
    return _logoutAlertView;
}
@end
