//
//  MHLiveShow.m
//  MHLiveShow
//
//  Created by CoderMikeHe on 2017/3/16.
//  Copyright © 2017年 CoderMikeHe. All rights reserved.
//

#import "MHLiveShow.h"

@implementation MHLiveShow

- (instancetype)initWithAppIconName:(NSString *)appIconName title:(NSString *)title type:(MHLiveShowType)type
{
    MHLiveShow *liveShow = [[MHLiveShow alloc] init];
    liveShow.appIconName = appIconName ;
    liveShow.title = title;
    liveShow.type = type;
    return liveShow;
}

+ (instancetype)liveShowWithAppIconName:(NSString *)appIconName title:(NSString *)title type:(MHLiveShowType)type
{
    return [[self alloc] initWithAppIconName:appIconName title:title type:type];
}

@end
