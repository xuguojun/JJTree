//
//  JJTAboutViewController.m
//  JJTree
//
//  Created by guojun on 8/1/15.
//  Copyright (c) 2015 guojunxu. All rights reserved.
//

#import "JJTAboutViewController.h"
#import "JJTRoleTableViewCell.h"

static NSString *ABOUT_JJTREE = @"元机经是一个为程序员们记录和分享编程开发知识点和解决方案的平台。\n\n它不是问答社区，也不是发表文章的平台，它专注于记录某个具体而客观的知识点或解决方案。\n\n如果你愿意，我们鼓励你将个人编写的机经分享至互联网，以为其他网友提供方便。与此同时，你也可能收获网友们打赏的金钱或其他回报。";

@interface JJTAboutViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) IBOutlet UITableView *aboutTableView;

@property (nonatomic, strong) JJTRoleTableViewCell *cell1;
@property (nonatomic, strong) JJTRoleTableViewCell *cell2;
@property (nonatomic, strong) JJTRoleTableViewCell *cell3;

@end

@implementation JJTAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"关于元机经";
}

- (NSString *)version{
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle]infoDictionary];
    NSString *version = infoDictionary[@"CFBundleShortVersionString"];
    version = [NSString stringWithFormat:@"元机经 Version %@", version];
    
    return version;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"cellIdentifier";
    
    JJTRoleTableViewCell *cell = (JJTRoleTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = [[JJTRoleTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                      reuseIdentifier:cellIdentifier];
    }
    
    cell.role = indexPath.row;
    
    if (indexPath.row == 0) {
        self.cell1 = cell;
    }
    
    if (indexPath.row == 1) {
        self.cell2 = cell;
    }
    
    if (indexPath.row == 2) {
        self.cell3 = cell;
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        return 74 + self.cell1.roleLabelSize.height;
    }
    
    if (indexPath.row == 1) {
        return 74 + self.cell2.roleLabelSize.height;
    }
    
    if (indexPath.row == 2) {
        return 74 + self.cell3.roleLabelSize.height;
    }
    
    return 88.f * 3.2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return ABOUT_JJTREE;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return [self version];
    } else {
        return nil;
    }
}

@end
