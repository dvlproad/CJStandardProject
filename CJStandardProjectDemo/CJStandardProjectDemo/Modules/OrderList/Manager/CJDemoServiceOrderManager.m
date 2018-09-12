//
//  CJDemoServiceOrderManager.m
//  CJStandardProjectDemo
//
//  Created by 李超前 on 2018/9/6.
//  Copyright © 2018年 devlproad. All rights reserved.
//

#import "CJDemoServiceOrderManager.h"

@implementation CJDemoServiceOrderManager

+ (CJDemoServiceOrderManager *)sharedInstance {
    static CJDemoServiceOrderManager *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

#pragma mark - Network And DB
///获取订单列表
- (void)getOrderListWithString:(NSString *)string
                       success:(void (^)(NSDictionary *responseDict))success
                       failure:(void (^)(NSError *error))failure {
    [self requestOrderListWithString:string success:^(NSDictionary *responseDict) {
        if (success) {
            success(responseDict);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

#pragma mark - Network
///获取订单列表
- (void)requestOrderListWithString:(NSString *)string
                           success:(void (^)(NSDictionary *responseDict))success
                           failure:(void (^)(NSError *error))failure
{
    NSString *Url = [DemoNetworkClient mainUrlWithApiSuffix:@"orderList"];
    
    NSDictionary *params = @{@"username":       self.uid,
                             @"access_token":   self.accessToken
                             };
    [[DemoNetworkClient sharedInstance] demo_postUrl:Url params:params progress:nil success:success failure:failure];
}

@end
