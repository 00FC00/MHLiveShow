//
//  MBTabBarController.m
//  MHLiveShow
//
//  Created by CoderMikeHe on 2017/3/16.
//  Copyright © 2017年 CoderMikeHe. All rights reserved.
//

#import "MBTabBarController.h"
#import "MBNavigationController.h"
#import "MBProfileController.h"
#import "MBSquareController.h"

#import "MBTabBar.h"


@interface MBTabBarController ()<MBTabBarDelegate>

// 保存所有控制器对应按钮的内容（UITabBarItem）
@property (nonatomic, strong) NSMutableArray *items;

@end

@implementation MBTabBarController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 把系统的tabBar上的按钮干掉
    for (UIView *childView in self.tabBar.subviews) {
        if (![childView isKindOfClass:[MBTabBar class]]) {
            [childView removeFromSuperview];
        }
    }
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 初始化所有的子控制器
    [self _setupAllChildViewControlles];
    
    // 初始化tabBar
    [self _setUpTabBar];

    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Getter
- (NSMutableArray *)items
{
    if (_items == nil) {
        _items = [[NSMutableArray alloc] init];
    }
    return _items;
}

#pragma mark - 初始化所有的控制器
- (void)_setupAllChildViewControlles
{
    // 广场
    MBSquareController *square = [[MBSquareController alloc] init];
    [self _setupOneChildViewController:square image:MHImageNamed(@"mb_toolbar_home_26x26_") selImage:MHImageNamed(@"mb_toolbar_home_sel_44x44_") title:@"广场"];
    
    // Profile
    MBProfileController *profile = [[MBProfileController alloc] init];
    [self _setupOneChildViewController:profile image:MHImageNamed(@"mb_toolbar_me_44x44_") selImage:MHImageNamed(@"mb_toolbar_me_sel_44x44_") title:@"我的"];
}

#pragma mark - 初始化导航栏
- (void)_setUpTabBar
{
    MBTabBar *tabBar = [[MBTabBar alloc] init];
    
    // 存储UITabBarItem
    tabBar.items = self.items;
    tabBar.delegate = self;
    tabBar.frame = self.tabBar.bounds;
    [self.tabBar addSubview:tabBar];
}

#pragma mark - 辅助方法
// 初始化一个控制器
- (void)_setupOneChildViewController:(UIViewController *)vc image:(UIImage *)image selImage:(UIImage *)selImage title:(NSString *)title
{
    vc.navigationItem.title = title;
    
    // 描述对应按钮的内容
    vc.tabBarItem.image = image;
    vc.tabBarItem.selectedImage = selImage;
    
    // 记录所有控制器对应按钮的内容
    [self.items addObject:vc.tabBarItem];
    
    // 把控制器包装成导航控制器
    UINavigationController *nav = [[MBNavigationController alloc] initWithRootViewController:vc];
    
    // 如果要设置背景图片，必须填UIBarMetricsDefault,默认导航控制器的子控制器的view尺寸会变化。
    // 设置导航条背景图片，一定要在导航条显示之前设置
    //    [nav.navigationBar setBackgroundImage:[UIImage imageNamed:@""] forBarMetrics:UIBarMetricsDefault];
    
    [self addChildViewController:nav];
}

#pragma mark - MBTabBarDelegate
- (void)tabBar:(MBTabBar *)tabBar didClickedBtn:(NSInteger)index
{
    self.selectedIndex = index;
}

- (void)tabBarDidClickedLiveButton:(MBTabBar *)tabBar
{
    //
    MHLogFunc;
}

@end
