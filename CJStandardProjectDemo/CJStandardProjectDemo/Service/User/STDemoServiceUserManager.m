//
//  STDemoServiceUserManager.m
//  STDemoModuleLoginDemo
//
//  Created by ciyouzen on 2018/9/4.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "STDemoServiceUserManager.h"
#import <CJBaseUtil/CJAppLastUtil.h>
#import "STDemoServiceUserManager+Network.h"

static NSString * const kSTDemoNotificationUserLoginState = @"STDemoNotificationUserLoginState";

@implementation STDemoServiceUserManager

+ (STDemoServiceUserManager *)sharedInstance {
    static STDemoServiceUserManager *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        CJAppLastUser *user = [CJAppLastUtil getLastLoginUser];
        if (user && !isEmptyObjectCJHelper(user.lastLoginAccessToken) ) {
            _serviceUser = [[STDemoUser alloc] init];
            _serviceUser.userName = user.lastLoginUserName;
            _serviceUser.userToken = user.lastLoginAccessToken;
            ///FIXME:获取上次的信息
//            NSData *data = [[NSUserDefaults standardUserDefaults] dataForKey:@"user_archive"];
//            if (data) {
//                STDemoUser *user = [NSKeyedUnarchiver unarchiveObjectWithData:data];
//                if (user) {
//                    [_serviceUser updateIvarsWithModel:user];
//                }
//            }
        }
    }
    return self;
}

- (BOOL)hasLogin {
    return self.serviceUser.userToken ? YES : NO;
}

/// 退出登录
- (void)logoutWithCompleteBlock:(void(^)(void))completeBlock {
    // 模拟退出登录清楚
    __weak typeof(self)weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        weakSelf.serviceUser = nil;
        [weakSelf pushNotificationForUserLoginState:NO];
        
        if (completeBlock) {
            completeBlock();
        }
    });
}

/**
 *  更新并发送登录状态（登录成功，退出的时候都需要调用）
 *
 *  @param isLogin 是否登录(YES:登录，NO:登出)
 */
- (void)pushNotificationForUserLoginState:(BOOL)isLogin {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setValue:@(isLogin) forKey:@"cj_autoLogin"];
    [userDefaults synchronize];
    
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter postNotificationName:kSTDemoNotificationUserLoginState object:@(isLogin)];
}

/// 添加监听登录状态
- (id)addNotificationForUserLoginStateWithUsingBlock:(void (^)(BOOL isLogin))block {
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(locationChange:) name:kSTDemoNotificationUserLoginState object:nil];
    id loginStateObserver = [[NSNotificationCenter defaultCenter] addObserverForName:kSTDemoNotificationUserLoginState object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        id object = [note object];
        BOOL isLogin = [object boolValue];
        if (block) {
            block(isLogin);
        }
    }];
    return loginStateObserver;
}

/// 移除监听登录状态
- (void)removeNotificationForUserLoginState:(id)observer {
    [[NSNotificationCenter defaultCenter] removeObserver:observer];
    observer = nil;
}


@end
