//
//  CJDemoServiceUserManager+Network.m
//  CJStandardProjectDemo
//
//  Created by ciyouzen on 2018/9/6.
//  Copyright © 2018年 devlproad. All rights reserved.
//

#import "CJDemoServiceUserManager+Network.h"
#import <CJBaseUtil/CJAppLastUtil.h>
#import "CJDemoServiceUserManager+UserTable.h"

@implementation CJDemoServiceUserManager (Network)

#pragma mark - Network
///登录
- (void)requestLoginWithAccount:(NSString *)account
                       password:(NSString *)password
                        success:(void (^)(DemoUser *user))success
                        failure:(void (^)(NSString *errorMessage))failure
{
    NSString *apiName = @"/user/login";
    NSDictionary *params = @{@"username" : account,
                             @"password" : password
                             };
    
//#ifndef CJUseSimulatorServiceUserData
//     [[CJDemoNetworkClient sharedInstance] cjDemo_postApi
//#else   //测试用的,模拟网络请求
     [[CJDemoNetworkClient sharedInstance] local_postApi
//#endif
      :apiName params:params encrypt:YES success:^(CJDemoResponseModel *responseModel) {
        NSInteger status = responseModel.status;
        if (status == 1 && [responseModel.result[@"code"] integerValue] == 0) {
            // 登录成功
            NSDictionary *userDictionary = responseModel.result;
            DemoUser *user = [[DemoUser alloc] initWithUserDictionary:userDictionary];
            
            // 更新serviceUser
            NSString *oldUserId = self.serviceUser.uid;
            self.serviceUser = user;
            NSString *newUserId = self.serviceUser.uid;
            
            // 更新网络库配置
            [[CJDemoNetworkClient sharedInstance].specificCommonParams setObject:user.uid forKey:@"uid"];
            
            // 存储用于自动登录的信息
            [CJAppLastUtil saveAccount:user.uid withAccessToken:user.userToken];
            
            // 数据库存储用户信息
            [[CJDemoServiceUserManager sharedInstance] insertAccountInfo:user];
            
            //  登录状态发生改变
            if (!oldUserId && newUserId) { //登录了
                [CJDemoServiceUserManager updateLoginState:YES];
                
            } else if (oldUserId && !newUserId) { //退出了
                [CJDemoServiceUserManager updateLoginState:NO];
            }
            
            // 发送用户数据变化的通知
            // 略过
            
            
            !success ?: success(user);
            
        } else {
            NSString *loginFailureMessage = responseModel.message;
            // 失败回调
            !failure ?: failure(loginFailureMessage);
        }

    } failure:^(NSString *errorMessage) {
        !failure ?: failure(errorMessage);
    }];
}

///注册
- (void)requestRegisterWithAccount:(NSString *)account
                          password:(NSString *)password
                             email:(NSString *)email
                           success:(void (^)(CJDemoResponseModel *responseModel))success
                           failure:(void (^)(NSString *errorMessage))failure
{
    NSString *apiName = @"/user/register";
    NSDictionary *params = @{@"username" : account,
                             @"password" : password,
                             @"mail": email,
                             };
    
     [[CJDemoNetworkClient sharedInstance] local_postApi:apiName params:params encrypt:YES success:success failure:failure];
}


///通过了邮件请求更新密码
- (void)requestNewPasswordWithEmail:(NSString *)email
                            success:(void (^)(CJDemoResponseModel *responseModel))success
                            failure:(void (^)(NSString *errorMessage))failure
{
    NSString *apiName = @"/user/request_new_password";
    NSDictionary *params = @{@"email" : email,
                             };
    
    [[CJDemoNetworkClient sharedInstance] local_postApi:apiName params:params encrypt:YES success:success failure:failure];
}

///退出
- (void)requestLogoutWithSuccess:(void (^)(CJDemoResponseModel *responseModel))success
                 failure:(void (^)(NSString *errorMessage))failure
{
    NSString *apiName = @"/user/logout";
    NSDictionary *params = @{@"uid" : self.serviceUser.uid,
                             };
    
    [[CJDemoNetworkClient sharedInstance] local_postApi:apiName params:params encrypt:YES success:success failure:failure];
}


@end
