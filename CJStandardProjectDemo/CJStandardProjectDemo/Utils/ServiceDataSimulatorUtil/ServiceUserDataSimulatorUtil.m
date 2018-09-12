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
                        success:(void (^)(NSDictionary *responseDict))success
                        failure:(void (^)(NSError *error))failure
{
    /*
     id mockConnection = OCMClassMock([CJDemoServiceUserManager class]);
     //    controller.connection = mockConnection;
     //    id mockConnection = [CJDemoServiceUserManager sharedInstance];
     OCMStub([mockConnection sharedInstance]).andReturn(mockConnection);
     
     //模拟登录成功返回的result
     // 1. stub using OCMock andDo: operator.
     OCMStub([[CJDemoServiceUserManager sharedInstance] requestLoginWithAccount:account password:password success:[OCMArg any] failure:[OCMArg any]]).andDo((^(NSInvocation *invocation) {
     //2. declare a block with same signature
     void (^successBlock)(NSDictionary *dict);
     //3. link argument 3 with with our block callback
     [invocation getArgument:&successBlock atIndex:4];
     
     //4. invoke block with pre-defined input
     NSDictionary *testResponse = @{@"status":   @(0),
     @"message":  @"恭喜您登录成功",
     @"result":   @{@"uid":  @"dvlproad@163.com",
     @"userName": @"lichaoqian",
     @"pasd": @"123456",
     @"email": @"dvlproad@163.com",
     @"auths": @[@"1000", @"10001"],
     @"sex": @(0),
     @"birthday":@"1989-12-27",
     
     @"imName": @"lichaoqian",
     @"imPassword": @"123456"
     }
     };
     successBlock(testResponse);
     }));
     */
    
    //测试用的,模拟网络请求
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(1);  //模拟网络请求时间
        
        NSString *correctPassword = [CJAppLastUtil getKeychainPasswordForAccount:account];
        BOOL isPasswordCorrect = [password isEqualToString:correctPassword] || [password isEqualToString:DemoGeneralPassword];
        if (!isPasswordCorrect) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (failure) {
                    failure(nil);
                }
            });
            
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSDictionary *testResponse = [ServiceUserDataSimulatorUtil testLoginResponseForAccount:account password:password];
                
                if (success) {
                    success(testResponse);
                }
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
//+ (DemoUser *)getLoginUserInfoWithAccount:(NSString *)account password:(NSString *)password {
//    DemoUser *user = nil;
//    //    user = [DemoUserTableUtil selectAccountInfoWhereUID:account];
//    //    if (user == nil) {
//    NSDictionary *testResponse = [self testLoginResponseForAccount:account password:password];
//    //    }
//
//    return user;
//}

+ (NSDictionary *)testLoginResponseForAccount:(NSString *)account password:(NSString *)password {
    NSString *imName = nil;
    NSString *imPassword = nil;
    if ([account isEqualToString:@"lichaoqian"] ||
        [account isEqualToString:@"beyond"] ||
        [account isEqualToString:@"Beyond"] ||
        [account isEqualToString:@"dvlproad"]) {
        imName = account;
        imPassword = @"123456";
        
    } else {
        imName = @"test";
        imPassword = @"123456";
    }
    
    NSString *email = [NSString stringWithFormat:@"%@@163.com", account];
    NSDictionary *testResponse = @{@"status":   @(0),
                                   @"message":  @"恭喜您登录成功",
                                   @"result":   @{@"uid":  account,
                                                  @"name": account,
                                                  @"userToken": password,
                                                  @"email": email,
                                                  @"auths": @[@"1000", @"10001"],
                                                  @"sexType": @(0),
                                                  @"birthday":@"1989-12-27",
                                                  
                                                  @"imName": imName,
                                                  @"imPassword": imPassword
                                                  }
                                   };
    return testResponse;
}


@end
