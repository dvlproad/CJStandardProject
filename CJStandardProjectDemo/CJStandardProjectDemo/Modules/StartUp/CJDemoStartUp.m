//
//  CJDemoStartUp.m
//  CJStandardProjectDemo
//
//  Created by ciyouzen on 10/29/18.
//  Copyright © 2018 devlproad. All rights reserved.
//

#import "CJDemoStartUp.h"
#import <Bugly/Bugly.h>

@implementation CJDemoStartUp

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
    
    
    // 测试bugly
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        NSArray *testBuglyArray = @[@"1"];
//        NSLog(@"%@", testBuglyArray[1]);
//    });
}

@end
