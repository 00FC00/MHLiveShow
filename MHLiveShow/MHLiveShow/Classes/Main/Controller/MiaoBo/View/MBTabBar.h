//
//  MBTabBar.h
//  MHLiveShow
//
//  Created by CoderMikeHe on 2017/3/17.
//  Copyright © 2017年 CoderMikeHe. All rights reserved.
//  喵播的TabBar

#import <UIKit/UIKit.h>

@class MBTabBar;
@protocol MBTabBarDelegate <NSObject>

@optional

/**
 点击tabBar上的按钮 切换不同的控制器

 @param tabBar tabBar
 @param index 索引
 */
- (void)tabBar:(MBTabBar *)tabBar didClickedBtn:(NSInteger)index;

/**
 点击tabBar上的直播按钮
 */
- (void)tabBarDidClickedLiveButton:(MBTabBar *)tabBar;

@end

@interface MBTabBar : UIView
// 模型数组(UITabBarItem)
@property (nonatomic, strong) NSArray *items;

@property (nonatomic, weak) id<MBTabBarDelegate> delegate;
@end
