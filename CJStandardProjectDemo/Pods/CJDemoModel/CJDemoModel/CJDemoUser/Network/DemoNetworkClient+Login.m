//
//  DemoNetworkClient+Login.m
//  CJDemoModelDemo
//
//  Created by ciyouzen on 2017/11/26.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "DemoNetworkClient+Login.h"
#import <CJDemoNetwork/DemoHTTPSessionManager.h>

#import "ServiceUserDataSimulatorUtil.h"

#import <CJBaseUtil/CJAppLastUtil.h>


#import "DemoUserTableUtil.h"


@implementation DemoNetworkClient (SessionState)

- (void)requestLoginWithAccount:(NSString *)account
                       password:(NSString *)password
                        success:(void (^)(NSDictionary *responseDict))success
                        failure:(void (^)(NSError *error))failure
{
    void(^loginSuccessLastBlock)(id responseObject) = ^(id responseObject) {
        DemoUser *info = [ServiceUserDataSimulatorUtil getLoginUserInfoWithAccount:account password:password];
        [DemoUserTableUtil insertAccountInfo:info];
        
        [self doLoginSuccessCommonEventWithUser:info];
        
        if (success) {
            success(responseObject);
        }
    };
    
    
    void(^loginFailureLastBlock)(NSError * _Nonnull error) = ^(NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    };
    
    /*
    NSString *Url = API_BASE_Url_Health(@"login");
    NSDictionary *params = @{@"username" : account,
                             @"password" : password
                             };
    AFHTTPSessionManager *manager = [DemoHTTPSessionManager sharedInstance];
    [manager postRequestUrl:Url parameters:params progress:nil success:loginSuccessLastBlock failure:loginFailureLastBlock];
    //[self.indicatorView setAnimatingWithStateOfOperation:operation];
    //*/
    
    
    //测试用的,模拟网络请求
    [ServiceUserDataSimulatorUtil requestLoginWithAccount:account password:password success:loginSuccessLastBlock failure:loginFailureLastBlock];
}

///注册
- (void)requestRegisterWithAccount:(NSString *)account
                          password:(NSString *)password
                             email:(NSString *)email
                           success:(void (^)(NSDictionary *responseDict))success
                           failure:(void (^)(NSError *error))failure
{
    void(^loginSuccessLastBlock)(id responseObject) = ^(id responseObject) {
        NSArray<NSString *> *permissionIds = @[@"1000", @"10001"]; //服务器返回的权限
        DemoUser *info = [[DemoUser alloc] init];
        info.uid = account;
        info.name = account;
        info.pasd = password;
        info.email = email;
        info.auths = permissionIds;
        info.imageName = @"cjAvatar.png";
        info.sexType = SexTypeMan;
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        info.birthday = [dateFormatter dateFromString:@"1989-12-27"];
        [DemoUserTableUtil insertAccountInfo:info];
        
        [self doLoginSuccessCommonEventWithUser:info];
        
        if (success) {
            success(responseObject);
        }
    };
    
    
    void(^loginFailureLastBlock)(NSError * _Nonnull error) = ^(NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    };
    
    /*
    NSString *Url = API_BASE_Url_Health(@"user/register");
    NSDictionary *params = @{@"mail": email,
                             @"name": account,
                             @"pass": password,
//                             @"language": @"zh-hans"
                             };
    AFHTTPSessionManager *manager = [DemoHTTPSessionManager sharedInstance];
    [manager postRequestUrl:Url parameters:params progress:nil success:loginSuccessLastBlock failure:loginFailureLastBlock];
    //*/
    
    //测试用的,模拟网络请求
    [ServiceUserDataSimulatorUtil requestRegisterWithAccount:account password:password email:email success:loginSuccessLastBlock failure:loginFailureLastBlock];
}


///通过了邮件请求更新密码
- (void)requestNewPasswordWithString:(NSString *)string
                             success:(void (^)(NSDictionary *responseDict))success
                             failure:(void (^)(NSError *error))failure
{
    /*
    NSString *Url = API_BASE_Url_Health(@"user/request_new_password");
    NSDictionary *params = @{@"name": string};
    AFHTTPSessionManager *manager = [DemoHTTPSessionManager sharedInstance];
    [manager postRequestUrl:Url parameters:params progress:nil success:^(id responseObject) {
        if (success) {
            success(task, responseObject);
        }
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"获取失败");
        failure(task, error);
    }];
    //    [self.indicatorView setAnimatingWithStateOfOperation:operation];
    */
    
    [ServiceUserDataSimulatorUtil requestNewPasswordWithString:string success:success failure:failure];
}

///退出
- (void)requestLogoutWithsuccess:(void (^)(NSDictionary *responseDict))success
                         failure:(void (^)(NSError *error))failure
{
    void(^logoutSuccessLastBlock)(id responseObject) = ^(id responseObject) {
        DemoUser *user = [DemoSession currentUser];
        
        [self doLogoutSuccessCommonEventWithUser:user];
        
        if (success) {
            success(responseObject);
        }
    };
    
    
    void(^logoutFailureLastBlock)(NSError * _Nonnull error) = ^(NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    };
    
    
    /*
     NSString *Url = API_BASE_Url_Health(@"user/logout");
     NSDictionary *params = nil;
     AFHTTPSessionManager *manager = [DemoHTTPSessionManager sharedInstance];
     [manager postRequestUrl:Url parameters:params progress:nil success:logoutSuccessLastBlock failure:logoutFailureLastBlock];
     //*/
    [ServiceUserDataSimulatorUtil requestLogoutWithAccount:nil success:logoutSuccessLastBlock failure:logoutFailureLastBlock];
}

//登录成功后，要执行的基本操作(服务器基本上回返回用户的一些基本信息)
- (void)doLoginSuccessCommonEventWithUser:(DemoUser *)info {
    [DemoSession sharedInstance].user = [info copy];
    
    [DemoUserTableUtil insertAccountInfo:info];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setValue:@(YES) forKey:@"cj_autoLogin"];
    [userDefaults synchronize];
    
    [CJAppLastUtil saveAccount:info.name withPassword:info.pasd];
    
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter postNotificationName:kDemoNetworkSessionLoginStateDidChange object:@(YES)];
}

//退出成功后，要执行的基本操作
- (void)doLogoutSuccessCommonEventWithUser:(DemoUser *)info {
    //NSLog(@"退出成功需要执行的一些基本设置");
    [DemoSession sharedInstance].user = nil;
    
    //将自动登录设为NO
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setValue:@(NO) forKey:@"cj_autoLogin"];
    [userDefaults synchronize];
    //[CJAppLastUtil deleteAccountFromKeychain:loginUid];
    
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter postNotificationName:kDemoNetworkSessionLoginStateDidChange object:@(NO)];
}

@end
