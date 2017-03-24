//
//  MHConstant.h
//  MHLiveShow
//
//  Created by CoderMikeHe on 17/2/24.
//  Copyright © 2017年 CoderMikeHe. All rights reserved.
//

// sys
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

// category
#import "UIBarButtonItem+MHExtension.h"
#import "UIView+MH.h"
#import "UIFont+MHExtension.h"
#import "NSString+MH.h"
#import "UINavigationController+FDFullscreenPopGesture.h"
#import "NSObject+MH.h"
#import "Colours.h"
#import "UIImage+MH.h"
#import "UIViewController+MHDismissKeyboard.h"
#import "UIViewController+MHHUD.h"
#import "NSDate+Extension.h"
#import "MBProgressHUD+MH.h"


// tool
#import "MHWebImageTool.h"
#import "MHSingleton.h"
#import "Masonry.h"
#import "pop.h"

// UIKit
#import "MHButton.h"
#import "YYText.h"
#import "MHImageView.h"
#import "MHDivider.h"
#import "MHBackButton.h"

// 模型
#import "AppDelegate.h"


/**
 * 设置颜色
 */
#define MHColorFromHexString(__hexString__) [UIColor colorFromHexString:__hexString__]

/**
 *  全局细下滑线颜色 以及分割线颜色
 */
#define MHGlobalBottomLineColor     [UIColor colorFromHexString:@"#d6d7dc"]
/**
 *  全局灰色色字体颜色 + placeHolder字体颜色
 */
#define MHGlobalGrayTextColor       [UIColor colorFromHexString:@"#999999"]

/**
 *  全局白色字体
 */
#define MHGlobalWhiteTextColor      [UIColor colorFromHexString:@"#ffffff"]

/**
 *  全局黑色字体
 */
#define MHGlobalBlackTextColor      [UIColor colorFromHexString:@"#323232"]
/**
 *  全局浅黑色字体
 */
#define MHGlobalShadowBlackTextColor      [UIColor colorFromHexString:@"#646464"]

/**
 *  全局灰色 背景
 */
#define MHGlobalGrayBackgroundColor [UIColor colorFromHexString:@"#f8f8f8"]

// ======== 喵播 =======

typedef NS_ENUM(NSUInteger, MBSquareTag) {
    MBSquareTagHot = 1,             // 热门
    MBSquareTagShow,                // 才艺
    MBSquareTagGoodVoice = 3 ,      // 好声音
    MBSquareTagNew = 999,           // 最新 这个特殊
    MBSquareTagNearby = 2,          // 附近
    MBSquareTagOverseas = 8,        // 海外
    MBSquareTagOfficial = 3 ,   // 官方
};

/**
 *  全局亮红色
 */
#define MHGlobalLightRedColor MHColor(247.0f, 83.0f, 153.0f)

/** 百思不得姐 -顶部标题的高度 */
UIKIT_EXTERN  CGFloat const MHTitileContentViewH ;
/** 百思不得姐-顶部标题的Y */
UIKIT_EXTERN  CGFloat const MHTitileContentViewY ;

// ======== 喵播 =======


// 直播Demo类型
typedef NS_ENUM(NSUInteger, MHLiveShowType) {
    MHLiveShowTypeMiaoBo = 0, // 喵播
};

/** liveShowView点击的通知 */
UIKIT_EXTERN NSString * const MHLiveShowViewDidTransmitDataNotification;
/** liveShowView点击传递数据的Key */
UIKIT_EXTERN NSString * const MHLiveShowViewDidTransmitDatadKey;

