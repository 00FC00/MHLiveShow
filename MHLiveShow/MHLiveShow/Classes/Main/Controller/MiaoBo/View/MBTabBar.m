//
//  MBTabBar.m
//  MHLiveShow
//
//  Created by CoderMikeHe on 2017/3/17.
//  Copyright © 2017年 CoderMikeHe. All rights reserved.
//

#import "MBTabBar.h"
// 仿UITabBar
#import "MBTabBarButton.h"

static NSString * const MBScaleAnimation = @"MBScaleAnimation";


@interface MBTabBar ()

// 选中按钮
@property (nonatomic, weak) MBTabBarButton *selButton;

// 选中按钮
@property (nonatomic, weak) MBTabBarButton *liveButton;

@end

@implementation MBTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        // 初始化
        [self _setup];
        
        // 初始化直播按钮
        [self _setupLiveButton];
        
    }
    return self;
}


#pragma mark - Setter
- (void)setItems:(NSArray *)items
{
    _items = items;
    
    // UITabBarItem保存按钮上的图片
    NSInteger tag = 0;
    for (UITabBarItem *item in items) {
        
        MBTabBarButton *btn = [MBTabBarButton buttonWithType:UIButtonTypeCustom];
        
        btn.tag = tag;
        
        [btn setImage:item.image forState:UIControlStateNormal];
        
        [btn setImage:item.selectedImage forState:UIControlStateSelected];
        
        [btn addTarget:self action:@selector(_btnDidClicked:) forControlEvents:UIControlEventTouchDown];
        
        [self addSubview:btn];
        
        if (tag == 0) {
            // 默认选中第一个
            [self _btnDidClicked:btn];
        }
        
        tag+=1;
    }
    
}

#pragma mark - 初始化
- (void)_setup
{
    
    
}

#pragma mark - 初始化直播按钮
- (void)_setupLiveButton
{
    MBTabBarButton *liveButton = [MBTabBarButton buttonWithType:UIButtonTypeCustom];
    
    [liveButton setImage:MHImageNamed(@"mb_toolbar_live_42x42_") forState:UIControlStateNormal];
    
    [liveButton addTarget:self action:@selector(_liveButtonDidClicked:) forControlEvents:UIControlEventTouchDown];
    
    [self addSubview:liveButton];
    
    self.liveButton = liveButton;
}




#pragma mark - 点击事件处理
- (void)_btnDidClicked:(MBTabBarButton *)sender
{
    if (_selButton) {
        // 去掉首次加载的动画
        [self _addAnimationWithButton:sender];
    }
    _selButton.selected = NO;
    
    sender.selected = YES;
    
    _selButton = sender;
    
    // 通知tabBarVc切换控制器
    if (self.delegate && [self.delegate respondsToSelector:@selector(tabBar:didClickedBtn:)]) {
        [_delegate tabBar:self didClickedBtn:sender.tag];
    }
}

// 直播按钮被点击
- (void)_liveButtonDidClicked:(MBTabBarButton *)sender
{
    // 添加动画
    [self _addAnimationWithButton:sender];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(tabBarDidClickedLiveButton:)]) {
        [self.delegate tabBarDidClickedLiveButton:self];
    }
}

#pragma mark - 辅助方法
- (void)_addAnimationWithButton:(MBTabBarButton *)sender
{
    // 移除动画
    [sender pop_removeAnimationForKey:MBScaleAnimation];
    
    // 执行动画点击 先缩小再还原
    POPSpringAnimation *anim2 = [POPSpringAnimation animationWithPropertyNamed:kPOPViewScaleXY];
    anim2.fromValue = [NSValue valueWithCGPoint:CGPointMake(0.6f, 0.6f)];
    anim2.toValue = [NSValue valueWithCGPoint:CGPointMake(1.f, 1.f)];
    anim2.springBounciness = 20;
    anim2.springSpeed = 20;
    [sender pop_addAnimation:anim2 forKey:MBScaleAnimation];
}


#pragma mark - 布局子控件
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 布局子控件
    NSInteger count = self.subviews.count;

    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = [UIScreen mainScreen].bounds.size.width / count;
    
    CGFloat h = self.frame.size.height;
    
    for (MBTabBarButton *btn in self.subviews) {
    
        if (btn == self.liveButton) {
            btn.frame = CGRectMake(0, y, w, h);
            btn.mh_centerX = self.mh_centerX;
        }else{
            x = btn.tag * 2 * w;
            btn.frame = CGRectMake(x, y, w, h);
        }
    }
}


@end
