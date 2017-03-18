//
//  MBSquareController.m
//  MHLiveShow
//
//  Created by CoderMikeHe on 2017/3/17.
//  Copyright © 2017年 CoderMikeHe. All rights reserved.
//

#import "MBSquareController.h"
// M

// V
#import "MBSquareTitleButton.h"
// C





@interface MBSquareController ()

@end

@implementation MBSquareController

- (void)dealloc
{
    MHDealloc;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 初始化
    [self _setup];
    
    // 设置导航栏
    [self _setupNavigationItem];
    
    // 设置子控件
    [self _setupSubViews];
    
    // 监听通知中心
    [self _addNotificationCenter];
    
}
#pragma mark - 公共方法


#pragma mark - 私有方法

#pragma mark - 初始化
- (void)_setup
{
    
}

#pragma mark - 设置导航栏
- (void)_setupNavigationItem
{
    // 设置titleView
    MBSquareTitleButton *titleButton = [[MBSquareTitleButton alloc] init];
    [titleButton setTitle:@"广场" forState:UIControlStateNormal];
    [titleButton setImage:MHImageNamed(@"mb_hot_down_13x8_") forState:UIControlStateNormal];
    titleButton.mh_width = [@"广场" mh_sizeWithFont:titleButton.titleLabel.font].width+15.0f;
    titleButton.mh_height = 35.0f;
    [titleButton addTarget:self action:@selector(_titleButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = titleButton;
}

#pragma mark - 设置子控件
- (void)_setupSubViews
{
    
}

#pragma mark - 添加通知中心
- (void)_addNotificationCenter
{
    
}


#pragma mark - 事件处理
- (void)_titleButtonDidClicked:(MBSquareTitleButton *)sender
{
    sender.selected = !sender.isSelected;

    
}
@end
