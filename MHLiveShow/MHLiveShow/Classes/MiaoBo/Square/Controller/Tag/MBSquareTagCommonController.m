//
//  MBSquareTagCommonController.m
//  MHLiveShow
//
//  Created by apple on 2017/3/24.
//  Copyright © 2017年 CoderMikeHe. All rights reserved.
//

#import "MBSquareTagCommonController.h"
#import "MJRefresh.h"


@interface MBSquareTagCommonController ()<UITableViewDelegate , UITableViewDataSource>

/** tableView */
@property (nonatomic , weak) UITableView *tableView;

@end

@implementation MBSquareTagCommonController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化
    [self _setup];
    
    // 初始化子控件
    [self _setupSubViews];
    
}

#pragma mark - 初始化
- (void)_setup
{
    
}


#pragma mark - 设置子控件
- (void)_setupSubViews
{
    // 初始化tableView
    [self _setupTableView];
    
    // 初始化刷新控件
    [self _setupRefresh];
    
}

// 初始化TableView
- (void)_setupTableView
{
    // 设置内边距
    CGFloat bottom = self.tabBarController.tabBar.mh_height;
    CGFloat top = MHTitileContentViewY + MHTitileContentViewH;
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.backgroundColor = [UIColor clearColor];
    self.tableView = tableView;
    [self.view addSubview:tableView];
    
    
}

// 初始化刷新控件
- (void)_setupRefresh
{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(_loadNewTopics)];
    // 自动改变透明度
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(_loadMoreTopics)];
    
    
}


#pragma mark - 事件处理
- (void)_loadNewTopics
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.25f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self.tableView.mj_header endRefreshing];
        
    });
}

- (void)_loadMoreTopics
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.25f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self.tableView.mj_footer endRefreshing];
        
    });
}
#pragma mark - UITableViewDelegate&UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 100;
}


- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"topicCellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@ **  %zd" , self.title , indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}




@end
