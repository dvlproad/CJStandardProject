//
//  CJDemoServiceUserManager+Login.h
//  CJDemoServiceDemo
//
//  Created by ciyouzen on 2019/2/11.
//  Copyright © 2019 dvlproad. All rights reserved.
//

#import "CJDemoServiceUserManager.h"
#import <CJBaseUtil/CJAppLastUtil.h>
#import "CJDemoLoginRequest.h"

@interface CJDemoServiceUserManager (Login)

///登录
- (void)loginWithUserName:(NSString *)userName
                 password:(NSString *)password
                  success:(void (^)(DemoUser *user))success
                  failure:(void (^)(BOOL isRequestFailure, NSString *errorMessage))failure;

/// 注册
- (void)registerWithAccount:(NSString *)userName
                   password:(NSString *)password
                      email:(NSString *)email
                    success:(void (^)(BOOL registerSuccess, NSString *successMessage))success
                    failure:(void (^)(BOOL isRequestFailure, NSString *errorMessage))failure;

///"忘记密码，请求新密码请求"（string可以为手机号/邮箱/用户名）
- (void)getNewPasswordWithString:(NSString *)string
                         success:(void (^)(NSDictionary *responseDict))success
                         failure:(void (^)(NSError *error))failure;

///退出
- (void)logoutWithSuccess:(void (^)(NSDictionary *responseDict))success
                  failure:(void (^)(NSError *error))failure;

@end
