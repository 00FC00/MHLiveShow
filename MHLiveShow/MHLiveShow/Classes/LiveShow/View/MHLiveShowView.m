//
//  MHLiveShowView.m
//  MHLiveShow
//
//  Created by CoderMikeHe on 2017/3/16.
//  Copyright © 2017年 CoderMikeHe. All rights reserved.
//

#import "MHLiveShowView.h"
#import "MHLiveShow.h"


@interface MHLiveShowView ()

/** 图标 */
@property (nonatomic , weak) UIImageView *appIcon;

/** 文字 */
@property (nonatomic , weak) YYLabel *titleLabel;


@end

@implementation MHLiveShowView

+ (instancetype)liveShowView
{
    return [[self alloc] init];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // 初始化
        [self _setup];
        
        // 创建自控制器
        [self _setupSubViews];
        
        // 布局子控件
        [self _makeSubViewsConstraints];
        
    }
    return self;
}
#pragma mark - 公共方法
- (void)setLiveShow:(MHLiveShow *)liveShow
{
    _liveShow = liveShow;

    self.appIcon.image = MHImageNamed(liveShow.appIconName);
    self.titleLabel.text = liveShow.title;
}


#pragma mark - 私有方法
#pragma mark - 初始化
- (void)_setup
{
    self.backgroundColor = [UIColor whiteColor];
}

#pragma mark - 创建自控制器
- (void)_setupSubViews
{
    // 图标
    UIImageView *appIcon = [[UIImageView alloc] init];
    [self addSubview:appIcon];
    self.appIcon = appIcon;
    
    // 主题
    YYLabel *titleLabel = [[YYLabel alloc] init];
    titleLabel.font = MHFont(14.0f, NO);
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:titleLabel];
    self.titleLabel = titleLabel;
}


#pragma mark - 布局子控件
- (void)_makeSubViewsConstraints
{
    // 布局图标
    [self.appIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.top.and.right.equalTo(self);
        make.height.equalTo(self.mas_width);
    }];
    
    // 布局主题
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.and.right.equalTo(self);
        make.top.equalTo(self.appIcon.mas_bottom);
    }];
    
    
}

#pragma mark - 布局子控件
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 布局子控件
    
    
}


@end
