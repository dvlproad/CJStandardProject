//
//  DemoNetworkClient+Login.h
//  CJDemoModelDemo
//
//  Created by ciyouzen on 2017/11/26.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "DemoNetworkClient.h"
#import "DemoSession.h"

@interface DemoNetworkClient (Login)

///登录
- (void)requestLoginWithAccount:(NSString *)account
                       password:(NSString *)password
                        success:(void (^)(NSDictionary *responseDict))success
                        failure:(void (^)(NSError *error))failure;

///注册
- (void)requestRegisterWithAccount:(NSString *)account
                          password:(NSString *)password
                             email:(NSString *)email
                           success:(void (^)(NSDictionary *responseDict))success
                           failure:(void (^)(NSError *error))failure;

///"忘记密码，请求新密码请求"（string可以为手机号/邮箱/用户名）
- (void)requestNewPasswordWithString:(NSString *)string
                             success:(void (^)(NSDictionary *responseDict))success
                             failure:(void (^)(NSError *error))failure;

///退出
- (void)requestLogoutWithsuccess:(void (^)(NSDictionary *responseDict))success
                         failure:(void (^)(NSError *error))failure;


@end
