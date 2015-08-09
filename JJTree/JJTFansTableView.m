//
//  JJTFansTableView.m
//  JJTree
//
//  Created by guojun on 8/9/15.
//  Copyright (c) 2015 guojunxu. All rights reserved.
//

#import "JJTFansTableView.h"
#import "JJTFansTableViewCell.h"

@interface JJTFansTableView()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) IBOutlet UITableView *fansTableView;

@end
@implementation JJTFansTableView

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        
        [self loadView];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self loadView];
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

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.fans.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"cellIdentifier";
    
    JJTFansTableViewCell *cell = (JJTFansTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = [[JJTFansTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                      reuseIdentifier:cellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    cell.fan = self.fans[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
 
    if ([self.delegate respondsToSelector:@selector(fansTableView:didSelectRowAtIndex:)]) {
        [self.delegate fansTableView:self didSelectRowAtIndex:indexPath.row];
    }
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55.f;
}

#pragma mark - Getters & Setters
- (void)setFans:(NSArray *)fans{
    if (_fans != fans) {
        _fans = fans;
        
        [self.fansTableView reloadData];
    }
}
@end
