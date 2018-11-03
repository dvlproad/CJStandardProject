//
//  STDemoAppDelegateListenLogic.m
//  CJStandardProjectDemo
//
//  Created by ciyouzen on 2018/10/26.
//  Copyright © 2018年 devlproad. All rights reserved.
//

#import "STDemoAppDelegateListenLogic.h"
#import <CJBaseUtil/CJAppLastUtil.h>
#import "STDemoServiceUserManager.h"

@interface STDemoAppDelegateListenLogic ()

@end


@implementation STDemoAppDelegateListenLogic

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
    __weak typeof(self)weakSelf = self;
    [[STDemoServiceUserManager sharedInstance] addNotificationForUserLoginStateWithUsingBlock:^(BOOL isLogin) {
        if ([weakSelf.listenDelegate respondsToSelector:@selector(listen_appUserManagerDidUpdateLoginState:)]) {
            [weakSelf.listenDelegate listen_appUserManagerDidUpdateLoginState:isLogin];
        }
    }];
    
    //监听Location
    // ...
}

#pragma mark - STDemoServiceLocationManagerListener

- (void)locationManager:(STDemoServiceLocationManager *)manager didUpdateAuthorizationFromStatus:(CLAuthorizationStatus)fromStatus
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
    
    
    if ([self.listenDelegate respondsToSelector:@selector(listen_amapLocationManagerDidChangeAuthorizationStatus:)]) {
        [self.listenDelegate listen_amapLocationManagerDidChangeAuthorizationStatus:status];
    }
}

///定位权限改变了
- (void)changeLocationAuthorizationStatus:(CLAuthorizationStatus)currentStatus
                                     from:(CLAuthorizationStatus)fromStatus
{
    if (fromStatus != kCLAuthorizationStatusAuthorizedAlways ||
        fromStatus != kCLAuthorizationStatusAuthorizedWhenInUse)
    {
//        [[STDemoServiceLocationManager sharedInstance] startUpdatingLocationForKey:@"Main" always:NO completed:^(STDemoLocationErrorCode code) {
//
//        }];
    }
}

@end
