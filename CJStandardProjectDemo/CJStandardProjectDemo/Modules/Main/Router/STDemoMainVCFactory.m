//
//  STDemoMainVCFactory.m
//  CJStandardProjectDemo
//
//  Created by ciyouzen on 6/25/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import "STDemoMainVCFactory.h"
#import "DemoMainViewController.h"
//#import <STDemoModuleMain/CTMediator+STDemoModuleMain.h> //需要依赖Main

@implementation STDemoMainVCFactory

+ (UIViewController *)mainRootViewController {
//    NSDictionary *params = nil;
//    UIViewController *viewController = [[CTMediator sharedInstance] cjDemo_mainViewControllerWithParams:params];
    DemoMainViewController *viewController = [[DemoMainViewController alloc] init];
    return viewController;
}

@end
