//
//  DemoHTTPSessionManager.m
//  CJNetworkDemo
//
//  Created by ciyouzen on 2016/12/20.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "DemoHTTPSessionManager.h"

@implementation DemoHTTPSessionManager

+ (AFHTTPSessionManager *)sharedInstance {
    static AFHTTPSessionManager *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [self createSessionManager];
    });
    
    /*
     //登录成功后，有session，添加适当的token
     if ([[BBXPassengerSession current].nid length] > 0) {
     [[_sharedInstance requestSerializer] setValue:[BBXPassengerSession current].nid forHTTPHeaderField:@"sid"];
     }
     
     if ([BBXPassengerSession current].user.token.length > 0) {
     [[_sharedInstance requestSerializer] setValue:[BBXPassengerSession current].user.token forHTTPHeaderField:@"token"];
     }
     */
    
    return _sharedInstance;
}

+ (AFHTTPSessionManager *)createSessionManager {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:ijinbuBaseUrl]];
//    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:@"https://api.app.net/"]];
//    manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    
    //-->bbxPassenger
    //NSString *deviceId = [OpenUDID value];
    
    AFHTTPRequestSerializer *requestSerializer = [AFHTTPRequestSerializer serializer];
    /*
     [requestSerializer setValue:deviceId forHTTPHeaderField:@"imei"];
     [requestSerializer setValue:@"1" forHTTPHeaderField:@"clientType"];
     [requestSerializer setValue:@"2" forHTTPHeaderField:@"appType"];
     //NSString *ver = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"] ?: [[[NSBundle mainBundle] infoDictionary] objectForKey:(__bridge NSString *)kCFBundleVersionKey];
     [requestSerializer setValue:HPServerAPIVer forHTTPHeaderField:@"ver"];
     [requestSerializer setValue:[[NSString stringWithFormat:@"%@123456", deviceId] MD5] forHTTPHeaderField:@"sign"];
     [requestSerializer setValue:[NSBundle mainBundle].bundleIdentifier forHTTPHeaderField:@"bundleId"];
     */
    manager.requestSerializer  = requestSerializer;
    
    //AFHTTPResponseSerializer *responseSerializer = [AFHTTPResponseSerializer serializer];//responseObject 是 data
    AFHTTPResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializer];//responseObject 是 json
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:
                                                 @"text/plain",
                                                 @"text/html",
                                                 @"application/json",
                                                 @"application/json;charset=utf-8", nil];
    manager.responseSerializer = responseSerializer;
    
    
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 10.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    return manager;
}

@end
