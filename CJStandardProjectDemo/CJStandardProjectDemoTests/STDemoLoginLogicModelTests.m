//
//  STDemoLoginLogicModelTests.m
//  CJStandardProjectDemoTests
//
//  Created by ciyouzen on 2018/8/29.
//  Copyright © 2018年 devlproad. All rights reserved.
//

#import "STDemoTestCase.h"
#import "LoginLogicControl.h"
#import "NSString+STDemoValidate.h"
#import "CJDemoServiceUserManager+Network.h"

@interface STDemoLoginLogicModelTests : STDemoTestCase {
    
}
@property (nonatomic, strong) LoginLogicControl *logicControl;

@end

@implementation STDemoLoginLogicModelTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    LoginLogicControl *logicControl = [[LoginLogicControl alloc] init];
    [logicControl updateUserName:@"Beyond"];
    [logicControl updatePassword:@"Luckin1234"];
    
    [logicControl loginWithTryFailure:nil loginStart:nil loginSuccess:^(NSString *successMessage) {
        NOTIFY
    } loginFailure:^(NSString *errorMessage) {
        NOTIFY
    }];
    
    self.logicControl = logicControl;
}

- (void)testCheckUserName {
    XCTAssertFalse([@"" stdemo_checkUserName]);
    XCTAssertTrue([@"Beyond" stdemo_checkUserName]);
}

- (void)testCheckPassword {
    XCTAssertFalse([@"_1af" stdemo_checkPassword]);
    XCTAssertTrue([@"Luckin1234" stdemo_checkPassword]);
}

- (void)testCheckPhone {
    XCTAssertFalse([@"20012345678" stdemo_checkMobile]);
    XCTAssertTrue([@"13312345678" stdemo_checkMobile]);
    XCTAssertTrue([@"16612345678" stdemo_checkMobile]);
    XCTAssertTrue([@"18912345678" stdemo_checkMobile]);
}

- (void)testCheckLoginCondition {
    LoginLogicControl *logicControl = [[LoginLogicControl alloc] init];
    [logicControl updateUserName:@"Beyond"];
    [logicControl updatePassword:@"Luckin1234"];
//    NSString *tryFailureMessage = [loginLogicControl checkLoginCondition];
//    XCTAssertFalse(tryFailureMessage);
}

- (void)testLoginRequest {
    NSString *userName = @"Beyond";
    NSString *password = @"Luckin1234";
    [[CJDemoServiceUserManager sharedInstance] requestLoginWithAccount:userName password:password success:^(DemoUser *user) {
        XCTAssertNotNil(user, @"user不能为空");
        NOTIFY
    } failure:^(NSString *errorMessage) {
        NOTIFY
    }];
    WAIT
}

- (void)testLoginLogic {
    LoginLogicControl *logicControl = [[LoginLogicControl alloc] init];
    [logicControl updateUserName:@"Beyond"];
    [logicControl updatePassword:@"Luckin1234"];
    
    [logicControl loginWithTryFailure:nil loginStart:nil loginSuccess:^(NSString *successMessage) {
        NOTIFY
    } loginFailure:^(NSString *errorMessage) {
        NOTIFY
    }];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
