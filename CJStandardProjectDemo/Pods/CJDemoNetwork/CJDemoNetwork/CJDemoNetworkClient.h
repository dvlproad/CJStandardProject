//
//  CJDemoNetworkClient.h
//  CJDemoNetworkDemo
//
//  Created by ciyouzen on 2017/8/1.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CJDemoNetworkEnvironmentModel.h"
#import "CJDemoResponseModel.h"

// 域
extern NSString *const ActualDemoDomain;

@interface CJDemoNetworkClient : NSObject {
    
}
@property (nonatomic, strong) CJDemoNetworkEnvironmentModel *environmentModel;  /**< 当前网络环境 */
@property (nonatomic, strong) NSMutableDictionary *specificCommonParams;           /**< 设置每个请求都会有的公共参数(项目里已添加了其他一些公共参数) */
@property (nonatomic, strong) NSString *secretKey;  /**< 密钥 */

//必须实现：对"请求成功的数据"做初次判断(特殊的如登录操作，可能还需要其他判断才算登录成功)及一些通用的操作(block返回值为是否业务成功即isLogicSuccess,另对于一些特殊状态如"账号异地登录",也在此进行通用处理即可,不用每个请求都写一遍)
@property (nonatomic, copy) BOOL(^firstJudgeLogicSuccessBlock)(CJDemoResponseModel *responseModel);

//可选实现：获取"请求失败的回调"的错误信息
@property (nonatomic, copy) NSString* (^getRequestFailureMessageBlock)(NSError *error);

+ (CJDemoNetworkClient *)sharedInstance;

- (NSURLSessionDataTask *)cjDemo_getApi:(NSString *)apiSuffix
                              params:(NSDictionary *)params
                             success:(void (^)(CJDemoResponseModel *responseModel))success
                             failure:(void (^)(NSString *errorMessage))failure;

- (NSURLSessionDataTask *)cjDemo_postApi:(NSString *)apiSuffix
                                  params:(id)params
                                 encrypt:(BOOL)encrypt
                                 success:(void (^)(CJDemoResponseModel *responseModel))success
                                 failure:(void (^)(NSString *errorMessage))failure;


#pragma mark - simulate
- (NSURLSessionDataTask *)simulate_getApi:(NSString *)apiSuffix
                                   params:(NSDictionary *)params
                                  success:(void (^)(CJDemoResponseModel *responseModel))success
                                  failure:(void (^)(NSString *errorMessage))failure;

- (NSURLSessionDataTask *)simulate_postApi:(NSString *)apiSuffix
                                    params:(id)params
                                   encrypt:(BOOL)encrypt
                                   success:(void (^)(CJDemoResponseModel *responseModel))success
                                   failure:(void (^)(NSString *errorMessage))failure;

#pragma mark - localApi
- (NSURLSessionDataTask *)local_getApi:(NSString *)apiSuffix
                                params:(NSDictionary *)params
                               success:(void (^)(CJDemoResponseModel *responseModel))success
                               failure:(void (^)(NSString *errorMessage))failure;


- (NSURLSessionDataTask *)local_postApi:(NSString *)apiSuffix
                                 params:(id)params
                                encrypt:(BOOL)encrypt
                                success:(void (^)(CJDemoResponseModel *responseModel))success
                                failure:(void (^)(NSString *errorMessage))failure;



@end
