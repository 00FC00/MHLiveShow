//
//  MHLiveShowView.h
//  MHLiveShow
//
//  Created by CoderMikeHe on 2017/3/16.
//  Copyright © 2017年 CoderMikeHe. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MHLiveShow;

@interface MHLiveShowView : UIControl

+ (instancetype)liveShowView;

/** liveShow */
@property (nonatomic , strong) MHLiveShow *liveShow;


@end
