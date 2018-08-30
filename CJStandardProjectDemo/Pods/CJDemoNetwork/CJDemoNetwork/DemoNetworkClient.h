//
//  DemoNetworkClient.h
//  CJNetworkDemo
//
//  Created by ciyouzen on 2016/12/20.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CJNetwork/AFHTTPSessionManager+CJEncrypt.h>

#import "DemoResponseModel.h"

/**
 *  DemoNetworkSession
 */
extern NSString *const kDemoNetworkSessionExpired;             /**< 过期 */
extern NSString *const kDemoNetworkSessionOffline;             /**< 离线 */
extern NSString *const kDemoNetworkSessionLoginStateDidChange; /**< 登录状态改变 */

// 域
extern NSString *const ActualDemoDomain;

@interface DemoNetworkClient : NSObject

+ (nullable DemoNetworkClient *)sharedInstance;


+ (NSString *)mainUrlWithApiSuffix:(NSString *)apiSuffix;


- (nullable NSURLSessionDataTask *)demo_postUrl:(nullable NSString *)Url
                                         params:(nullable id)params
                                       progress:(nullable void (^)(NSProgress * _Nonnull))uploadProgress
                                        success:(void (^)(NSDictionary *responseObject))success
                                        failure:(void (^)(NSError *error))failure;


- (NSURLSessionDataTask *)demo_getUrl:(NSString *)Url
                               params:(NSDictionary *)params
                              success:(void (^)(NSDictionary *responseDict))success
                              failure:(void (^)(NSError *error))failure;

- (NSURLSessionDataTask *)demo_getUrl:(NSString *)Url
                               params:(NSDictionary *)params
                        completeBlock:(void (^)(DemoResponseModel *responseModel))completeBlock;

- (nullable NSURLSessionDataTask *)demo_postUrl:(nullable NSString *)Url
                                         params:(nullable id)params
                                       progress:(nullable void (^)(NSProgress * _Nonnull))uploadProgress
                                  completeBlock:(void (^)(DemoResponseModel *responseModel))completeBlock;

#pragma mark - simulate
- (NSURLSessionDataTask *)simulate_postUrl:(NSString *)Url
                                    params:(id)params
                                   encrypt:(BOOL)encrypt
                                   success:(void (^)(NSDictionary *responseObject))success
                                   failure:(void (^)(NSError *error))failure;

- (NSURLSessionDataTask *)simulate_getUrl:(NSString *)Url
                                   params:(NSDictionary *)params
                                  success:(void (^)(NSDictionary *responseDict))success
                                  failure:(void (^)(NSError *error))failure;

- (NSURLSessionDataTask *)simulate_getUrl:(NSString *)Url
                                   params:(NSDictionary *)params
                            completeBlock:(void (^)(DemoResponseModel *responseModel))completeBlock;

- (NSURLSessionDataTask *)simulate_postUrl:(NSString *)Url
                                    params:(id)params
                                   encrypt:(BOOL)encrypt
                             completeBlock:(void (^)(DemoResponseModel *responseModel))completeBlock;
@end
