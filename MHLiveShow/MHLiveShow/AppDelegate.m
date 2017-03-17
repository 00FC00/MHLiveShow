//
//  AppDelegate.m
//  MHLiveShow
//
//  Created by CoderMikeHe on 17/2/24.
//  Copyright © 2017年 CoderMikeHe. All rights reserved.
//

#import "AppDelegate.h"
// 程序启动的主控制器
#import "MHLiveShowController.h"
#import "MHNavigationController.h"
// 喵播主控制器
#import "MBTabBarController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    // 显示状态栏
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    
    // 创建window
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    // 设置颜色
    self.window.backgroundColor = [UIColor whiteColor];
    
    // 设置根控制器
    MHLiveShowController *liveShow = [[MHLiveShowController alloc] init];
    MHNavigationController *rootViewController = [[MHNavigationController alloc] initWithRootViewController:liveShow];
    self.window.rootViewController = rootViewController;
    
    // 设置窗口可见
    [self.window makeKeyAndVisible];
    
    // 添加通知中心
    [self _addNotificationCenter];
    
    return YES;

}


#pragma mark - 添加通知中心
- (void)_addNotificationCenter
{
    // 收到通知
    [MHNotificationCenter addObserver:self selector:@selector(_didTransmitData:) name:MHLiveShowViewDidTransmitDataNotification object:nil];
}

// 事件处理
- (void)_didTransmitData:(NSNotification *)note
{
    MHLiveShowType type = [note.userInfo[MHLiveShowViewDidTransmitDatadKey] integerValue];
    
    switch (type) {
        case MHLiveShowTypeMiaoBo:
        {
            // 喵播
            MBTabBarController *rootViewController = [[MBTabBarController alloc] init];
            self.window.rootViewController = rootViewController;
        }
            break;
            
        default:
            break;
    }
}







- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
