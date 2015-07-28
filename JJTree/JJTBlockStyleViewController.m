//
//  JJTBlockStyleViewController.m
//  JJTree
//
//  Created by guojun on 7/28/15.
//  Copyright (c) 2015 guojunxu. All rights reserved.
//

#import "JJTBlockStyleViewController.h"
#import "NSString+JJTString.h"

@interface JJTBlockStyleViewController ()

@property (nonatomic, weak) IBOutlet UITableView *stylesTableView;
@property (nonatomic, strong) NSArray *styles;

@end

@implementation JJTBlockStyleViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"代码块CSS样式";

    NSString *content = [self readFile];
    self.styles = [content splitByNewLine];
}

- (NSString *)readFile{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"blockCSS"
                                                     ofType:@"txt"];
    NSString *content = [NSString stringWithContentsOfFile:path
                                                  encoding:NSUTF8StringEncoding
                                                     error:NULL];
    
    return content;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.styles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"cellIdentifier";
    
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:cellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    
    cell.textLabel.text = self.styles[indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

@end
