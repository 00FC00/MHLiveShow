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
#import "MBSquareMoreTagView.h"
// C
#import "MBSquareTagCommonController.h"
#import "MBSearchController.h"
#import "MBRankController.h"



@interface MBSquareController ()<UIScrollViewDelegate>

/** 标签栏View */
@property (nonatomic, weak) UIView *titleContentView;

/** 顶部的所有标签 */
@property (nonatomic, weak) UIScrollView *titlesView;

/** 指示器 */
@property (nonatomic , weak) UIView *indicatorView;


/** 底部的所有内容 */
@property (nonatomic, weak) UIScrollView *contentView;


/** 当前选中的按钮 */
@property (nonatomic , weak) UIButton *selectedButton;


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
    
    // 初始化子控制器
    [self _setupChildController];
    
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
    // 不要自动调整inset
    self.automaticallyAdjustsScrollViewInsets = NO;
}

#pragma mark - 设置子控制器
- (void)_setupChildController
{
    MBSquareTagCommonController *hot = [[MBSquareTagCommonController alloc] init];
    hot.title = @"热门";
    hot.squareTag = MBSquareTagHot;
    [self addChildViewController:hot];
    
    MBSquareTagCommonController *goodVoice = [[MBSquareTagCommonController alloc] init];
    goodVoice.title = @"好声音";
    goodVoice.squareTag = MBSquareTagGoodVoice;
    [self addChildViewController:goodVoice];
    
    MBSquareTagCommonController *nearBy = [[MBSquareTagCommonController alloc] init];
    nearBy.title = @"附近";
    [self addChildViewController:nearBy];
    
    MBSquareTagCommonController *since = [[MBSquareTagCommonController alloc] init];
    since.squareTag = MBSquareTagOfficial;
    since.title = @"最新";
    [self addChildViewController:since];
    
    
    
    MBSquareTagCommonController *oversea = [[MBSquareTagCommonController alloc] init];
    oversea.title = @"海外";
    oversea.squareTag = MBSquareTagOverseas;
    [self addChildViewController:oversea];
    
    MBSquareTagCommonController *official = [[MBSquareTagCommonController alloc] init];
    official.squareTag = MBSquareTagOfficial;
    official.title = @"官方";
    [self addChildViewController:official];
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
    
    
    // 设置左侧搜索item
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:MHImageNamed(@"mb_search_head_24x24_") style:UIBarButtonItemStylePlain target:self action:@selector(_searchInfo)];
    
    // 设置右侧排行item
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:MHImageNamed(@"mb_head_crown_24x24_") style:UIBarButtonItemStylePlain target:self action:@selector(_rankForApp)];
}

#pragma mark - 设置子控件
- (void)_setupSubViews
{
    // 设置标签栏
    [self _setupTitleContentView];
    
    // 设置内容视图
    [self _setupContentView];
}

/**
 * 设置顶部的标签栏
 */
