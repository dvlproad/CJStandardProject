//
//  STDemoServiceUserManager+Network.h
//  CJStandardProjectDemo
//
//  Created by ciyouzen on 2018/9/6.
//  Copyright © 2018年 devlproad. All rights reserved.
//

#import "STDemoServiceUserManager.h"
#import <CJDemoNetwork/CJDemoNetworkClient.h>

@interface STDemoServiceUserManager (Network)

#pragma mark - Network
///登录
- (void)requestLoginWithAccount:(NSString *)account
                       password:(NSString *)password
                        success:(void (^)(STDemoUser *user))success
                        failure:(void (^)(NSString *errorMessage))failure;

///注册
- (void)requestRegisterWithAccount:(NSString *)account
                          password:(NSString *)password
                             email:(NSString *)email
                           success:(void (^)(CJDemoResponseModel *responseModel))success
                           failure:(void (^)(NSString *errorMessage))failure;


///通过了邮件请求更新密码
- (void)requestNewPasswordWithEmail:(NSString *)email
                            success:(void (^)(CJDemoResponseModel *responseModel))success
                            failure:(void (^)(NSString *errorMessage))failure;

///退出
- (void)requestLogoutWithSuccess:(void (^)(CJDemoResponseModel *responseModel))success
                         failure:(void (^)(NSString *errorMessage))failure;

@end
