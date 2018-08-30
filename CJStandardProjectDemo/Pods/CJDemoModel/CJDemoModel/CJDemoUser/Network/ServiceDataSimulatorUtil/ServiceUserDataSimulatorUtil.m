//
//  ServiceUserDataSimulatorUtil.m
//  CJDemoModelDemo
//
//  Created by ciyouzen on 2017/11/20.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "ServiceUserDataSimulatorUtil.h"
#import <CJBaseUtil/CJAppLastUtil.h>

@implementation ServiceUserDataSimulatorUtil : NSObject

+ (void)requestLoginWithAccount:(NSString *)account
                       password:(NSString*)password
                        success:(void (^)(NSDictionary *responseDict))loginSuccessLastBlock
                        failure:(void (^)(NSError *error))loginFailureLastBlock
{
    //测试用的,模拟网络请求
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(1);  //模拟网络请求时间
        
        NSString *correctPassword = [CJAppLastUtil getKeychainPasswordForAccount:account];
        BOOL isPasswordCorrect = [password isEqualToString:correctPassword] || [password isEqualToString:DemoGeneralPassword];
        if (!isPasswordCorrect) {
            dispatch_async(dispatch_get_main_queue(), ^{
                loginFailureLastBlock(nil);
            });
            
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                loginSuccessLastBlock(nil);
            });
            
        }
    });
}

+ (void)requestRegisterWithAccount:(NSString *)account
                          password:(NSString *)password
                             email:(NSString *)email
                           success:(void (^)(NSDictionary *responseDict))registerSuccessLastBlock
                           failure:(void (^)(NSError *error))registerFailureLastBlock
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(1);  //模拟网络请求时间
        
        BOOL isUserExist = [CJAppLastUtil isKeychainContainAccount:account];
        if (!isUserExist) {
            dispatch_async(dispatch_get_main_queue(), ^{
                registerSuccessLastBlock(nil);
            });
            
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                registerFailureLastBlock(nil);
            });
            
        }
    });
}


+ (void)requestLogoutWithAccount:(NSString *)account
                         success:(void (^)(NSDictionary *responseDict))logoutSuccessLastBlock
                         failure:(void (^)(NSError *error))logoutFailureLastBlock
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(1);  //模拟网络请求时间
        
        BOOL logoutSuccess = rand()%2;
        logoutSuccess = YES;
        if (logoutSuccess) {
            dispatch_async(dispatch_get_main_queue(), ^{
                logoutSuccessLastBlock(nil);
            });
            
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                logoutFailureLastBlock(nil);
            });
            
        }
    });
}

+ (void)requestNewPasswordWithString:(NSString *)string
                            success:(void (^)(NSDictionary *responseDict))success
                            failure:(void (^)(NSError *error))failure
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(1);  //模拟网络请求时间
        
        BOOL isUserExist = [CJAppLastUtil isKeychainContainAccount:string];
        if (isUserExist) {
            dispatch_async(dispatch_get_main_queue(), ^{
                success(nil);
            });
            
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                failure(nil);
            });
            
        }
    });
}



//模拟从服务器获取数据--登录
+ (DemoUser *)getLoginUserInfoWithAccount:(NSString *)account password:(NSString *)password {
    DemoUser *user = nil;
    //    user = [DemoUserTableUtil selectAccountInfoWhereUID:account];
    //    if (user == nil) {
    user = [self testAccountWithAccount:account password:password];
    //    }
    
    return user;
}

+ (DemoUser *)testAccountWithAccount:(NSString *)account password:(NSString *)password {
    if ([account isEqualToString:@"lichaoqian"]) {
        NSArray<NSString *> *permissionIds = @[@"1000", @"10001"]; //服务器返回的权限
        DemoUser *info = [[DemoUser alloc] init];
        info.uid = @"dvlproad@163.com";
        info.name = @"lichaoqian";
        info.pasd = @"123456";
        info.email = [NSString stringWithFormat:@"dvlproad@163.com"];
        info.auths = permissionIds;
        info.sexType = SexTypeMan;
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        info.birthday = [dateFormatter dateFromString:@"1989-12-27"];
        
        info.imName = @"lichaoqian";
        info.imPassword = @"123456";
        
        return info;
        
    } else {
        NSArray<NSString *> *permissionIds = @[@"1000", @"10001"]; //服务器返回的权限
        DemoUser *info = [[DemoUser alloc] init];
        info.uid = account;
        info.name = account;
        info.pasd = password;
        info.email = [NSString stringWithFormat:@"%@@beyond.com", account];
        info.auths = permissionIds;
        info.sexType = SexTypeMan;
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        info.birthday = [dateFormatter dateFromString:@"1989-12-27"];
        
        if ([account isEqualToString:@"lichaoqian"] ||
            [account isEqualToString:@"beyond"] ||
            [account isEqualToString:@"Beyond"] ||
            [account isEqualToString:@"dvlproad"])
        {
            info.imName = account;
            info.imPassword = @"123456";
        } else {
            info.imName = @"test";
            info.imPassword = @"123456";
        }
        
        return info;
    }
}


@end
