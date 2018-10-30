//
//  STDemoStartUp.m
//  CJStandardProjectDemo
//
//  Created by ciyouzen on 10/29/18.
//  Copyright © 2018 devlproad. All rights reserved.
//

#import "STDemoStartUp.h"
#import <Bugly/Bugly.h>

@implementation STDemoStartUp

+ (void)startUp {
    [self setupBugly];
}

+ (void)setupBugly {
    BuglyConfig *config = [[BuglyConfig alloc] init];
    config.reportLogLevel = BuglyLogLevelWarn;      // 设置自定义日志上报的级别，默认不上报自定义日志
#if DEBUG
    config.debugMode = YES;
#endif
    NSString *buglyAPPID = @"c2d7628434";
    [Bugly startWithAppId:buglyAPPID config:config];
}

@end
