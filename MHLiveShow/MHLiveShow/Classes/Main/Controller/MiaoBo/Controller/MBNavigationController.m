//
//  MBNavigationController.m
//  MHLiveShow
//
//  Created by CoderMikeHe on 2017/3/16.
//  Copyright © 2017年 CoderMikeHe. All rights reserved.
//

#import "MBNavigationController.h"

#import "UIBarButtonItem+MHExtension.h"


@interface MBNavigationController ()
/**
 * 导航栏分隔线
 */
@property (nonatomic , weak) UIImageView * navSystemLine;

@end


@implementation MBNavigationController

// 第一次使用这个类调用一次
+ (void)initialize
{
    // 2.设置UINavigationBarTheme的主
    [self _setupNavigationBarTheme];
    
    // 3.设置UIBarButtonItem的主题
    [self _setupBarButtonItemTheme];
    
    // 4.设置状态栏样式
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}



#pragma mark - 初始化
- (void) _setup
{
    // 渲染导航栏的颜色
    self.navigationBar.tintColor = MHGlobalLightRedColor;
    
}

// 查询最后一条数据
- (UIImageView *)_findHairlineImageViewUnder:(UIView *)view
{
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews)
    {
        UIImageView *imageView = [self _findHairlineImageViewUnder:subview];
        if (imageView)
        {
            return imageView;
        }
    }
    return nil;
}

#pragma mark - 设置导航栏的分割线
- (void)_setupNavigationBarBottomLine
{
    //!!!:这里之前设置系统的 navigationBarBottomLine.image = xxx;无效 Why？ 隐藏了系统的 自己添加了一个分割线
    // 隐藏系统的导航栏分割线
    UIImageView *navigationBarBottomLine = [self _findHairlineImageViewUnder:self.navigationBar];
    navigationBarBottomLine.hidden = YES;
    
    // 添加自己的分割线
    CGFloat navSystemLineH = 1.0f;
    UIImageView *navSystemLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.navigationBar.mh_height - navSystemLineH, MHMainScreenWidth, navSystemLineH)];
    navSystemLine.backgroundColor = MHGlobalBottomLineColor;
    [self.navigationBar addSubview:navSystemLine];
    
    self.navSystemLine = navSystemLine;
}

/**
 *  设置UINavigationBarTheme的主题
 */
+ (void) _setupNavigationBarTheme
{
    UINavigationBar *appearance = [UINavigationBar appearance];
    
    //!!!: 必须设置为透明  不然布局有问题 ios8以下  会崩溃/ 如果iOS8以下  请再_setup里面 设置透明 self.navigationBar.translucent = YES;
    [appearance setTranslucent:YES];
    
    // 设置导航栏的样式
    [appearance setBarStyle:UIBarStyleDefault];
    
    //设置导航栏文字按钮的渲染色
    [appearance setTintColor:[UIColor whiteColor]];
    
    // 设置导航栏的背景渲染色
    [appearance setBarTintColor:MHGlobalLightRedColor];
    
    // 设置背景图片
    [appearance setBackgroundImage:MHImageNamed(@"mb_head_bg_375x64_") forBarMetrics:UIBarMetricsDefault];
    
    //
    // 设置文字属性
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:MHPxConvertPt(17.0f)];
    textAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    // UIOffsetZero是结构体, 只要包装成NSValue对象, 才能放进字典\数组中
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowOffset =  CGSizeZero;
    textAttrs[NSShadowAttributeName] = shadow;
    [appearance setTitleTextAttributes:textAttrs];
    
}

/**
 *  设置UIBarButtonItem的主题
 */
+ (void)_setupBarButtonItemTheme
{
    // 通过appearance对象能修改整个项目中所有UIBarButtonItem的样式
    UIBarButtonItem *appearance = [UIBarButtonItem appearance];
    
    CGFloat fontSize = MHPxConvertPt(14.0f);
    
    /**设置文字属性**/
    // 设置普通状态的文字属性
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:fontSize];
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowOffset =  CGSizeZero;
    textAttrs[NSShadowAttributeName] = shadow;
    [appearance setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    
    // 设置高亮状态的文字属性
    NSMutableDictionary *highTextAttrs = [NSMutableDictionary dictionaryWithDictionary:textAttrs];
    highTextAttrs[NSForegroundColorAttributeName] = MHColorFromHexString(@"#eeeeee");
    [appearance setTitleTextAttributes:highTextAttrs forState:UIControlStateHighlighted];
    
    // 设置不可用状态(disable)的文字属性
    NSMutableDictionary *disableTextAttrs = [NSMutableDictionary dictionaryWithDictionary:textAttrs];
    disableTextAttrs[NSForegroundColorAttributeName] = MHGlobalGrayTextColor;
    [appearance setTitleTextAttributes:disableTextAttrs forState:UIControlStateDisabled];
    
    /**设置背景**/
    // 技巧: 为了让某个按钮的背景消失, 可以设置一张完全透明的背景图片
    //    [appearance setBackgroundImage:[UIImage imageWithName:@"navigationbar_button_background"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
}




/**
 *  能拦截所有push进来的子控制器
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    // 如果现在push的不是栈底控制器(最先push进来的那个控制器)
    if (self.viewControllers.count > 0)
        
    {
        viewController.hidesBottomBarWhenPushed = YES;
        
        UIBarButtonItem *backItem = [UIBarButtonItem mh_itemWithImageName:@"mb_back_9x16_" target:self action:@selector(_back)];
        //这里可以设置导航栏的左右按钮 统一管理方法
        viewController.navigationItem.leftBarButtonItem = backItem;
    }
    
    // 解决ios7自带的手滑手势引发的崩溃
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    
    // push
    [super pushViewController:viewController animated:animated];
}


- (void)_back
{
    [self popViewControllerAnimated:YES];
}


- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
@end
