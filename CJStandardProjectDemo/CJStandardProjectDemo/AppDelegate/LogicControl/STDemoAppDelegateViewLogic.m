//
//  STDemoAppDelegateViewLogic.m
//  CJStandardProjectDemo
//
//  Created by ciyouzen on 2018/10/26.
//  Copyright © 2018年 devlproad. All rights reserved.
//

#import "STDemoAppDelegateViewLogic.h"
#import <CJBaseUtil/CJAppLastUtil.h>

@interface STDemoAppDelegateViewLogic ()

@end


@implementation STDemoAppDelegateViewLogic

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}


///获取启动时候的根视图控制器类型
- (STDemoRootViewControllerType)getDidFinishLaunchingRootViewControllerType {
    if (![CJAppLastUtil isReadOverGuideWithDistinctAppVersion:NO]) {
        return STDemoRootViewControllerTypeGuide;
        
    } else {
        if ([STDemoServiceUserManager sharedInstance].hasLogin) {
            return STDemoRootViewControllerTypeMain;
            
        } else {
            return STDemoRootViewControllerTypeLogin;
        }
    }
}

///根据登录状态，处理根视图控制器
- (void)dealRootViewControllerWithLoginState:(BOOL)loginState {
    if ([self.viewLogicDelegate respondsToSelector:@selector(changeRootViewControllerWithType:)])
    {
        STDemoRootViewControllerType rootViewControllerType = 0;
        if (loginState) {
            rootViewControllerType = STDemoRootViewControllerTypeMain;
        } else {
            rootViewControllerType = STDemoRootViewControllerTypeLogin;
        }
        [self.viewLogicDelegate changeRootViewControllerWithType:rootViewControllerType];
    }
}

///根据定位认证状态，处理定位权限弹窗问题
- (void)dealLocationAlertWithLocationAuthorizationStatus:(CLAuthorizationStatus)status {
    switch (status) {
        case kCLAuthorizationStatusAuthorizedAlways: {
            if ([self.viewLogicDelegate respondsToSelector:@selector(dismissLocationAllAlert)]) {
                [self.viewLogicDelegate dismissLocationAllAlert];
            }
            break;
        }
        case kCLAuthorizationStatusAuthorizedWhenInUse: {
            if ([self.viewLogicDelegate respondsToSelector:@selector(dismissLocationAllAlert)]) {
                [self.viewLogicDelegate dismissLocationAllAlert];
            }
            break;
        }
        case kCLAuthorizationStatusDenied: {
            if (![CJAppLastUtil isReadOverGuideWithDistinctAppVersion:NO] || ![STDemoServiceUserManager sharedInstance].hasLogin) {
                return; //首次打开拒绝了定位不处理,没登录不处理
            }
            ///弹窗提示没有打开GPS，无法接单。
            if ([self.viewLogicDelegate respondsToSelector:@selector(showLocationNoOpenAlert)]) {
                [self.viewLogicDelegate showLocationNoOpenAlert];
            }
            break;
        }
        case kCLAuthorizationStatusRestricted: {
            if (![CJAppLastUtil isReadOverGuideWithDistinctAppVersion:NO] || ![STDemoServiceUserManager sharedInstance].hasLogin) {
                return;//首次打开拒绝了定位不处理，,没登录不处理
            }
            if ([self.viewLogicDelegate respondsToSelector:@selector(showLocationAbnormalAlert)]) {
                [self.viewLogicDelegate showLocationAbnormalAlert];
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
//        [[STDemoServiceLocationManager sharedInstance] startUpdatingLocationForKey:@"Main" always:NO completed:^(STDemoLocationErrorCode code) {
//            
//        }];
    }
}

@end
