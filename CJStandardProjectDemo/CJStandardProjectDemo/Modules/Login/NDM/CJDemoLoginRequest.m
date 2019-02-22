//
//  CJDemoLoginRequest.m
//  CJDemoServiceDemo
//
//  Created by ciyouzen on 2019/2/11.
//  Copyright © 2019 dvlproad. All rights reserved.
//

#import "CJDemoLoginRequest.h"

@implementation CJDemoLoginRequest

- (void)requestLoginWithAccount:(NSString *)account
                       password:(NSString *)password
                        success:(void (^)(CJResponseModel *responseModel))success
                        failure:(void (^)(BOOL isRequestFailure, NSString *errorMessage))failure
{
//    "userName": "dvlproad",
//    "userName": "Beyond",
//    "userName": "beyond",
//    "userName": "lichaoqian",
//    "userName": "test",
    NSString *apiName = @"user/login";
    NSDictionary *params = @{@"username" : account,
                             @"password" : password
                             };
    CJRequestSettingModel *settingModel = [[CJRequestSettingModel alloc] init];
    
    [[CJDemoNetworkClient sharedInstance] local2_postApi:apiName params:params settingModel:settingModel success:success failure:failure];
}

@end
