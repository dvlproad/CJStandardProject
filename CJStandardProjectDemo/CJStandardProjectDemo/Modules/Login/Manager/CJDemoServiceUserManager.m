//
//  CJDemoServiceUserManager.m
//  CJDemoModuleLoginDemo
//
//  Created by 李超前 on 2018/9/4.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "CJDemoServiceUserManager.h"
#import "CJDemoServiceUserManager+Network.h"

@implementation CJDemoServiceUserManager

+ (CJDemoServiceUserManager *)sharedInstance {
    static CJDemoServiceUserManager *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

#pragma mark - Session
/* 完整的描述请参见文件头部 */
- (void)setServiceUser:(DemoUser *)serviceUser {
    _serviceUser = serviceUser;
    
    if (serviceUser) {
        [CJDemoServiceUserManager updateLoginState:YES];
    } else {
        [CJDemoServiceUserManager updateLoginState:NO];
    }
}

/**
 *  更新登录状态（登录成功，退出的时候都需要调用）
 *
 *  @param isLogin 是否登录(YES:登录，NO:登出)
 */
+ (void)updateLoginState:(BOOL)isLogin {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setValue:@(isLogin) forKey:@"cj_autoLogin"];
    [userDefaults synchronize];
    
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter postNotificationName:kDemoNetworkSessionLoginStateDidChange object:@(isLogin)];
}



@end
