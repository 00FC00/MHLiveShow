//
//  MHLiveShowController.m
//  MHLiveShow
//
//  Created by CoderMikeHe on 17/2/24.
//  Copyright © 2017年 CoderMikeHe. All rights reserved.
//

#import "MHLiveShowController.h"
#import "MHLiveShow.h"
#import "MHLiveShowView.h"


@interface MHLiveShowController ()

/** 模块 */
@property (nonatomic , strong) NSMutableArray *liveShows;



@end

@implementation MHLiveShowController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 初始化
    [self _setup];
    
    // 初始化导航栏
    [self _setupNavigationItem];
    
    // 初始化子控件
    [self _setupSubViews];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    
}

#pragma mark - Getter
- (NSMutableArray *)liveShows
{
    if (_liveShows == nil) {
        _liveShows = [[NSMutableArray alloc] init];
    
        // 喵播
        MHLiveShow *miaoBo = [MHLiveShow liveShowWithAppIconName:@"mb_miaobo_70x70_" title:@"喵播" type:MHLiveShowTypeMiaoBo];
        [_liveShows addObject:miaoBo];
        
 
        
    }
    return _liveShows;
}

#pragma mark - 初始化
- (void)_setup
{
    
}

#pragma mark - 初始化导航栏
- (void)_setupNavigationItem
{
    self.title = @"LiveShow";
}

#pragma mark - 初始化子控件
- (void)_setupSubViews
{
    CGFloat w = 70.0f;
    CGFloat h = 100.0f;
    CGFloat topInset = 84.0f;
    NSUInteger maxColumn = 3;
    CGFloat margin = (MHMainScreenWidth - maxColumn*w)/(maxColumn*2);
    NSInteger count = self.liveShows.count;
    for (NSInteger i = 0; i < count; i++) {
        
        MHLiveShowView *liveShowView = [MHLiveShowView liveShowView];
        liveShowView.liveShow = self.liveShows[i];
        // 添加事件
        [liveShowView addTarget:self action:@selector(_liveShowViewDidClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:liveShowView];
        // 布局
        CGFloat liveShowViewX = margin+(w+2*margin)*(i%maxColumn);
        CGFloat liveShowViewY = topInset+(h+margin)*(i/maxColumn);
        CGFloat liveShowViewW = w;
        CGFloat liveShowViewH = h;
        
        liveShowView.frame = CGRectMake(liveShowViewX, liveShowViewY, liveShowViewW, liveShowViewH);
        
        
    }
}

#pragma mark - 事件处理
- (void)_liveShowViewDidClicked:(MHLiveShowView *)liveShowView
{
    // 发出通知
    [MHNotificationCenter postNotificationName:MHLiveShowViewDidTransmitDataNotification object:nil userInfo:@{MHLiveShowViewDidTransmitDatadKey:@(liveShowView.liveShow.type)}];
}


@end
