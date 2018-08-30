//
//  DemoNetworkClient.m
//  CJNetworkDemo
//
//  Created by ciyouzen on 2016/12/20.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "DemoNetworkClient.h"

#import <CJBaseUtil/CJDeviceUtil.h>
#import <OpenUDID/OpenUDID.h>

#import "DemoHTTPSessionManager.h"


/**
 *  DemoNetworkSession
 */
NSString *const kDemoNetworkSessionExpired = @"network:session-expired";
NSString *const kDemoNetworkSessionOffline = @"network:session-offline";
NSString *const kDemoNetworkSessionLoginStateDidChange = @"network:session-loginStateDidChange";


// 域
NSString *const ActualDemoDomain = @"http://192.168.199.125/BBXDataSimulationDemo";
static NSString * const SimulateDemoDomain = @"http://192.168.199.125/BBXDataSimulationDemo"; //WIFI:bangBang1_5G

@implementation DemoNetworkClient

+ (nullable DemoNetworkClient *)sharedInstance {
    static DemoNetworkClient *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

+ (NSString *)mainUrlWithApiSuffix:(NSString *)apiSuffix {
    NSString *environmentDomain = @"http://121.40.82.169/drupal/api/";
    NSString *mainUrl = [[environmentDomain stringByAppendingString:apiSuffix] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return mainUrl;
}


- (NSURLSessionDataTask *)demo_getUrl:(NSString *)Url
                               params:(NSDictionary *)params
                        completeBlock:(void (^)(DemoResponseModel *responseModel))completeBlock
{
    NSURLSessionDataTask *URLSessionDataTask =
    [self demo_getUrl:Url params:params success:^(NSDictionary *responseDict) {
        //DemoResponseModel *responseModel = [DemoResponseModel mj_objectWithKeyValues:responseDict];
        DemoResponseModel *responseModel = [[DemoResponseModel alloc] init];
        responseModel.status = [[responseDict objectForKey:@"status"] integerValue];
        responseModel.message = [responseDict objectForKey:@"message"];
        responseModel.result = [responseDict objectForKey:@"result"];
        if (completeBlock) {
            completeBlock(responseModel);
        }
        
    } failure:^(NSError *error) {
        DemoResponseModel *responseModel = [[DemoResponseModel alloc] init];
        responseModel.status = -1;
        responseModel.message = NSLocalizedString(@"网络请求失败", nil);
        responseModel.result = nil;
        if (completeBlock) {
            completeBlock(responseModel);
        }
    }];
    
    return URLSessionDataTask;
}

- (nullable NSURLSessionDataTask *)demo_postUrl:(nullable NSString *)Url
                                         params:(nullable id)params
                                       progress:(nullable void (^)(NSProgress * _Nonnull))uploadProgress
                                  completeBlock:(void (^)(DemoResponseModel *responseModel))completeBlock
{
    NSURLSessionDataTask *URLSessionDataTask =
    [self demo_postUrl:Url params:params progress:uploadProgress success:^(NSDictionary *responseDict) {
//        DemoResponseModel *responseModel = [DemoResponseModel mj_objectWithKeyValues:responseObject];
        DemoResponseModel *responseModel = [[DemoResponseModel alloc] init];
        responseModel.status = [[responseDict objectForKey:@"status"] integerValue];
        responseModel.message = [responseDict objectForKey:@"message"];
        responseModel.result = [responseDict objectForKey:@"result"];
        if (completeBlock) {
            completeBlock(responseModel);
        }
        
    } failure:^(NSError *error) {
        DemoResponseModel *responseModel = [[DemoResponseModel alloc] init];
        responseModel.status = -1;
        responseModel.message = NSLocalizedString(@"网络请求失败", nil);
        responseModel.result = nil;
        if (completeBlock) {
            completeBlock(responseModel);
        }
    }];
    
    return URLSessionDataTask;
}


- (nullable NSURLSessionDataTask *)demo_postUrl:(nullable NSString *)Url
                                         params:(nullable id)params
                                       progress:(nullable void (^)(NSProgress * _Nonnull))uploadProgress
                                        success:(void (^)(NSDictionary *responseObject))success
                                        failure:(void (^)(NSError *error))failure
{
    return [self demo_postUrl:Url params:params encrypt:NO progress:uploadProgress success:success failure:failure];
}

- (nullable NSURLSessionDataTask *)demo_postUrl:(nullable NSString *)Url
                                         params:(nullable id)params
                                        encrypt:(BOOL)encrypt
                                       progress:(nullable void (^)(NSProgress * _Nonnull))uploadProgress
                                        success:(void (^)(NSDictionary *responseObject))success
                                        failure:(void (^)(NSError *error))failure
{
    NSDictionary *allParams = [DemoNetworkClient completeParams:params];
    
    /*
    NSData * (^encryptBlock)(NSDictionary *requestParmas) = ^NSData *(NSDictionary *requestParmas) {
        //加密接口方法1：
        NSData *bodyData = [DemoCrypt encryptWithDataDic:allParams];
        return bodyData;
    };
    
    NSDictionary * (^decryptBlock)(NSString *responseString) = ^NSDictionary *(NSString *responseString) {
        NSDictionary *responseObject = [DemoCrypt decryptWithJsonStr:responseString];
        return responseObject;
    };
    //*/
    
    AFHTTPSessionManager *manager = [DemoHTTPSessionManager sharedInstance];
    
    NSURLSessionDataTask *URLSessionDataTask =
    [manager cj_postUrl:Url params:allParams encrypt:encrypt encryptBlock:nil decryptBlock:nil progress:nil success:^(NSDictionary *responseObject) {
        //NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSDictionary *responseDictionary = responseObject;
        [self doSuccessStatusWithResponseDictionary:responseDictionary success:success];
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
    return URLSessionDataTask;
}


- (NSURLSessionDataTask *)demo_getUrl:(NSString *)Url
                               params:(NSDictionary *)params
                              success:(void (^)(NSDictionary *responseDict))success
                              failure:(void (^)(NSError *error))failure
{
    NSDictionary *allParams = [DemoNetworkClient completeParams:params];
    
    AFHTTPSessionManager *manager = [DemoHTTPSessionManager sharedInstance];
    
    NSURLSessionDataTask *dataTask =
    [manager cj_getUrl:Url params:allParams progress:nil success:^(NSDictionary * _Nullable responseObject) {
        NSDictionary *responseDictionary = responseObject;
        [self doSuccessStatusWithResponseDictionary:responseDictionary success:success];
        
    } failure:^(NSError * _Nullable error) {
        if (failure) {
            failure(error);
        }
    }];
    
    return dataTask;
}


+ (NSDictionary *)completeParams:(NSDictionary *)params
{
    NSMutableDictionary *allParams = [NSMutableDictionary dictionaryWithDictionary:params];
    
    NSString *udid = [OpenUDID value];
    [allParams setObject:udid forKey:@"imei"];
    
    NSString *currentDevicePlatform = [CJDeviceUtil getCurrentDeviceName];
    [allParams setValue:currentDevicePlatform forKey:@"device_type_phone"];
    
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *appVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"]; // app版本
    [allParams setValue:appVersion forKey:@"app_version"];
    
//    NSString *appName = [infoDictionary objectForKey:@"CFBundleDisplayName"];  // app名称
//
//    NSString *app_build = [infoDictionary objectForKey:@"CFBundleVersion"]; // app build版本
    
    return allParams;
}


///**
// *  当请求到数据，但status不为0时候，所进行的处理
// *
// *  @param responseObject   此时请求到的数据
// *  @param expiredBlock     过期处理的事情(已包含发送过期通知，还需要处理取消掉之前已发起的所有请求)
// *  @param offlineBlock     离线处理的事情(已包含发送离线通知，还需要处理取消掉之前已发起的所有请求)
// *  @param errorBlock       非过期和离线处理的事情(不需要取消掉之前已发起的请求))
// */
//- (void)errorEventWithErrorResponseObject:(NSDictionary *)responseObject
//                             expiredBlock:(void (^)(void))expiredBlock
//                             offlineBlock:(void (^)(void))offlineBlock
//                               errorBlock:(void (^)(NSError *error))errorBlock;
/**
 *  当请求到数据，针对各种status所进行的不同处理
 *
 *  @param responseDictionary   此时请求到的数据
 *  @param success              请求成功所进行的处理
 */
- (void)doSuccessStatusWithResponseDictionary:(NSDictionary *)responseDictionary
                                      success:(void (^)(NSDictionary *responseObject))success
{
    /* 创建error */
    NSInteger status = [[responseDictionary objectForKey:@"status"] integerValue];
    if (status == 0) {
        if (success) {
            success(responseDictionary);
        }
        return;
    }
    
    NSString *errorMessage = [responseDictionary objectForKey:@"message"];
    if (errorMessage.length == 0) {
        errorMessage = [NSString stringWithFormat:@"未知错误%zd", (long)status];
    }
    
    id result = [responseDictionary objectForKey:@"result"];
    
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    [userInfo setValue:errorMessage forKey:NSLocalizedDescriptionKey];
    [userInfo setValue:result forKey:@"result"];
    NSError *error = [[NSError alloc] initWithDomain:@"com.dvlproad.networkClient.error" code:status userInfo:userInfo];
    
    
    /* 对不同的error执行不同的操作 */
    if (status == -1) {
        AFHTTPSessionManager *httpSessionManager = [DemoHTTPSessionManager sharedInstance];
        [httpSessionManager.operationQueue cancelAllOperations];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kDemoNetworkSessionExpired object:nil userInfo:@{@"error":error}];
        
    } else if (status == -800 || status == 3) {
        AFHTTPSessionManager *httpSessionManager = [DemoHTTPSessionManager sharedInstance];
        [httpSessionManager.operationQueue cancelAllOperations];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kDemoNetworkSessionOffline object:nil userInfo:@{@"error":error}];
        
    } else {
        if (success) {
            success(responseDictionary);
        }
    }
}


#pragma mark - simulate
- (NSURLSessionDataTask *)simulate_postUrl:(NSString *)Url
                                    params:(id)params
                                   encrypt:(BOOL)encrypt
                                   success:(void (^)(NSDictionary *responseObject))success
                                   failure:(void (^)(NSError *error))failure
{
    NSString *actualDomain =  ActualDemoDomain;
    NSString *simulationDomain = SimulateDemoDomain;
    Url = [Url stringByReplacingOccurrencesOfString:actualDomain withString:simulationDomain];
    
    //POST方式只会成功第一次，后面不知道为什么会出错 Status Code: 412
    //Get能一直成功
    return [self demo_getUrl:Url params:params success:success failure:^(NSError *error) {
        [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"网络异常，请检查", nil) message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
        if (failure) {
            failure(error);
        }
    }];
}

- (NSURLSessionDataTask *)simulate_getUrl:(NSString *)Url
                                   params:(NSDictionary *)params
                                  success:(void (^)(NSDictionary *responseDict))success
                                  failure:(void (^)(NSError *error))failure
{
    NSString *actualDomain =  ActualDemoDomain;
    NSString *simulationDomain = SimulateDemoDomain;
    Url = [Url stringByReplacingOccurrencesOfString:actualDomain withString:simulationDomain];
    
    return [self demo_getUrl:Url params:params success:success failure:^(NSError *error) {
        [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"网络异常，请检查", nil) message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
        if (failure) {
            failure(error);
        }
    }];
}

- (NSURLSessionDataTask *)simulate_getUrl:(NSString *)Url
                                   params:(NSDictionary *)params
                            completeBlock:(void (^)(DemoResponseModel *responseModel))completeBlock
{
    NSString *actualDomain =  ActualDemoDomain;
    NSString *simulationDomain = SimulateDemoDomain;
    Url = [Url stringByReplacingOccurrencesOfString:actualDomain withString:simulationDomain];
    
    return [self demo_getUrl:Url params:params completeBlock:^(DemoResponseModel *responseModel) {
        if (responseModel.status == -1) {
            [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"网络异常，请检查", nil) message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
        }
        if (completeBlock) {
            completeBlock(responseModel);
        }
    }];
}

- (NSURLSessionDataTask *)simulate_postUrl:(NSString *)Url
                                    params:(id)params
                                   encrypt:(BOOL)encrypt
                             completeBlock:(void (^)(DemoResponseModel *responseModel))completeBlock
{
    NSString *actualDomain =  ActualDemoDomain;
    NSString *simulationDomain = SimulateDemoDomain;
    Url = [Url stringByReplacingOccurrencesOfString:actualDomain withString:simulationDomain];
    
    return [self demo_getUrl:Url params:params completeBlock:^(DemoResponseModel *responseModel) {
        if (responseModel.status == -1) {
            [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"网络异常，请检查", nil) message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
        }
        if (completeBlock) {
            completeBlock(responseModel);
        }
    }];
}


@end
