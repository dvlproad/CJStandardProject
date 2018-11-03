//
//  AppDelegate+STDemoView_Old.m
//  CJStandardProjectDemo
//
//  Created by ciyouzen on 2018/8/29.
//  Copyright © 2018年 devlproad. All rights reserved.
//

#import "AppDelegate+STDemoView_Old.h"

#import "STDemoMainVCFactory.h"
#import "STDemoLoginVCFactory.h"
#import "GuideViewController.h"

#import "STDemoServiceUserManager.h"
#import "STDemoServiceLocationManager.h"

@interface AppDelegate () <STDemoAppDidFinishLaunchingDelegate, STDemoAppLogicListenDelegate, GuideViewControllerDelegate> {
    
}

@end


@implementation AppDelegate (STDemoView_Old)

- (void)old_viewDidFinishLaunching {
    self.logicControl = [[STDemoAppDelegateLogicControl alloc] init];
    self.logicControl.didFinishLaunchingDelegate = self;
    self.logicControl.listenDelegate = self;
    
    // 设置 rootViewController
    STDemoRootViewControllerType rootViewControllerType = [self.logicControl getDidFinishLaunchingRootViewControllerType];
    [self old_setupRootViewControllerWithType:rootViewControllerType];
}

- (void)old_viewWillEnterForeground {
    CLAuthorizationStatus status = [STDemoServiceLocationManager sharedInstance].authorizationStatus;
    [self.logicControl dealLocationAlertWithLocationAuthorizationStatus:status];
}

- (void)old_setupRootViewControllerWithType:(STDemoRootViewControllerType)rootViewControllerType
{
    //如果type一样/未改变，则不处理
    if (rootViewControllerType == self.rootViewControllerType) {
        return;
    }
    self.rootViewControllerType = rootViewControllerType;
    
    if (rootViewControllerType == STDemoRootViewControllerTypeGuide) {
        GuideViewController *guideViewController = [[GuideViewController alloc] init];
        guideViewController.delegate = self;
        self.window.rootViewController = guideViewController;
        
    } else if (rootViewControllerType == STDemoRootViewControllerTypeMain) {
        UIViewController *mainViewController = [STDemoMainVCFactory mainRootViewController];
        self.window.rootViewController = mainViewController;
        
    } else {
        UIViewController *loginNavigationController = [STDemoLoginVCFactory loginViewController];
        self.window.rootViewController = loginNavigationController;
    }
}

#pragma mark - STDemoAppDelegateLogicControlDelegate
- (void)old_changeRootViewControllerWithType:(STDemoRootViewControllerType)rootViewControllerType {
    [self old_setupRootViewControllerWithType:rootViewControllerType];
}

- (void)showLocationNoOpenAlert {
    [STDemoAlert showLocationNoOpenAlert:YES];
}

- (void)showLocationAbnormalAlert {
    [STDemoAlert showLocationAbnormalAlert:YES];
}

- (void)dismissLocationAllAlert {
    [STDemoAlert showLocationNoOpenAlert:NO];
    [STDemoAlert showLocationAbnormalAlert:NO];
}


#pragma mark - STDemoAppListenDelegate
- (void)amapLocationManagerDidChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    
}

- (void)appUserManagerDidUpdateLoginState:(BOOL)loginState {
    
}


#pragma mark - STDemoGuideViewControllerDelegate
- (void)guideViewControllerReadOver:(GuideViewController *)guideViewController {
    [self old_setupRootViewControllerWithType:STDemoRootViewControllerTypeLogin];
}


@end
