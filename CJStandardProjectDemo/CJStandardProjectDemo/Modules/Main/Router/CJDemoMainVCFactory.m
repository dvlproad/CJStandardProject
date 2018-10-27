//
//  CJDemoMainVCFactory.m
//  CJStandardProjectDemo
//
//  Created by ciyouzen on 6/25/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import "CJDemoMainVCFactory.h"
#import "DemoMainViewController.h"
//#import <CJDemoModuleMain/CTMediator+CJDemoModuleMain.h> //需要依赖Main

@implementation CJDemoMainVCFactory

+ (UIViewController *)mainRootViewController {
//    NSDictionary *params = nil;
//    UIViewController *viewController = [[CTMediator sharedInstance] cjDemo_mainViewControllerWithParams:params];
    DemoMainViewController *viewController = [[DemoMainViewController alloc] init];
    return viewController;
}

@end
