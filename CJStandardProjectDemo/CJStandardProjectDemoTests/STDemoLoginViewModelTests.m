//
//  STDemoLoginViewModelTests.m
//  CJStandardProjectDemoTests
//
//  Created by ciyouzen on 2018/8/29.
//  Copyright © 2018年 devlproad. All rights reserved.
//

#import "STDemoTestCase.h"
#import "LoginViewModel.h"
#import "NSString+STDemoValidate.h"
#import "STDemoServiceUserManager+Network.h"

@interface STDemoLoginViewModelTests : STDemoTestCase {
    
}
@property (nonatomic, strong) LoginViewModel *viewModel;

@end

@implementation STDemoLoginViewModelTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    LoginViewModel *viewModel = [[LoginViewModel alloc] init];
    NSString *tryFailureMessage = [viewModel checkLoginCondition];
    if (tryFailureMessage) {
        return;
    }
    
    [viewModel loginWitLoginSuccess:^(NSString *successMessage) {
        NOTIFY
    } loginFailure:^(NSString *errorMessage) {
        NOTIFY
    }];
    
    self.viewModel = viewModel;
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
    LoginViewModel *viewModel = [[LoginViewModel alloc] initWithUserName:@"Beyond" password:@"Luckin1234"];
    NSString *tryFailureMessage = [viewModel checkLoginCondition];
    XCTAssertFalse(tryFailureMessage);
}

- (void)testLoginRequest {
    NSString *userName = @"Beyond";
    NSString *password = @"Luckin1234";
    [[STDemoServiceUserManager sharedInstance] requestLoginWithAccount:userName password:password success:^(STDemoUser *user) {
        XCTAssertNotNil(user, @"user不能为空");
        NOTIFY
    } failure:^(NSString *errorMessage) {
        NOTIFY
    }];
    WAIT
}

- (void)testLoginLogic {
    LoginViewModel *viewModel = [[LoginViewModel alloc] init];
    [viewModel updateUserName:@"Beyond"];
    [viewModel updatePassword:@"Luckin1234"];
    
    [viewModel loginWitLoginSuccess:^(NSString *successMessage) {
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
