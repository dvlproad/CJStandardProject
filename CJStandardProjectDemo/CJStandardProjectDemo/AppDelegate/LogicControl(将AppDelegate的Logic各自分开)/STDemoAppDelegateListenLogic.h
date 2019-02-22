//
//  STDemoAppDelegateListenLogic.h
//  CJStandardProjectDemo
//
//  Created by ciyouzen on 2018/10/26.
//  Copyright © 2018年 devlproad. All rights reserved.
//
//  AppDelegate的所有监听业务处理

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

#import "CJDemoServiceUserManager.h"
#import "STDemoServiceLocationManager.h"

@protocol STDemoAppListenDelegate <NSObject>

@optional

- (void)listen_amapLocationManagerDidChangeAuthorizationStatus:(CLAuthorizationStatus)status;

- (void)listen_appUserManagerDidUpdateLoginState:(BOOL)loginState;

@end




@interface STDemoAppDelegateListenLogic : NSObject {
    
}
@property (nonatomic, weak) id<STDemoAppListenDelegate> listenDelegate;

///开启监听
- (void)startListen;

@end
