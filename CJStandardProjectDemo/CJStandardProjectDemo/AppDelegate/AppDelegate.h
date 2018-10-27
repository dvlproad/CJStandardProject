//
//  AppDelegate.h
//  CJStandardProjectDemo
//
//  Created by ciyouzen on 2018/8/29.
//  Copyright © 2018年 devlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CJDemoAppDelegateLogicControl.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong) CJDemoAppDelegateLogicControl *logicControl;
@property (nonatomic, assign) CJDemoRootViewControllerType rootViewControllerType;

+ (instancetype)sharedDelegate;


@end

