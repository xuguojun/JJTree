//
//  JJTPreferenceViewController.m
//  JJTree
//
//  Created by guojun on 7/27/15.
//  Copyright (c) 2015 guojunxu. All rights reserved.
//

#import "JJTPreferenceViewController.h"
#import "JJTBlockStyleViewController.h"

@interface JJTPreferenceViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) IBOutlet UITableView *prefrenceTableView;

@property (nonatomic, strong) NSArray *sectionTitles;
@property (nonatomic, strong) NSArray *topTitles;
@property (nonatomic, strong) NSArray *recentTitles;
@property (nonatomic, strong) NSArray *blockTitles;

@end

@implementation JJTPreferenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"偏好设置";

    self.topTitles = @[@"按👍(亲测有用)高低", @"按💰(获得打赏金额)高低"];
    self.recentTitles = @[@"按发布日期先后", @"按更新日期先后"];
    self.sectionTitles = @[@"TOP机经排序原则", @"最新机经排序原则"];
    self.blockTitles = @[@"代码块CSS样式"];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return self.topTitles.count;
    } else if (section == 1){
        return self.recentTitles.count;
    }
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"cellIdentifier";
    
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                      reuseIdentifier:cellIdentifier];
    }
    
    if (indexPath.section == 0) {
        cell.textLabel.text = self.topTitles[indexPath.row];
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else if (indexPath.section == 1){
        cell.textLabel.text = self.recentTitles[indexPath.row];
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.textLabel.text = self.blockTitles[indexPath.row];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 2) {
        JJTBlockStyleViewController *styleVC = [JJTBlockStyleViewController new];
        [self.navigationController pushViewController:styleVC animated:YES];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section > 1) {
        return nil;
    }
    
    return self.sectionTitles[section];
}

@end
