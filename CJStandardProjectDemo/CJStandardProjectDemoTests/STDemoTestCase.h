//
//  STDemoTestCase.h
//  CJStandardProjectDemoTests
//
//  Created by ciyouzen on 2018/8/29.
//  Copyright © 2018年 devlproad. All rights reserved.
//

#import <XCTest/XCTest.h>

#define WAIT do {\
[self expectationForNotification:@"LuckinDriverTest" object:nil handler:nil];\
[self waitForExpectationsWithTimeout:30 handler:nil];\
} while (0);

#define NOTIFY \
[[NSNotificationCenter defaultCenter]postNotificationName:@"LuckinDriverTest" object:nil];

@interface STDemoTestCase : XCTestCase

@end
