//
//  CJDemoServiceUserManager+Login.m
//  CJDemoServiceDemo
//
//  Created by ciyouzen on 2019/2/11.
//  Copyright © 2019 dvlproad. All rights reserved.
//

#import "CJDemoServiceUserManager+Login.h"
#import "CJDemoDatabase+User.h"

@implementation CJDemoServiceUserManager (Login)

///登录
- (void)loginWithUserName:(NSString *)userName
                 password:(NSString *)password
                  success:(void (^)(DemoUser *user))success
                  failure:(void (^)(BOOL isRequestFailure, NSString *errorMessage))failure
{
    CJDemoLoginRequest *loginRequest = [[CJDemoLoginRequest alloc] init];
    [loginRequest requestLoginWithAccount:userName password:password success:^(CJResponseModel * _Nonnull responseModel) {
        
        NSInteger statusCode = responseModel.statusCode;
        if (statusCode == 1) {
            //  登录成功
            NSDictionary *result = responseModel.result;
            DemoUser *user = [[DemoUser alloc] initWithUserDictionary:result];
            
            //登录成功后，要执行的基本操作(服务器基本上回返回用户的一些基本信息)
            //需要管理监控"服务的用户"的信息变化，所以先通过单例，放在内存中管理，同时支持数据库管理；
            //其他，如需要管理监控"服务的订单表"的信息变化，也是一样的处理放啊。
            //self.serviceUser = [user copy];
            self.serviceUser = user;
            [[CJDemoDatabase sharedInstance] insertAccountInfo:user];
            [CJAppLastUtil saveAccount:user.name withAccessToken:user.pasd];
            
            !success ?: success(self.serviceUser);
        }
        
        
    } failure:^(BOOL isRequestFailure, NSString * _Nonnull errorMessage) {
        !failure ?: failure(isRequestFailure, errorMessage);
    }];
    //*/
}

/// 注册
- (void)registerWithAccount:(NSString *)userName
                   password:(NSString *)password
                      email:(NSString *)email
                    success:(void (^)(BOOL registerSuccess, NSString *successMessage))success
                    failure:(void (^)(BOOL isRequestFailure, NSString *errorMessage))failure
{
    NSString *apiName = @"user/register";
    NSDictionary *params = @{@"mail": email,
                             @"name": userName,
                             @"pass": password,
                             //@"language": @"zh-hans"
                             };
    CJRequestSettingModel *settingModel = [[CJRequestSettingModel alloc] init];
    
    [[CJDemoNetworkClient sharedInstance] local2_postApi:apiName params:params settingModel:settingModel success:^(CJResponseModel *responseModel) {
        NSArray<NSString *> *permissionIds = @[@"1000", @"10001"]; //服务器返回的权限
        DemoUser *user = [[DemoUser alloc] init];
        user.uid = userName;
        user.name = userName;
        user.pasd = password;
        user.email = email;
        user.auths = permissionIds;
        user.imageName = @"cjAvatar.png";
        user.sexType = SexTypeMan;
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        user.birthday = [dateFormatter dateFromString:@"1989-12-27"];
        
        [CJDemoServiceUserManager sharedInstance].serviceUser = [user copy];
        [[CJDemoDatabase sharedInstance] insertAccountInfo:user];
        
        !success ?: success(YES, NSLocalizedString(@"注册成功", nil));
        
    } failure:^(BOOL isRequestFailure, NSString *errorMessage) {
        !failure ?: failure(isRequestFailure, errorMessage);
    }];
}

///"忘记密码，请求新密码请求"（string可以为手机号/邮箱/用户名）
- (void)getNewPasswordWithString:(NSString *)string
                         success:(void (^)(NSDictionary *responseDict))success
                         failure:(void (^)(NSError *error))failure {
    NSString *apiName = @"user/forgetpassword";
    NSDictionary *params = @{@"name": string
                             };
    CJRequestSettingModel *settingModel = [[CJRequestSettingModel alloc] init];
    
    [[CJDemoNetworkClient sharedInstance] local2_postApi:apiName params:params settingModel:settingModel success:^(CJResponseModel *responseModel) {
        
        if (success) {
            success(nil);
        }
        
    } failure:^(BOOL isRequestFailure, NSString *errorMessage) {
        if (failure) {
            failure(nil);
        }
    }];
}

///退出
- (void)logoutWithSuccess:(void (^)(NSDictionary *responseDict))success
                  failure:(void (^)(NSError *error))failure {
    NSString *apiName = @"user/logout";
    NSDictionary *params = @{@"mail": @"",
                             @"name": @"",
                             };
    CJRequestSettingModel *settingModel = [[CJRequestSettingModel alloc] init];
    
    [[CJDemoNetworkClient sharedInstance] local2_postApi:apiName params:params settingModel:settingModel success:^(CJResponseModel *responseModel) {
        
        if (success) {
            success(nil);
        }
        
    } failure:^(BOOL isRequestFailure, NSString *errorMessage) {
        if (failure) {
            failure(nil);
        }
    }];
}


@end
