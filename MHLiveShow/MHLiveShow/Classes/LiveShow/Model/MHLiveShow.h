//
//  MHLiveShow.h
//  MHLiveShow
//
//  Created by CoderMikeHe on 2017/3/16.
//  Copyright © 2017年 CoderMikeHe. All rights reserved.
//

#import <Foundation/Foundation.h>




@interface MHLiveShow : NSObject

/** appIconName */
@property (nonatomic , copy) NSString *appIconName;
/** title */
@property (nonatomic , copy) NSString *title;
/** type */
@property (nonatomic , assign) MHLiveShowType type;

// 初始化
- (instancetype) initWithAppIconName:(NSString *)appIconName title:(NSString *)title type:(MHLiveShowType)type;
+ (instancetype) liveShowWithAppIconName:(NSString *)appIconName title:(NSString *)title type:(MHLiveShowType)type;

@end
