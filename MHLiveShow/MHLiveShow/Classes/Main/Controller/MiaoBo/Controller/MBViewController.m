//
//  MBViewController.m
//  MHLiveShow
//
//  Created by CoderMikeHe on 2017/3/16.
//  Copyright © 2017年 CoderMikeHe. All rights reserved.
//

#import "MBViewController.h"

@interface MBViewController ()

@end

@implementation MBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 如果是导航控制器包裹的 这个代码不会执行
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
