//
//  MBSquareMoreTagView.m
//  MHLiveShow
//
//  Created by apple on 2017/3/24.
//  Copyright © 2017年 CoderMikeHe. All rights reserved.
//

#import "MBSquareMoreTagView.h"

@implementation MBSquareMoreTagView

- (void)dealloc
{

}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.image = [UIImage mh_resizedImage:@"mb_home_conver_15x30_"];
        
        // 初始化子控件
        [self _setupSubViews];
        
    }
    return self;
}


#pragma mark - 初始化
- (void)_setupSubViews
{
    /*
     毛玻璃的样式(枚举)
     UIBlurEffectStyleExtraLight,
     UIBlurEffectStyleLight,
     UIBlurEffectStyleDark  // 黑色
     */
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    [self addSubview:effectView];
    [effectView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
    
    
    // 关闭按钮
    UIButton *closeBtn = [[UIButton alloc] init];
    [closeBtn setImage:MHImageNamed(@"mb_home_close_18x18_") forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(_closeBtnDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:closeBtn];
    
    // 布局关闭按钮
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self).with.offset(-10);;
        make.top.equalTo(self).with.offset(20);
        make.height.and.width.mas_equalTo(44);
        
    }];
}



#pragma mark - 事件处理
- (void)_closeBtnDidClicked:(UIButton *)sender
{
    [UIView animateWithDuration:.25f animations:^{
        self.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
       
        [self removeFromSuperview];
        
    }];
}
@end
