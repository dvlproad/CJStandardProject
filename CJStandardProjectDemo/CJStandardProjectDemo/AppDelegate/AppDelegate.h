//
//  AppDelegate.h
//  CJStandardProjectDemo
//
//  Created by ciyouzen on 2018/8/29.
//  Copyright © 2018年 devlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STDemoAppDelegateLogicControl.h"

#import "STDemoAppDelegateListenLogic.h"
#import "STDemoAppDelegateViewLogic.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, STDemoAppListenDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong) STDemoAppDelegateLogicControl *logicControl;
@property (nonatomic, assign) STDemoRootViewControllerType rootViewControllerType;

@property (nonatomic, strong) STDemoAppDelegateViewLogic *viewLogic;
@property (nonatomic, strong) STDemoAppDelegateListenLogic *listenLogic;

+ (instancetype)sharedDelegate;


@end

