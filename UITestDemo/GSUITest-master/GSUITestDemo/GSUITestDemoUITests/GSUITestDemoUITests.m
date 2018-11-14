//
//  GSUITestDemoUITests.m
//  GSUITestDemoUITests
//
//  Created by gersces on 2018/8/29.
//  Copyright © 2018年 gersces. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface GSUITestDemoUITests : XCTestCase

@property(nonatomic,strong)XCUIApplication *app;

@end

@implementation GSUITestDemoUITests

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
    
    //tabbarItem
    XCUIElement *tabbar = _app.tabBars.allElementsBoundByIndex[0];
    XCUIElementQuery *tabbarItems = [tabbar childrenMatchingType:XCUIElementTypeButton];
    XCUIElement *page0 = [tabbarItems elementBoundByIndex:0];
    XCUIElement *page1 = [tabbarItems elementBoundByIndex:1];
    XCUIElement *page2 = [tabbarItems elementBoundByIndex:2];
    XCUIElement *page3 = [tabbarItems elementBoundByIndex:3];
    [page1 tap];
    [page2 tap];
    [page3 tap];
    [page0 tap];
    
    NSLog(@"GS: touchBars%@",_app.touchBars.allElementsBoundByAccessibilityElement);
    NSLog(@"GS: groups%@",_app.groups.allElementsBoundByAccessibilityElement);
    NSLog(@"GS: windows%@",_app.windows.allElementsBoundByAccessibilityElement);
    NSLog(@"GS: sheets%@",_app.sheets.allElementsBoundByAccessibilityElement);
    NSLog(@"GS: drawers%@",_app.drawers.allElementsBoundByAccessibilityElement);
    NSLog(@"GS: alerts%@",_app.alerts.allElementsBoundByAccessibilityElement);
    NSLog(@"GS: dialogs%@",_app.dialogs.allElementsBoundByAccessibilityElement);
    NSLog(@"GS: dialogs%@",_app.dialogs.allElementsBoundByAccessibilityElement);
    NSLog(@"GS: radioButtons%@",_app.radioButtons.allElementsBoundByAccessibilityElement);
    NSLog(@"GS: radioGroups%@",_app.radioGroups.allElementsBoundByAccessibilityElement);
    NSLog(@"GS: checkBoxes%@",_app.checkBoxes.allElementsBoundByAccessibilityElement);
    NSLog(@"GS: disclosureTriangles%@",_app.disclosureTriangles.allElementsBoundByAccessibilityElement);
    NSLog(@"GS: popUpButtons%@",_app.popUpButtons.allElementsBoundByAccessibilityElement);
    NSLog(@"GS: comboBoxes%@",_app.comboBoxes.allElementsBoundByAccessibilityElement);
    NSLog(@"GS: menuButtons%@",_app.menuButtons.allElementsBoundByAccessibilityElement);
    NSLog(@"GS: toolbarButtons%@",_app.toolbarButtons.allElementsBoundByAccessibilityElement);
    NSLog(@"GS: popovers%@",_app.popovers.allElementsBoundByAccessibilityElement);
    NSLog(@"GS: keyboards%@",_app.keyboards.allElementsBoundByAccessibilityElement);
    NSLog(@"GS: keys%@",_app.keys.allElementsBoundByAccessibilityElement);
    NSLog(@"GS: navigationBars%@",_app.navigationBars.allElementsBoundByAccessibilityElement);
    NSLog(@"GS: tabBars%@",_app.tabBars.allElementsBoundByAccessibilityElement);
    NSLog(@"GS: tabGroups%@",_app.tabGroups.allElementsBoundByAccessibilityElement);
    NSLog(@"GS: toolbars%@",_app.toolbars.allElementsBoundByAccessibilityElement);
    NSLog(@"GS: statusBars%@",_app.statusBars.allElementsBoundByAccessibilityElement);
    NSLog(@"GS: tables%@",_app.tables.allElementsBoundByAccessibilityElement);
    NSLog(@"GS: tableRows%@",_app.tableRows.allElementsBoundByAccessibilityElement);
    NSLog(@"GS: tableColumns%@",_app.tableColumns.allElementsBoundByAccessibilityElement);
    NSLog(@"GS: outlines%@",_app.outlines.allElementsBoundByAccessibilityElement);
    NSLog(@"GS: outlineRows%@",_app.outlineRows.allElementsBoundByAccessibilityElement);
    NSLog(@"GS: browsers%@",_app.browsers.allElementsBoundByAccessibilityElement);
    NSLog(@"GS: collectionViews%@",_app.collectionViews.allElementsBoundByAccessibilityElement);
    NSLog(@"GS: sliders%@",_app.sliders.allElementsBoundByAccessibilityElement);
    NSLog(@"GS: pageIndicators%@",_app.pageIndicators.allElementsBoundByAccessibilityElement);
    NSLog(@"GS: progressIndicators%@",_app.progressIndicators.allElementsBoundByAccessibilityElement);
    NSLog(@"GS: activityIndicators%@",_app.activityIndicators.allElementsBoundByAccessibilityElement);
    NSLog(@"GS: segmentedControls%@",_app.segmentedControls.allElementsBoundByAccessibilityElement);
    NSLog(@"GS: pickers%@",_app.pickers.allElementsBoundByAccessibilityElement);
    NSLog(@"GS: pickerWheels%@",_app.pickerWheels.allElementsBoundByAccessibilityElement);
    NSLog(@"GS: switches%@",_app.switches.allElementsBoundByAccessibilityElement);
    NSLog(@"GS: toggles%@",_app.toggles.allElementsBoundByAccessibilityElement);
    NSLog(@"GS: links%@",_app.links.allElementsBoundByAccessibilityElement);
    NSLog(@"GS: images%@",_app.images.allElementsBoundByAccessibilityElement);
    NSLog(@"GS: icons%@",_app.icons.allElementsBoundByAccessibilityElement);
    NSLog(@"GS: searchFields%@",_app.searchFields.allElementsBoundByAccessibilityElement);
    NSLog(@"GS: scrollViews%@",_app.scrollViews.allElementsBoundByAccessibilityElement);
    NSLog(@"GS: scrollBars%@",_app.scrollBars.allElementsBoundByAccessibilityElement);
    NSLog(@"GS: staticTexts%@",_app.staticTexts.allElementsBoundByAccessibilityElement);
    NSLog(@"GS: textFields%@",_app.textFields.allElementsBoundByAccessibilityElement);
    NSLog(@"GS: secureTextFields%@",_app.secureTextFields.allElementsBoundByAccessibilityElement);
    NSLog(@"GS: datePickers%@",_app.datePickers.allElementsBoundByAccessibilityElement);
    NSLog(@"GS: textViews%@",_app.textViews.allElementsBoundByAccessibilityElement);
    NSLog(@"GS: menus%@",_app.menus.allElementsBoundByAccessibilityElement);
    NSLog(@"GS: menuItems%@",_app.menuItems.allElementsBoundByAccessibilityElement);
    NSLog(@"GS: menuBars%@",_app.menuBars.allElementsBoundByAccessibilityElement);
    NSLog(@"GS: menuBarItems%@",_app.menuBarItems.allElementsBoundByAccessibilityElement);
    NSLog(@"GS: maps%@",_app.maps.allElementsBoundByAccessibilityElement);
    NSLog(@"GS: webViews%@",_app.webViews.allElementsBoundByAccessibilityElement);
    NSLog(@"GS: steppers%@",_app.steppers.allElementsBoundByAccessibilityElement);
    NSLog(@"GS: incrementArrows%@",_app.incrementArrows.allElementsBoundByAccessibilityElement);
    NSLog(@"GS: decrementArrows%@",_app.decrementArrows.allElementsBoundByAccessibilityElement);
    NSLog(@"GS: tabs%@",_app.tabs.allElementsBoundByAccessibilityElement);
    NSLog(@"GS: timelines%@",_app.timelines.allElementsBoundByAccessibilityElement);
    NSLog(@"GS: ratingIndicators%@",_app.ratingIndicators.allElementsBoundByAccessibilityElement);
    NSLog(@"GS: valueIndicators%@",_app.valueIndicators.allElementsBoundByAccessibilityElement);
    NSLog(@"GS: splitGroups%@",_app.splitGroups.allElementsBoundByAccessibilityElement);
    NSLog(@"GS: splitters%@",_app.splitters.allElementsBoundByAccessibilityElement);
    NSLog(@"GS: relevanceIndicators%@",_app.relevanceIndicators.allElementsBoundByAccessibilityElement);
    NSLog(@"GS: colorWells%@",_app.colorWells.allElementsBoundByAccessibilityElement);
    NSLog(@"GS: helpTags%@",_app.helpTags.allElementsBoundByAccessibilityElement);
    NSLog(@"GS: mattes%@",_app.mattes.allElementsBoundByAccessibilityElement);
    NSLog(@"GS: dockItems%@",_app.dockItems.allElementsBoundByAccessibilityElement);
    NSLog(@"GS: rulers%@",_app.rulers.allElementsBoundByAccessibilityElement);
    NSLog(@"GS: rulerMarkers%@",_app.rulerMarkers.allElementsBoundByAccessibilityElement);
    NSLog(@"GS: grids%@",_app.grids.allElementsBoundByAccessibilityElement);
    NSLog(@"GS: levelIndicators%@",_app.levelIndicators.allElementsBoundByAccessibilityElement);
    NSLog(@"GS: cells%@",_app.cells.allElementsBoundByAccessibilityElement);
    NSLog(@"GS: layoutAreas%@",_app.layoutAreas.allElementsBoundByAccessibilityElement);
    NSLog(@"GS: layoutItems%@",_app.layoutItems.allElementsBoundByAccessibilityElement);
    NSLog(@"GS: handles%@",_app.handles.allElementsBoundByAccessibilityElement);
    NSLog(@"GS: otherElements%@",_app.otherElements.allElementsBoundByAccessibilityElement);
    NSLog(@"GS: statusItems%@",_app.statusItems.allElementsBoundByAccessibilityElement);

}

@end
