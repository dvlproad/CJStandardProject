//
//  CJDemoCryptHTTPSessionManager.m
//  CJNetworkDemo
//
//  Created by ciyouzen on 2016/12/20.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "CJDemoCryptHTTPSessionManager.h"
#import "CJDemoCryptHTTPRequestSerializer.h"
#import "CJDemoCryptHTTPResponseSerializer.h"

@implementation CJDemoCryptHTTPSessionManager

+ (AFHTTPSessionManager *)sharedInstance {
    static AFHTTPSessionManager *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [self createSessionManager];
    });
    
    return _sharedInstance;
}

+ (AFHTTPSessionManager *)createSessionManager {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    CJDemoCryptHTTPRequestSerializer *requestSerializer = [CJDemoCryptHTTPRequestSerializer serializer];
    manager.requestSerializer  = requestSerializer;
    
    CJDemoCryptHTTPResponseSerializer *responseSerializer = [CJDemoCryptHTTPResponseSerializer serializer];
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:
                                                 @"text/plain",
                                                 @"text/html",
                                                 @"application/json",
                                                 @"application/json;charset=utf-8", nil];
    manager.responseSerializer = responseSerializer;
    
    
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 20.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    return manager;
}

@end
