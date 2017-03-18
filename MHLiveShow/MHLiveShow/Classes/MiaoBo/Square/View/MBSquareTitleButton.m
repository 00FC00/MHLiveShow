//
//  MBSquareTitleButton.m
//  MHLiveShow
//
//  Created by CoderMikeHe on 2017/3/18.
//  Copyright © 2017年 CoderMikeHe. All rights reserved.
//

#import "MBSquareTitleButton.h"


static NSString * const MBSquareTitleButtonAnimation = @"MBSquareTitleButtonAnimation";

@implementation MBSquareTitleButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // 初始化
        [self _setup];
        
        
    }
    return self;
}
#pragma mark - 公共方法



#pragma mark - 私有方法
#pragma mark - 初始化
- (void)_setup
{
    self.titleLabel.font = MHFont(MHPxConvertPt(17.0f), NO);
}

#pragma mark - 创建自控制器


#pragma mark - 布局子控件
- (void)layoutSubviews
{
    [super layoutSubviews];
    // 布局子控件
    self.titleLabel.mh_x = 0;
    self.imageView.mh_x = CGRectGetMaxX(self.titleLabel.frame);
    
}

#pragma mark - Override
- (void)sendAction:(SEL)action to:(nullable id)target forEvent:(nullable UIEvent *)event
{
    [super sendAction:action to:target forEvent:event];
    
    // 默认顺时针旋转180
    /**
     // 方式一
     CGFloat angle = sender.isSelected?(M_PI):(0);
     // 获取上一个动画
     CABasicAnimation *preAnim = (CABasicAnimation *)[sender.imageView.layer animationForKey:MBSquareTitleButtonAnimation];
     CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
     anim.fromValue = preAnim.toValue;
     anim.toValue = @(angle);
     anim.duration = .25f;
     anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
     anim.removedOnCompletion= NO;
     anim.fillMode = kCAFillModeForwards;
     // 移除一个动画
     [sender.imageView.layer removeAnimationForKey:MBSquareTitleButtonAnimation];
     // 添加新的动画
     [sender.imageView.layer addAnimation:anim forKey:MBSquareTitleButtonAnimation];
     */
    
    // 方式二
    // (-M_PI+.000001f) 这里必须说明，如果是M_PI或者-M_PI系统都是顺时针，投机取巧的办法：为了逆时针：直接少旋转一点点，黑魔法。
    CGFloat angle = self.isSelected?(M_PI):(-M_PI+.00000001f);
    CGAffineTransform transform = CGAffineTransformRotate(self.imageView.transform, angle);
    [UIView animateWithDuration:.25f animations:^{
        self.imageView.transform = transform;
    }];
   
}


@end
