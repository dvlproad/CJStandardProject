//
//  GSTableViewUITest.m
//  GSUITestDemoUITests
//
//  Created by gersces on 2018/8/30.
//  Copyright © 2018年 gersces. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface GSTableViewUITest : XCTestCase

@property(nonatomic,strong)XCUIApplication *app;

@end

@implementation GSTableViewUITest

- (void)setUp {
    [super setUp];
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    self.continueAfterFailure = NO;
    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    _app = [[XCUIApplication alloc]init];
    [_app launch];
    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // Use recording to get started writing UI tests.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    //点击tabbarItem，跳转到Page2界面
    XCUIElement *tabbar = _app.tabBars.allElementsBoundByIndex[0];
    XCUIElementQuery *tabbarItems = [tabbar childrenMatchingType:XCUIElementTypeButton];
    XCUIElement *page2 = [tabbarItems elementBoundByIndex:2];
    [page2 tap];

    //tabeView
    XCUIElement *tableView = [_app.tables elementBoundByIndex:0];
    [tableView swipeUp];

    //tableViewCell
    XCUIElement *tableViewCell = [tableView.cells elementBoundByIndex:8];
    [tableViewCell tap];
    
    //点击alert的确定action
    [_app.buttons[@"确定"] tap];
}

@end
