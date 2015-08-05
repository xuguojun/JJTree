//
//  JJTPreferenceViewController.m
//  JJTree
//
//  Created by guojun on 7/27/15.
//  Copyright (c) 2015 guojunxu. All rights reserved.
//

#import "JJTPreferenceViewController.h"
#import "JJTBlockStyleViewController.h"
#import "NSString+JJTString.h"

@interface JJTPreferenceViewController ()<UITableViewDataSource, UITableViewDelegate, JJTBlockStyleViewControllerDelegate>

@property (nonatomic, weak) IBOutlet UITableView *prefrenceTableView;

@property (nonatomic, strong) NSArray *sectionTitles;
@property (nonatomic, strong) NSArray *topTitles;
@property (nonatomic, strong) NSArray *recentTitles;
@property (nonatomic, strong) NSArray *blockTitles;

@property (nonatomic, assign) BOOL arrangeByUseful;
@property (nonatomic, assign) BOOL arrangeByPublishDate;

@end

@implementation JJTPreferenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"偏好设置";

    self.topTitles = @[@"按👍(亲测有用)高低", @"按💰(获得打赏金额)高低"];
    self.recentTitles = @[@"按发布日期先后", @"按更新日期先后"];
    self.sectionTitles = @[@"TOP机经排序原则", @"最新机经排序原则"];
    self.blockTitles = @[@"代码块CSS样式"];
    
    self.arrangeByUseful = ![self arrangeByUseless];
    self.arrangeByPublishDate = ![self arrangeByUpdateDate];
}

#pragma mark - Private Methods
- (BOOL)arrangeByUseless{
    return [self.prefs boolForKey:ARRANGE_BY_USELESS_VALUE];
}

- (BOOL)arrangeByUpdateDate{
    return [self.prefs boolForKey:ARRANGE_BY_UPDATE_DATE];
}

- (NSString *)readFile{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"blockCSS"
                                                     ofType:@"txt"];
    NSString *content = [NSString stringWithContentsOfFile:path
                                                  encoding:NSUTF8StringEncoding
                                                     error:NULL];
    
    return content;
}

- (NSArray *)css{
    return [[self readFile] splitByNewLine];
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
        
        if (indexPath.row == 0) {
            if (self.arrangeByUseful) {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            } else {
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
        } else if (indexPath.row == 1){
            if (self.arrangeByUseful) {
                cell.accessoryType = UITableViewCellAccessoryNone;
            } else {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }
        }
    } else if (indexPath.section == 1){
        cell.textLabel.text = self.recentTitles[indexPath.row];
        
        if (indexPath.row == 0) {
            if (self.arrangeByPublishDate) {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            } else {
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
        } else if (indexPath.row == 1){
            if (self.arrangeByPublishDate) {
                cell.accessoryType = UITableViewCellAccessoryNone;
            } else {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }
        }
    } else {
        cell.textLabel.text = self.blockTitles[indexPath.row];
        
        NSInteger index = [self.prefs integerForKey:BLOCK_STYLE_INDEX];
        cell.detailTextLabel.text = [self css][index];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            self.arrangeByUseful = YES;
            [self.prefs setBool:NO forKey:ARRANGE_BY_USELESS_VALUE];
        } else {
            self.arrangeByUseful = NO;
            [self.prefs setBool:YES forKey:ARRANGE_BY_USELESS_VALUE];
        }
        
        [tableView reloadData];
    }
    
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            self.arrangeByPublishDate = YES;
            [self.prefs setBool:NO forKey:ARRANGE_BY_UPDATE_DATE];
        } else {
            self.arrangeByPublishDate = NO;
            [self.prefs setBool:YES forKey:ARRANGE_BY_UPDATE_DATE];
        }
        
        [tableView reloadData];
    }
    
    if (indexPath.section == 2) {
        JJTBlockStyleViewController *styleVC = [JJTBlockStyleViewController new];
        styleVC.delegate = self;
        [self.navigationController pushViewController:styleVC animated:YES];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section > 1) {
        return nil;
    }
    
    return self.sectionTitles[section];
}

#pragma mark - JJTBlockStyleViewControllerDelegate
- (void)blockStyleViewController:(JJTBlockStyleViewController *)controller didSelectRowAtIndex:(NSInteger)index{
    
    NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:2];
    [self.prefrenceTableView reloadSections:indexSet withRowAnimation:(UITableViewRowAnimationAutomatic)];
}

#pragma mark - Getters & Setters

@end
