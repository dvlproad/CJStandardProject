//
//  STDemoOrderListTests.m
//  CJStandardProjectDemoUITests
//
//  Created by ciyouzen on 2018/8/29.
//  Copyright © 2018年 devlproad. All rights reserved.
//

#import "STDemoUITestCase.h"

@interface STDemoOrderListTests : STDemoUITestCase

@end

@implementation STDemoOrderListTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    self.continueAfterFailure = NO;

    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    [[[XCUIApplication alloc] init] launch];

    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
}


- (void)testOrderList {
    
    XCUIApplication *app = [[XCUIApplication alloc] init];
    XCUIElement *emptyListTable = app.tables[@"Empty list"];
    [emptyListTable swipeDown];
    [emptyListTable swipeDown];
    
    XCUIElementQuery *elementsQuery = app.scrollViews.otherElements;
    XCUIElement *staticText = elementsQuery.staticTexts[@"\U5df2\U5b8c\U6210"];
    [staticText tap];
    
    XCUIElement *staticText2 = elementsQuery.staticTexts[@"\U914d\U9001\U4e2d"];
    [staticText2 tap];
    [staticText tap];
    [staticText2 tap];
    [staticText tap];
    [emptyListTable swipeDown];
    [staticText2 tap];
    [emptyListTable swipeDown];
    [staticText tap];
    [emptyListTable swipeDown];
    [emptyListTable swipeDown];
    [emptyListTable swipeDown];
    [staticText2 tap];
    [emptyListTable swipeDown];
    [emptyListTable swipeDown];
    [elementsQuery.staticTexts[@"\U5f85\U914d\U9001"] tap];
    [[[app.tables childrenMatchingType:XCUIElementTypeCell] elementBoundByIndex:1].staticTexts[@"(random95)"] swipeDown];
    [staticText2 tap];
    /*@START_MENU_TOKEN@*/[emptyListTable swipeRight];/*[["emptyListTable","["," swipeDown];"," swipeRight];"],[[[-1,0,1]],[[1,3],[1,2]]],[0,0]]@END_MENU_TOKEN@*/
    [emptyListTable swipeDown];
    [staticText tap];
    [emptyListTable swipeDown];
    [staticText2 tap];

    
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    // Use recording to get started writing UI tests.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

@end
