//
//  AppDelegate+STDemoListen.m
//  CJStandardProjectDemo
//
//  Created by 李超前 on 10/29/18.
//  Copyright © 2018 devlproad. All rights reserved.
//

#import "AppDelegate+STDemoListen.h"
#import "STDemoAppDelegateListenLogic.h"
#import "AppDelegate+STDemoView_New.h"

@interface AppDelegate () <STDemoAppListenDelegate> {
    
}

@end


@implementation AppDelegate (STDemoListen)

///开启监听
- (void)startListen {
    self.listenLogic = [[STDemoAppDelegateListenLogic alloc] init];
    self.listenLogic.listenDelegate = self;
}

#pragma mark - STDemoAppListenDelegate
- (void)amapLocationManagerDidChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    [self.viewLogic dealLocationAlertWithLocationAuthorizationStatus:status];
}

- (void)appUserManagerDidUpdateLoginState:(BOOL)loginState {
    [self.viewLogic dealRootViewControllerWithLoginState:loginState];
}

@end