- (void)_setupTitleContentView
{
    // title内容View
    UIView *titleContentView = [[UIView alloc] initWithFrame:CGRectMake(0, MHTitileContentViewY, self.view.mh_width, MHTitileContentViewH)];
    titleContentView.backgroundColor = MHGlobalWhiteTextColor;
    self.titleContentView = titleContentView;
    [self.view addSubview:titleContentView];
    
    
    CGFloat dividerH = 1.5;
    // 设置分割线
    UIView *divider = [[UIView alloc] initWithFrame:CGRectMake(0, titleContentView.mh_height-dividerH, self.titleContentView.mh_width, dividerH)];
    divider.backgroundColor = MHColor(229.0f, 229.0f, 229.0f);
    [self.titleContentView addSubview:divider];
    
    CGFloat moreBtnW= 44.0f;
    
    // 标签栏title整体
    UIScrollView *titlesView = [[UIScrollView alloc] init];
    titlesView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    titlesView.mh_width = titleContentView.mh_width -  moreBtnW;
    titlesView.mh_height = titleContentView.mh_height-dividerH;
    titlesView.showsHorizontalScrollIndicator = NO;
    titlesView.showsVerticalScrollIndicator = NO;
    [titleContentView addSubview:titlesView];
    self.titlesView = titlesView;
    
    
    // 设置更多按钮
    UIButton *moreBtn = [[UIButton alloc] init];
    [moreBtn setImage:MHImageNamed(@"mb_home_more_15x14_") forState:UIControlStateNormal];
    moreBtn.mh_width = moreBtnW;
    moreBtn.mh_height = titleContentView.mh_height-dividerH;
    moreBtn.mh_x = titlesView.mh_width;
    [moreBtn addTarget:self action:@selector(_moreBtnDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    [titleContentView addSubview:moreBtn];
    
    // 设置TopicTitle
    [self _setupTitleContentViewSubviews];
}

- (void)_setupTitleContentViewSubviews
{
    // 底部的红色指示器
    UIView *indicatorView = [[UIView alloc] init];
    indicatorView.backgroundColor = MHGlobalLightRedColor;
    indicatorView.mh_height = 2;
    indicatorView.tag = -1;
    indicatorView.mh_y = self.titlesView.mh_height - indicatorView.mh_height;
    self.indicatorView = indicatorView;
    
    // 内部的子标签
    NSInteger count = self.childViewControllers.count;
    // 大于五显示五个半 小于5显示当前count
    CGFloat width = floor(self.titlesView.mh_width / (count>5?5.5:count));
    CGFloat height = self.titlesView.mh_height;
    
    // 创建标签
    for (NSInteger i = 0; i < count; i++) {
        UIButton *button = [[UIButton alloc] init];
        button.tag = i;
        button.mh_height = height;
        button.mh_width = width;
        button.mh_x = i * width;
        
        UIViewController *vc = self.childViewControllers[i];
        [button setTitle:vc.title forState:UIControlStateNormal];
        // 强制布局(强制更新子控件的frame)
        //[button layoutIfNeeded];
        [button setTitleColor:MHColor(151.0f, 82.0f, 114.0f) forState:UIControlStateNormal];
        [button setTitleColor:MHGlobalLightRedColor forState:UIControlStateDisabled];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button addTarget:self action:@selector(_titleClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.titlesView addSubview:button];
        
        // 默认点击了第一个按钮
        if (i == 0)
        {
            button.enabled = NO;
            self.selectedButton = button;
            // 让按钮内部的label根据文字内容来计算尺寸
            [button.titleLabel sizeToFit];
            self.indicatorView.mh_width = button.mh_width-10;
            self.indicatorView.mh_centerX = button.mh_centerX;
        }
    }
    
    // 添加指示器
    [self.titlesView addSubview:indicatorView];
    
    // 设置contentSize
    self.titlesView.contentSize = CGSizeMake(count * width, 0);
}

// 设置内容的scrollView
- (void)_setupContentView
{
    // 内容
    UIScrollView *contentView = [[UIScrollView alloc] init];
    contentView.showsHorizontalScrollIndicator = NO;
    contentView.frame = self.view.bounds;
    contentView.delegate = self;
    contentView.pagingEnabled = YES;
    [self.view insertSubview:contentView atIndex:0];
    contentView.contentSize = CGSizeMake(contentView.mh_width * self.childViewControllers.count, 0);
    self.contentView = contentView;
    
    // 添加label
    NSInteger count = self.childViewControllers.count;
    self.contentView.contentSize = CGSizeMake(count * [UIScreen mainScreen].bounds.size.width, 0);
    
    // 添加第一个控制器的view
    [self scrollViewDidEndScrollingAnimation:contentView];
}

#pragma mark - 添加通知中心
- (void)_addNotificationCenter
{
    //
}




#pragma mark - 事件处理
// 广场按钮被点击
- (void)_titleButtonDidClicked:(MBSquareTitleButton *)sender
{
    sender.selected = !sender.isSelected;
}

- (void)_moreBtnDidClicked:(UIButton *)sender
{
    // 显示更多View
    [self _showMoreTagView];
}



// 标签按钮点击事件
- (void)_titleClick:(UIButton *)button
{
    // 修改按钮状态
    self.selectedButton.enabled = YES;
    button.enabled = NO;
    self.selectedButton = button;
    
    // 动画
    [UIView animateWithDuration:0.25 animations:^{
        self.indicatorView.mh_centerX = button.mh_centerX;
    }];
    
    // 滚动
    CGPoint offset = self.contentView.contentOffset;
    offset.x = button.tag * self.contentView.mh_width;
    [self.contentView setContentOffset:offset animated:YES];
}

// 搜索
- (void)_searchInfo
{
    MBSearchController *search = [[MBSearchController alloc] init];
    [self.navigationController pushViewController:search animated:YES];
}

// 排名
- (void)_rankForApp
{
    MBRankController *rank = [[MBRankController alloc] init];
    [self.navigationController pushViewController:rank animated:YES];
}


#pragma mark - 显示和隐藏更多标签View
- (void)_showMoreTagView
{
    // 显示
    MBSquareMoreTagView *moreTagView = [[MBSquareMoreTagView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    moreTagView.mh_x = MHMainScreenWidth;
    // 切记这里要加在TabBarController或者keyWindow上。
    [self.tabBarController.view addSubview:moreTagView];
    
    // 动画
    [UIView animateWithDuration:.25f animations:^{
       
        moreTagView.transform = CGAffineTransformMakeTranslation(-1 *MHMainScreenWidth, .0);
        
    }];
}

- (void)_hideMoreTagView
{
    // 隐藏
}

#pragma mark - UIScrollViewDelegate
/**
 * 手指松开scrollView后，scrollView停止减速完毕就会调用这个
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
    
    // 点击按钮
    NSInteger index = scrollView.contentOffset.x / scrollView.mh_width;
    [self _titleClick:self.titlesView.subviews[index]];
}



/**
 * scrollView结束了滚动动画以后就会调用这个方法（比如- (void)setContentOffset:(CGPoint)contentOffset animated:(BOOL)animated;方法执行的动画完毕后）
 */
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    // 一些临时变量
    CGFloat width = scrollView.frame.size.width;
    CGFloat height = scrollView.frame.size.height;
    CGFloat offsetX = scrollView.contentOffset.x;
    
    // 当前位置需要显示的控制器的索引
    NSInteger index = offsetX / width;
    
    // 让对应的顶部标题居中显示
    UIButton *title = self.titlesView.subviews[index];
    CGPoint titleOffset = self.titlesView.contentOffset;
    titleOffset.x = title.center.x - self.titlesView.mh_width * 0.5;
    
    // 左边超出处理
    if (titleOffset.x < 0) titleOffset.x = 0;
    
    // 右边超出处理
    CGFloat maxTitleOffsetX = self.titlesView.contentSize.width - self.titlesView.mh_width;
    if (titleOffset.x > maxTitleOffsetX) titleOffset.x = maxTitleOffsetX;
    [self.titlesView setContentOffset:titleOffset animated:YES];
    
    // 取出子控制器
    UIViewController *willShowVc = self.childViewControllers[index];
    
    // 如果当前位置的位置已经显示过了，就直接返回，这里是小细节，其实同一个view被添加N次 == 添加一次
    if ([willShowVc isViewLoaded]) return;
    
    willShowVc.view.mh_x = scrollView.contentOffset.x;
    willShowVc.view.mh_y = 0; // 设置控制器view的y值为0(默认是20)
    willShowVc.view.mh_height = height; // 设置控制器view的height值为整个屏幕的高度(默认是比屏幕高度少个20)
    [scrollView addSubview:willShowVc.view];
}



@end
