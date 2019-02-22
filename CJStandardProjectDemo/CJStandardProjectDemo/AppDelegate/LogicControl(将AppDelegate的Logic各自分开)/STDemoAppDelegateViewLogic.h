//
//  STDemoAppDelegateViewLogic.h
//  CJStandardProjectDemo
//
//  Created by ciyouzen on 2018/10/26.
//  Copyright © 2018年 devlproad. All rights reserved.
//
//  AppDelegate的所有视图业务处理

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

#import "CJDemoServiceUserManager.h"
#import "STDemoServiceLocationManager.h"

#import "STDemoRootViewControllerEnum.h" //启动页类型

@protocol STDemoAppDelegateViewLogicDelegate <NSObject>

@optional

///改变根视图控制器
- (void)changeRootViewControllerWithType:(STDemoRootViewControllerType)rootViewControllerType;

///显示定位权限没打开的alert
- (void)showLocationNoOpenAlert;

///显示定位权限异常的alert
- (void)showLocationAbnormalAlert;

///隐藏定位的所有alert
- (void)dismissLocationAllAlert;

@end




@interface STDemoAppDelegateViewLogic : NSObject {
    
}
@property (nonatomic, weak) id<STDemoAppDelegateViewLogicDelegate> viewLogicDelegate;

///获取启动时候的根视图控制器类型
- (STDemoRootViewControllerType)getDidFinishLaunchingRootViewControllerType;

///根据登录状态，处理根视图控制器
- (void)dealRootViewControllerWithLoginState:(BOOL)loginState;

///根据定位认证状态，处理定位权限弹窗问题
- (void)dealLocationAlertWithLocationAuthorizationStatus:(CLAuthorizationStatus)status;

///定位权限改变了
- (void)changeLocationAuthorizationStatus:(CLAuthorizationStatus)currentStatus
                                     from:(CLAuthorizationStatus)fromStatus;

@end
