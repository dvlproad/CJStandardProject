//
//  AppDelegate+STDemoView_New.m
//  CJStandardProjectDemo
//
//  Created by ciyouzen on 2018/8/29.
//  Copyright © 2018年 devlproad. All rights reserved.
//

#import "AppDelegate+STDemoView_New.h"

#import "STDemoMainVCFactory.h"
//#import "STDemoLoginVCFactory.h"
#import "CTMediator+CJDemoModuleLogin.h"
#import "GuideViewController.h"

#import "CJDemoServiceUserManager.h"
#import "STDemoServiceLocationManager.h"

@interface AppDelegate () <STDemoAppDidFinishLaunchingDelegate, STDemoAppLogicListenDelegate> {
    
}

@end


@implementation AppDelegate (STDemoView_New)

- (void)viewDidFinishLaunching {
    self.logicControl = [[STDemoAppDelegateLogicControl alloc] init];
    self.logicControl.didFinishLaunchingDelegate = self;
    self.logicControl.listenDelegate = self;
    
    // 设置 rootViewController
    STDemoRootViewControllerType rootViewControllerType = [self.logicControl getDidFinishLaunchingRootViewControllerType];
    [self setupRootViewControllerWithType:rootViewControllerType];
}

- (void)viewWillEnterForeground {
    CLAuthorizationStatus status = [STDemoServiceLocationManager sharedInstance].authorizationStatus;
    [self.logicControl dealLocationAlertWithLocationAuthorizationStatus:status];
}

- (void)setupRootViewControllerWithType:(STDemoRootViewControllerType)rootViewControllerType
{
    //如果type一样/未改变，则不处理
    if (rootViewControllerType == self.rootViewControllerType) {
        return;
    }
    self.rootViewControllerType = rootViewControllerType;
    
    if (rootViewControllerType == STDemoRootViewControllerTypeGuide) {
        GuideViewController *guideViewController = [[GuideViewController alloc] init];
        //guideViewController.delegate = self;
        self.window.rootViewController = guideViewController;
        
    } else if (rootViewControllerType == STDemoRootViewControllerTypeMain) {
        UIViewController *mainViewController = [STDemoMainVCFactory mainRootViewController];
        self.window.rootViewController = mainViewController;
        
    } else {
        UIViewController *loginNavigationController = [[CTMediator sharedInstance] cjDemo_loginViewControllerWithParams:nil];
        self.window.rootViewController = loginNavigationController;
    }
}

#pragma mark - STDemoAppDelegateLogicControlDelegate
- (void)changeRootViewControllerWithType:(STDemoRootViewControllerType)rootViewControllerType {
    [self setupRootViewControllerWithType:rootViewControllerType];
}

- (void)showLocationNoOpenAlert {
    [DemoAlert showLocationNoOpenAlert:YES];
}

- (void)showLocationAbnormalAlert {
    [DemoAlert showLocationAbnormalAlert:YES];
}

- (void)dismissLocationAllAlert {
    [DemoAlert showLocationNoOpenAlert:NO];
    [DemoAlert showLocationAbnormalAlert:NO];
}

#pragma mark - STDemoGuideViewControllerDelegate
- (void)guideViewControllerReadOver:(GuideViewController *)guideViewController {
    [self setupRootViewControllerWithType:STDemoRootViewControllerTypeLogin];
}


@end
