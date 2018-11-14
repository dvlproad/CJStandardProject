//
//  GSGestureUITest.m
//  GSUITestDemoUITests
//
//  Created by gersces on 2018/8/29.
//  Copyright © 2018年 gersces. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface GSGestureUITest : XCTestCase

@property(nonatomic,strong)XCUIApplication *app;

@end

@implementation GSGestureUITest

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
    
    //单击label
    [_app.staticTexts[@"单击"] tap];
    //点击alert的确定action
    [_app.buttons[@"确定"] tap];

    //双击label
    [_app.staticTexts[@"双击"] doubleTap];
    //点击alert的确定action
    [_app.buttons[@"确定"] tap];
    
    //长按label
    [_app.staticTexts[@"长按"] pressForDuration:1.5];
    //点击alert的确定action
    [_app.buttons[@"确定"] tap];

    //轻扫label
    [_app.staticTexts[@"swipeRight"] swipeRight];
    //点击alert的确定action
    [_app.buttons[@"确定"] tap];

    //scrollView滑动
    XCUIElement *scroller = [_app.scrollViews elementBoundByIndex:0];
    [scroller swipeLeft];
    [scroller swipeLeft];
    [scroller swipeRight];
}

@end
