//
//  STDemoLoginBlockViewModelTests.m
//  CJStandardProjectDemoTests
//
//  Created by ciyouzen on 2018/8/29.
//  Copyright © 2018年 devlproad. All rights reserved.
//

#import "STDemoTestCase.h"
#import "LoginBlockViewModel.h"
#import "NSString+STDemoValidate.h"
#import "CJDemoServiceUserManager+Network.h"

@interface STDemoLoginBlockViewModelTests : STDemoTestCase {
    
}
@property (nonatomic, strong) LoginBlockViewModel *viewControl;

@end

@implementation STDemoLoginBlockViewModelTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    LoginBlockViewModel *viewControl = [[LoginBlockViewModel alloc] init];
    NSString *tryFailureMessage = [viewControl checkLoginCondition];
    if (tryFailureMessage) {
        return;
    }
    
    [viewControl loginWitLoginSuccess:^(NSString *successMessage) {
        NOTIFY
    } loginFailure:^(NSString *errorMessage) {
        NOTIFY
    }];
    
    self.viewControl = viewControl;
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
    LoginBlockViewModel *viewControl = [[LoginBlockViewModel alloc] initWithUserName:@"Beyond" password:@"Luckin1234"];
    NSString *tryFailureMessage = [viewControl checkLoginCondition];
    XCTAssertFalse(tryFailureMessage);
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
    LoginBlockViewModel *viewControl = [[LoginBlockViewModel alloc] init];
    [viewControl updateUserName:@"Beyond"];
    [viewControl updatePassword:@"Luckin1234"];
    
    [viewControl loginWitLoginSuccess:^(NSString *successMessage) {
        NOTIFY
    } loginFailure:^(NSString *errorMessage) {
        NOTIFY
    }];
    WAIT
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
