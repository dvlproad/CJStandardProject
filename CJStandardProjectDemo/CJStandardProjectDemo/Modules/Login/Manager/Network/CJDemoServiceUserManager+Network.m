//
//  CJDemoServiceUserManager+Network.m
//  CJStandardProjectDemo
//
//  Created by 李超前 on 2018/9/6.
//  Copyright © 2018年 devlproad. All rights reserved.
//

#import "CJDemoServiceUserManager+Network.h"

#import "ServiceUserDataSimulatorUtil.h"

@implementation CJDemoServiceUserManager (Network)

#pragma mark - Network
///登录
- (void)requestLoginWithAccount:(NSString *)account
                       password:(NSString *)password
                        success:(void (^)(NSDictionary *responseDict))success
                        failure:(void (^)(NSError *error))failure
{
#ifndef CJUseSimulatorServiceUserData
    NSString *Url = [DemoNetworkClient mainUrlWithApiSuffix:@"user/login"];
    NSDictionary *params = @{@"username" : account,
                             @"password" : password
                             };
    [[DemoNetworkClient sharedInstance] demo_postUrl:Url params:params progress:nil success:success failure:failure];
#else
    [ServiceUserDataSimulatorUtil requestLoginWithAccount:account password:password success:success failure:failure];//测试用的,模拟网络请求
#endif
}

///注册
- (void)requestRegisterWithAccount:(NSString *)account
                          password:(NSString *)password
                             email:(NSString *)email
                           success:(void (^)(NSDictionary *responseDict))success
                           failure:(void (^)(NSError *error))failure
{
#ifndef CJUseSimulatorServiceUserData
    NSString *Url = [DemoNetworkClient mainUrlWithApiSuffix:@"user/register"];
    NSDictionary *params = @{@"username" : account,
                             @"password" : password,
                             @"mail": email,
                             };
    [[DemoNetworkClient sharedInstance] demo_postUrl:Url params:params progress:nil success:success failure:failure];
#else
    //测试用的,模拟网络请求
    [ServiceUserDataSimulatorUtil requestRegisterWithAccount:account password:password email:email success:success failure:failure];
#endif
}


///通过了邮件请求更新密码
- (void)requestNewPasswordWithString:(NSString *)string
                             success:(void (^)(NSDictionary *responseDict))success
                             failure:(void (^)(NSError *error))failure
{
#ifndef CJUseSimulatorServiceUserData
    NSString *Url = [DemoNetworkClient mainUrlWithApiSuffix:@"user/request_new_password"];
    NSDictionary *params = @{@"name": string
                             };
    [[DemoNetworkClient sharedInstance] demo_postUrl:Url params:params progress:nil success:success failure:failure];
#else
    [ServiceUserDataSimulatorUtil requestNewPasswordWithString:string success:success failure:failure];
#endif
}

///退出
- (void)requestLogoutUid:(NSString *)uid
                 success:(void (^)(NSDictionary *responseDict))success
                 failure:(void (^)(NSError *error))failure
{
#ifndef CJUseSimulatorServiceUserData
    NSString *Url = [DemoNetworkClient mainUrlWithApiSuffix:@"user/logout"];
    NSDictionary *params = @{@"uid" : uid,
                             };
    [[DemoNetworkClient sharedInstance] demo_postUrl:Url params:params progress:nil success:success failure:failure];
#else
    [ServiceUserDataSimulatorUtil requestLogoutWithAccount:nil success:success failure:failure];
#endif
}


@end
