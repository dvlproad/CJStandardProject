//
//  CJDemoAppDelegateLogicControl.h
//  CJStandardProjectDemo
//
//  Created by ciyouzen on 2018/8/29.
//  Copyright © 2018年 devlproad. All rights reserved.
//
//  AppDelegate的所有业务处理

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

#import "CJDemoServiceUserManager.h"
#import "CJDemoServiceLocationManager.h"

/**
 *  启动页类型
 */
typedef NS_ENUM(NSUInteger, CJDemoRootViewControllerType) {
    CJDemoRootViewControllerTypeNone,
    CJDemoRootViewControllerTypeGuide = 1,  /**< 引导页 */
    CJDemoRootViewControllerTypeLogin,      /**< 登录页 */
    CJDemoRootViewControllerTypeMain,       /**< 主页 */
};


@protocol CJDemoAppDidFinishLaunchingDelegate <NSObject>

@optional

///改变根视图控制器
- (void)changeRootViewControllerWithType:(CJDemoRootViewControllerType)rootViewControllerType;

///显示定位权限没打开的alert
- (void)showLocationNoOpenAlert;

///显示定位权限异常的alert
- (void)showLocationAbnormalAlert;

///隐藏定位的所有alert
- (void)dismissLocationAllAlert;

@end



@protocol CJDemoAppListenDelegate <NSObject>

@optional

- (void)amapLocationManagerDidChangeAuthorizationStatus:(CLAuthorizationStatus)status;

- (void)appUserManagerDidUpdateLoginState:(BOOL)loginState;

@end




@interface CJDemoAppDelegateLogicControl : NSObject {
    
}
@property (nonatomic, weak) id<CJDemoAppDidFinishLaunchingDelegate> didFinishLaunchingDelegate;
@property (nonatomic, weak) id<CJDemoAppListenDelegate> listenDelegate;

///开启监听
- (void)startListen;

///获取启动时候的根视图控制器类型
- (CJDemoRootViewControllerType)getDidFinishLaunchingRootViewControllerType;

///根据登录状态，处理根视图控制器
- (void)dealRootViewControllerWithLoginState:(BOOL)loginState;

///根据定位认证状态，处理定位权限弹窗问题
- (void)dealLocationAlertWithLocationAuthorizationStatus:(CLAuthorizationStatus)status;

///定位权限改变了
- (void)changeLocationAuthorizationStatus:(CLAuthorizationStatus)currentStatus
                                     from:(CLAuthorizationStatus)fromStatus;

@end
