//
//  AppDelegate+CJDemoView.m
//  CJStandardProjectDemo
//
//  Created by ciyouzen on 2018/8/29.
//  Copyright © 2018年 devlproad. All rights reserved.
//

#import "AppDelegate+CJDemoView.h"

#import "CJDemoMainVCFactory.h"
#import "CJDemoLoginVCFactory.h"
#import "GuideViewController.h"

#import "CJDemoServiceUserManager.h"
#import "CJDemoServiceLocationManager.h"

@interface AppDelegate () <CJDemoAppDidFinishLaunchingDelegate, CJDemoAppListenDelegate, GuideViewControllerDelegate> {
    
}

@end


@implementation AppDelegate (CJDemoView)

- (void)viewDidFinishLaunching {
    self.logicControl = [[CJDemoAppDelegateLogicControl alloc] init];
    self.logicControl.didFinishLaunchingDelegate = self;
    self.logicControl.listenDelegate = self;
    
    // 设置 rootViewController
    CJDemoRootViewControllerType rootViewControllerType = [self.logicControl getDidFinishLaunchingRootViewControllerType];
    [self setupRootViewControllerWithType:rootViewControllerType];
}

- (void)viewWillEnterForeground {
    CLAuthorizationStatus status = [CJDemoServiceLocationManager sharedInstance].authorizationStatus;
    [self.logicControl dealLocationAlertWithLocationAuthorizationStatus:status];
}

- (void)setupRootViewControllerWithType:(CJDemoRootViewControllerType)rootViewControllerType
{
    //如果type一样/未改变，则不处理
    if (rootViewControllerType == self.rootViewControllerType) {
        return;
    }
    self.rootViewControllerType = rootViewControllerType;
    
    if (rootViewControllerType == CJDemoRootViewControllerTypeGuide) {
        GuideViewController *guideViewController = [[GuideViewController alloc] init];
        guideViewController.delegate = self;
        self.window.rootViewController = guideViewController;
        
    } else if (rootViewControllerType == CJDemoRootViewControllerTypeMain) {
        UIViewController *mainViewController = [CJDemoMainVCFactory mainRootViewController];
        self.window.rootViewController = mainViewController;
        
    } else {
        UIViewController *loginNavigationController = [CJDemoLoginVCFactory loginViewController];
        self.window.rootViewController = loginNavigationController;
    }
}

#pragma mark - CJDemoAppDelegateLogicControlDelegate
- (void)changeRootViewControllerWithType:(CJDemoRootViewControllerType)rootViewControllerType {
    [self setupRootViewControllerWithType:rootViewControllerType];
}

- (void)showLocationNoOpenAlert {
    [CJDemoAlert showLocationNoOpenAlert:YES];
}

- (void)showLocationAbnormalAlert {
    [CJDemoAlert showLocationAbnormalAlert:YES];
}

- (void)dismissLocationAllAlert {
    [CJDemoAlert showLocationNoOpenAlert:NO];
    [CJDemoAlert showLocationAbnormalAlert:NO];
}


#pragma mark - CJDemoAppListenDelegate
- (void)amapLocationManagerDidChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    
}

- (void)appUserManagerDidUpdateLoginState:(BOOL)loginState {
    
}


#pragma mark - CJDemoGuideViewControllerDelegate
- (void)guideViewControllerReadOver:(GuideViewController *)guideViewController {
    [self setupRootViewControllerWithType:CJDemoRootViewControllerTypeLogin];
}


@end
