//
//  CJDemoAppDelegateLogicControl.m
//  CJStandardProjectDemo
//
//  Created by ciyouzen on 2018/8/29.
//  Copyright © 2018年 devlproad. All rights reserved.
//

#import "CJDemoAppDelegateLogicControl.h"
#import <CJBaseUtil/CJAppLastUtil.h>

@interface CJDemoAppDelegateLogicControl ()

@end


@implementation CJDemoAppDelegateLogicControl

- (instancetype)init {
    self = [super init];
    if (self) {
        [self startListen];
    }
    return self;
}

///开启监听
- (void)startListen {
    //监听User
    // ...
    
    //监听Location
    // ...
}

///获取启动时候的根视图控制器类型
- (CJDemoRootViewControllerType)getDidFinishLaunchingRootViewControllerType {
    if (![CJAppLastUtil isReadOverGuideWithDistinctAppVersion:NO]) {
        return CJDemoRootViewControllerTypeGuide;
        
    } else {
        if ([CJDemoServiceUserManager sharedInstance].hasLogin) {
            return CJDemoRootViewControllerTypeMain;
            
        } else {
            return CJDemoRootViewControllerTypeLogin;
        }
    }
}

///根据登录状态，处理根视图控制器
- (void)dealRootViewControllerWithLoginState:(BOOL)loginState {
    if ([self.didFinishLaunchingDelegate respondsToSelector:@selector(changeRootViewControllerWithType:)])
    {
        CJDemoRootViewControllerType rootViewControllerType = 0;
        if (loginState) {
            rootViewControllerType = CJDemoRootViewControllerTypeMain;
        } else {
            rootViewControllerType = CJDemoRootViewControllerTypeLogin;
        }
        [self.didFinishLaunchingDelegate changeRootViewControllerWithType:rootViewControllerType];
    }
}

///根据定位认证状态，处理定位权限弹窗问题
- (void)dealLocationAlertWithLocationAuthorizationStatus:(CLAuthorizationStatus)status {
    switch (status) {
        case kCLAuthorizationStatusAuthorizedAlways: {
            if ([self.didFinishLaunchingDelegate respondsToSelector:@selector(dismissLocationAllAlert)]) {
                [self.didFinishLaunchingDelegate dismissLocationAllAlert];
            }
            break;
        }
        case kCLAuthorizationStatusAuthorizedWhenInUse: {
            if ([self.didFinishLaunchingDelegate respondsToSelector:@selector(dismissLocationAllAlert)]) {
                [self.didFinishLaunchingDelegate dismissLocationAllAlert];
            }
            break;
        }
        case kCLAuthorizationStatusDenied: {
            if (![CJAppLastUtil isReadOverGuideWithDistinctAppVersion:NO] || ![CJDemoServiceUserManager sharedInstance].hasLogin) {
                return; //首次打开拒绝了定位不处理,没登录不处理
            }
            ///弹窗提示没有打开GPS，无法接单。
            if ([self.didFinishLaunchingDelegate respondsToSelector:@selector(showLocationNoOpenAlert)]) {
                [self.didFinishLaunchingDelegate showLocationNoOpenAlert];
            }
            break;
        }
        case kCLAuthorizationStatusRestricted: {
            if (![CJAppLastUtil isReadOverGuideWithDistinctAppVersion:NO] || ![CJDemoServiceUserManager sharedInstance].hasLogin) {
                return;//首次打开拒绝了定位不处理，,没登录不处理
            }
            if ([self.didFinishLaunchingDelegate respondsToSelector:@selector(showLocationAbnormalAlert)]) {
                [self.didFinishLaunchingDelegate showLocationAbnormalAlert];
            }
            break;
        }
        case kCLAuthorizationStatusNotDetermined: {
            break;
        }
        default:
            break;
    }
}

///定位权限改变了
- (void)changeLocationAuthorizationStatus:(CLAuthorizationStatus)currentStatus
                                     from:(CLAuthorizationStatus)fromStatus
{
    if (fromStatus != kCLAuthorizationStatusAuthorizedAlways ||
        fromStatus != kCLAuthorizationStatusAuthorizedWhenInUse)
    {
//        [[CJDemoServiceLocationManager sharedInstance] startUpdatingLocationForKey:@"Main" always:NO completed:^(CJDemoLocationErrorCode code) {
//            
//        }];
    }
}


#pragma mark - CJDemoServiceUserManagerListener

- (void)driverUserManager:(CJDemoServiceUserManager *)driverUserManager didUpdateLoginState:(BOOL)loginState {
    [self dealRootViewControllerWithLoginState:loginState];
    
    if ([self.listenDelegate respondsToSelector:@selector(appUserManagerDidUpdateLoginState:)]) {
        [self.listenDelegate appUserManagerDidUpdateLoginState:loginState];
    }
}


#pragma mark - CJDemoServiceLocationManagerListener

- (void)locationManager:(CJDemoServiceLocationManager *)manager didUpdateAuthorizationFromStatus:(CLAuthorizationStatus)fromStatus
{
    CLAuthorizationStatus status = manager.authorizationStatus;
    switch (status) {
        case kCLAuthorizationStatusAuthorizedAlways:
        case kCLAuthorizationStatusAuthorizedWhenInUse: {
            [self changeLocationAuthorizationStatus:status from:fromStatus];
            break;
        }
        default:
            break;
    }
    
    [self dealLocationAlertWithLocationAuthorizationStatus:status];
    
    
    if ([self.listenDelegate respondsToSelector:@selector(amapLocationManagerDidChangeAuthorizationStatus:)]) {
        [self.listenDelegate amapLocationManagerDidChangeAuthorizationStatus:status];
    }
}


@end
