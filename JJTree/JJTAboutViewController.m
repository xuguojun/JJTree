//
//  JJTAboutViewController.m
//  JJTree
//
//  Created by guojun on 8/1/15.
//  Copyright (c) 2015 guojunxu. All rights reserved.
//

#import "JJTAboutViewController.h"
#import "JJTRoleTableViewCell.h"
#import "UIColor+JJTColor.h"
#import <MWPhotoBrowser.h>

static NSString *ABOUT_JJTREE = @"元机经是一个程序员们记录和分享编程开发知识点和解决方案的平台。\n\n它不是问答社区，也不是发表文章的平台，它专注于记录某个具体而客观的知识点或解决方案。\n\n如果你愿意，我们鼓励你将个人编写的机经分享至互联网，以为其他网友提供方便。与此同时，你也可能收获网友们打赏的金钱或其他回报。\n\n用户在使用元机经平台的过程中将被分配为以下3种角色：";

@interface JJTAboutViewController ()<UITableViewDataSource, UITableViewDelegate, MWPhotoBrowserDelegate>

@property (nonatomic, weak) IBOutlet UITableView *aboutTableView;

@property (nonatomic, strong) UIBarButtonItem *videoButton;

@property (nonatomic, strong) JJTRoleTableViewCell *cell1;
@property (nonatomic, strong) JJTRoleTableViewCell *cell2;
@property (nonatomic, strong) JJTRoleTableViewCell *cell3;

@property (nonatomic, strong) NSArray *videos;

@end

@implementation JJTAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"关于元机经";
    self.navigationItem.rightBarButtonItem = self.videoButton;
    
    MWPhoto *video = [MWPhoto photoWithImage:[UIImage imageNamed:@"demo.png"]];
    
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *path = [bundle pathForResource:@"iPadDemo" ofType:@"m4v"];
    NSURL *url = [NSURL fileURLWithPath:path];
    video.videoURL = url;
    
    self.videos = @[video];
}

- (NSString *)version{
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle]infoDictionary];
    NSString *version = infoDictionary[@"CFBundleShortVersionString"];
    version = [NSString stringWithFormat:@"元机经 Version %@", version];
    
    return version;
}

- (void)videoButtonDidPress:(id)sender{
    
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] init];
    browser.delegate = self;
    
    // Set options
    browser.displayActionButton = NO; // Show action button to allow sharing, copying, etc (defaults to YES)
    browser.displayNavArrows = YES; // Whether to display left and right nav arrows on toolbar (defaults to NO)
    browser.displaySelectionButtons = NO; // Whether selection buttons are shown on each image (defaults to NO)
    browser.zoomPhotosToFill = YES; // Images that almost fill the screen will be initially zoomed to fill (defaults to YES)
    browser.alwaysShowControls = NO; // Allows to control whether the bars and controls are always visible or whether they fade away to show the photo full (defaults to NO)
    browser.enableGrid = YES; // Whether to allow the viewing of all the photo thumbnails on a grid (defaults to YES)
    browser.startOnGrid = NO; // Whether to start on the grid of thumbnails instead of the first photo (defaults to NO)
    browser.autoPlayOnAppear = YES; // Auto-play first video
    
    // Present
    [self.navigationController pushViewController:browser animated:YES];
}

#pragma mark - MWPhotoBrowserDelegate
- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser{
    return 1;
}

- (id<MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index{
    return self.videos[index];
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
    
    CGFloat margin = 48.f;
    if (indexPath.row == 0) {
        return margin + self.cell1.roleLabelSize.height;
    }
    
    if (indexPath.row == 1) {
        return margin + self.cell2.roleLabelSize.height;
    }
    
    if (indexPath.row == 2) {
        return margin + self.cell3.roleLabelSize.height;
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

#pragma mark - Getters & Setters

- (UIBarButtonItem *)videoButton{
    if (!_videoButton) {
        
        UIImage *image = [UIImage imageNamed:@"video"];
        
        UIButton *button = [[UIButton alloc] init];
        
        [button setFrame:CGRectMake(0, 0, 26, 18)];
        [button setImage:[image imageWithRenderingMode:(UIImageRenderingModeAlwaysTemplate)]
                forState:UIControlStateNormal];
//        [button setTintColor:UIColorFromRGB(0xE8A433)];
        [button addTarget:self action:@selector(videoButtonDidPress:) forControlEvents:UIControlEventTouchUpInside];
        
        _videoButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    }
    
    return _videoButton;
}

@end
