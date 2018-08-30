//
//  ServiceUserDataSimulatorUtil.h
//  CJDemoModelDemo
//
//  Created by ciyouzen on 2017/11/20.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DemoUser.h"

@interface ServiceUserDataSimulatorUtil : NSObject

///模拟网络"登录请求"
+ (void)requestLoginWithAccount:(NSString *)account
                       password:(NSString*)password
                        success:(void (^)(NSDictionary *responseDict))loginSuccessLastBlock
                        failure:(void (^)(NSError *error))loginFailureLastBlock;

///模拟网络"注册请求"
+ (void)requestRegisterWithAccount:(NSString *)account
                          password:(NSString *)password
                             email:(NSString *)email
                           success:(void (^)(NSDictionary *responseDict))registerSuccessLastBlock
                           failure:(void (^)(NSError *error))registerFailureLastBlock;

///模拟网络"退出请求"
+ (void)requestLogoutWithAccount:(NSString *)account
                         success:(void (^)(NSDictionary *responseDict))logoutSuccessLastBlock
                         failure:(void (^)(NSError *error))logoutFailureLastBlock;

///模拟网络"忘记密码，请求新密码请求"（string可以为手机号/邮箱/用户名）
+ (void)requestNewPasswordWithString:(NSString *)string
                              success:(void (^)(NSDictionary *responseDict))success
                              failure:(void (^)(NSError *error))failure;


+ (DemoUser *)getLoginUserInfoWithAccount:(NSString *)account password:(NSString *)password;

@end
