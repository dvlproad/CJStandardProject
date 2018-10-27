//
//  CJDemoNetworkClient.m
//  CJDemoNetworkDemo
//
//  Created by ciyouzen on 2017/8/1.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "CJDemoNetworkClient.h"
#import <CJNetwork/AFHTTPSessionManager+CJEncrypt.h>
#import "CJDemoNetworkEnvironmentManager.h"
#import <CJDemoCryptSDK/CJDemoCrypt.h>

#import "CJDemoCleanHTTPSessionManager.h" //需传加密算法的
#import "CJDemoCryptHTTPSessionManager.h" //已把加密算法封装到manager的

// 域
NSString *const ActualDemoDomain = @"http://192.168.199.125/CJDemoDataSimulationDemo";
static NSString * const SimulateDemoDomain = @"http://192.168.199.125/CJDemoDataSimulationDemo";

@interface CJDemoNetworkClient () {
    
}
@property (nonatomic, strong, readonly) NSDictionary *allCommonParams;    /**< 所有的共同参数 */

@end

@implementation CJDemoNetworkClient

+ (CJDemoNetworkClient *)sharedInstance {
    static CJDemoNetworkClient *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

#pragma mark - Open
- (NSURLSessionDataTask *)cjDemo_getApi:(NSString *)apiSuffix
                                 params:(NSDictionary *)params
                                success:(void (^)(CJDemoResponseModel *responseModel))success
                                failure:(void (^)(NSString *errorMessage))failure
{
    NSString *Url = [[CJDemoNetworkEnvironmentManager sharedInstance] completeUrlWithApiSuffix:apiSuffix];
    return [self cjDemo_getUrl:Url params:params logType:CJNetworkLogTypeConsoleLog success:success failure:failure];
}

- (NSURLSessionDataTask *)cjDemo_postApi:(NSString *)apiSuffix
                                  params:(id)params
                                 encrypt:(BOOL)encrypt
                                 success:(void (^)(CJDemoResponseModel *responseModel))success
                                 failure:(void (^)(NSString *errorMessage))failure
{
    NSString *Url = [[CJDemoNetworkEnvironmentManager sharedInstance] completeUrlWithApiSuffix:apiSuffix];
    return [self cjDemo_postUrl:Url params:params encrypt:encrypt logType:CJNetworkLogTypeConsoleLog success:success failure:failure];
}

#pragma mark - LogApi
- (NSURLSessionDataTask *)log_getApi:(NSString *)apiSuffix
                              params:(NSDictionary *)params
                             success:(void (^)(CJDemoResponseModel *responseModel))success
                             failure:(void (^)(NSString *errorMessage))failure
{
    NSString *Url = [[CJDemoNetworkEnvironmentManager sharedInstance] completeUrlWithApiSuffix:apiSuffix];
    return [self cjDemo_getUrl:Url params:params logType:CJNetworkLogTypeSuppendWindow success:success failure:failure];
}

- (NSURLSessionDataTask *)log_postApi:(NSString *)apiSuffix
                               params:(id)params
                              encrypt:(BOOL)encrypt
                              success:(void (^)(CJDemoResponseModel *responseModel))success
                              failure:(void (^)(NSString *errorMessage))failure
{
    NSString *Url = [[CJDemoNetworkEnvironmentManager sharedInstance] completeUrlWithApiSuffix:apiSuffix];
    return [self cjDemo_postUrl:Url params:params encrypt:encrypt logType:CJNetworkLogTypeSuppendWindow success:success failure:failure];
}

#pragma mark simulate
- (NSURLSessionDataTask *)simulate_getApi:(NSString *)apiSuffix
                                   params:(NSDictionary *)params
                                  success:(void (^)(CJDemoResponseModel *responseModel))success
                                  failure:(void (^)(NSString *errorMessage))failure;
{
    return [self simulateApi:apiSuffix params:params success:success failure:failure];
}


- (NSURLSessionDataTask *)simulate_postApi:(NSString *)apiSuffix
                                    params:(id)params
                                   encrypt:(BOOL)encrypt
                                   success:(void (^)(CJDemoResponseModel *responseModel))success
                                   failure:(void (^)(NSString *errorMessage))failure
{
    return [self simulateApi:apiSuffix params:params success:success failure:failure];
}

- (NSURLSessionDataTask *)simulateApi:(NSString *)apiSuffix
                               params:(NSDictionary *)params
                              success:(void (^)(CJDemoResponseModel *responseModel))success
                              failure:(void (^)(NSString *errorMessage))failure
{
    NSString *Url = [[CJDemoNetworkEnvironmentManager sharedInstance] completeUrlWithApiSuffix:apiSuffix];
    
    NSString *actualDomain =  ActualDemoDomain;
    NSString *simulationDomain = SimulateDemoDomain;
    Url = [Url stringByReplacingOccurrencesOfString:actualDomain withString:simulationDomain];
    
    return [self cjDemo_getUrl:Url params:params logType:CJNetworkLogTypeConsoleLog success:success failure:^(NSString *errorMessage) {
        [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"网络异常，请检查", nil) message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
        if (failure) {
            failure(errorMessage);
        }
    }];
}


#pragma mark - localApi
- (NSURLSessionDataTask *)local_getApi:(NSString *)apiSuffix
                                params:(NSDictionary *)params
                               success:(void (^)(CJDemoResponseModel *responseModel))success
                               failure:(void (^)(NSString *errorMessage))failure
{
    return [self localApi:apiSuffix params:params success:success failure:failure];
}


- (NSURLSessionDataTask *)local_postApi:(NSString *)apiSuffix
                                 params:(id)params
                                encrypt:(BOOL)encrypt
                                success:(void (^)(CJDemoResponseModel *responseModel))success
                                failure:(void (^)(NSString *errorMessage))failure
{
    return [self localApi:apiSuffix params:params success:success failure:failure];
}

- (NSURLSessionDataTask *)localApi:(NSString *)apiSuffix
                            params:(NSDictionary *)params
                           success:(void (^)(CJDemoResponseModel *responseModel))success
                           failure:(void (^)(NSString *errorMessage))failure
{
    if ([apiSuffix hasPrefix:@"/"]) {
        apiSuffix = [apiSuffix substringFromIndex:1];
    }
    NSString *jsonName = [apiSuffix stringByReplacingOccurrencesOfString:@"/" withString:@"_"];
    NSData *responseObject = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:jsonName ofType:@"json"]];
    
    NSDictionary *recognizableResponseObject = nil;
    //if ([NSJSONSerialization isValidJSONObject:responseObject]) {
    //    recognizableResponseObject = responseObject;
    //} else {
        recognizableResponseObject = [NSJSONSerialization JSONObjectWithData:(NSData *)responseObject options:NSJSONReadingMutableContainers error:nil];
    //}
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSDictionary *responseDictionary = recognizableResponseObject;
        //CJDemoResponseModel *responseModel = [CJDemoResponseModel mj_objectWithKeyValues:responseDictionary];
        CJDemoResponseModel *responseModel = [[CJDemoResponseModel alloc] initWithResponseDictionary:responseDictionary];
        if (success) {
            success(responseModel);
        }
        
    });
    
    return nil;
}

#pragma mark - Base
- (NSURLSessionDataTask *)cjDemo_getUrl:(NSString *)Url
                                 params:(NSDictionary *)params
                                logType:(CJNetworkLogType)logType
                                success:(void (^)(CJDemoResponseModel *responseModel))success
                                failure:(void (^)(NSString *errorMessage))failure
{
    NSDictionary *allParams = [self completeParamsWithCustomParams:params];
    
    AFHTTPSessionManager *manager = [CJDemoCleanHTTPSessionManager sharedInstance];
    
    NSURLSessionDataTask *dataTask =
    [manager cj_getUrl:Url params:allParams progress:nil logType:logType success:^(CJSuccessNetworkInfo * _Nullable successNetworkInfo) {
        NSDictionary *responseDictionary = successNetworkInfo.responseObject;
        //CJDemoResponseModel *responseModel = [CJDemoResponseModel mj_objectWithKeyValues:responseDictionary];
        CJDemoResponseModel *responseModel = [[CJDemoResponseModel alloc] initWithResponseDictionary:responseDictionary];
        
        NSAssert(self.firstJudgeLogicSuccessBlock, @"对请求成功的数据做初次判断及一些通用的操作的方法不能为空");
        BOOL logicSuccess = self.firstJudgeLogicSuccessBlock(responseModel);
        if (logicSuccess) {
            if (success) {
                success(responseModel);
            }
        } else {
            NSString *logicFailureMessage = responseModel.message;
            if (failure) {
                failure(logicFailureMessage);
            }
        }
    } failure:^(CJFailureNetworkInfo * _Nullable failureNetworkInfo) {
        NSError *error = failureNetworkInfo.error;
        NSString *errorMessage = failureNetworkInfo.errorMessage;
        if (self.getRequestFailureMessageBlock) {
            errorMessage = self.getRequestFailureMessageBlock(error);
        }
        //CJDemoResponseModel *responseModel = [[CJDemoResponseModel alloc] init];
        //responseModel.status = -1;
        //responseModel.message = NSLocalizedString(@"网络请求失败", nil);
        //responseModel.result = nil;
        
        if (failure) {
            failure(errorMessage);
        }
    }];
    
    return dataTask;
}


- (NSURLSessionDataTask *)cjDemo_postUrl:(NSString *)Url
                                  params:(id)params
                                 encrypt:(BOOL)encrypt
                                 logType:(CJNetworkLogType)logType
                                 success:(void (^)(CJDemoResponseModel *responseModel))success
                                 failure:(void (^)(NSString *errorMessage))failure
{
    
    NSDictionary *allParams = [self completeParamsWithCustomParams:params];
    

    AFHTTPSessionManager *manager = nil;
    if (encrypt) {
        manager = [CJDemoCryptHTTPSessionManager sharedInstance];
    } else {
        manager = [CJDemoCleanHTTPSessionManager sharedInstance];
    }
    
    NSURLSessionDataTask *URLSessionDataTask =
    [manager cj_postUrl:Url params:allParams progress:nil logType:logType success:^(CJSuccessNetworkInfo * _Nullable successNetworkInfo) {
        NSDictionary *responseDictionary = successNetworkInfo.responseObject;
        //CJDemoResponseModel *responseModel = [CJDemoResponseModel mj_objectWithKeyValues:responseDictionary];
        CJDemoResponseModel *responseModel = [[CJDemoResponseModel alloc] initWithResponseDictionary:responseDictionary];
        NSAssert(self.firstJudgeLogicSuccessBlock, @"对请求成功的数据做判断及一些通用的操作的方法不能为空");
        BOOL logicSuccess = self.firstJudgeLogicSuccessBlock(responseModel);
        if (logicSuccess) {
            if (success) {
                success(responseModel);
            }
        } else {
            NSString *logicFailureMessage = responseModel.message;
            if (failure) {
                failure(logicFailureMessage);
            }
        }
        
    } failure:^(CJFailureNetworkInfo * _Nullable failureNetworkInfo) {
        NSError *error = failureNetworkInfo.error;
        NSString *errorMessage = failureNetworkInfo.errorMessage;
        if (self.getRequestFailureMessageBlock) {
            errorMessage = self.getRequestFailureMessageBlock(error);
        }
        //CJDemoResponseModel *responseModel = [[CJDemoResponseModel alloc] init];
        //responseModel.status = -1;
        //responseModel.message = NSLocalizedString(@"网络请求失败", nil);
        //responseModel.result = nil;
        
        if (failure) {
            failure(errorMessage);
        }
    }];
    
    return URLSessionDataTask;
}

#pragma mark - Environment
- (NSDictionary *)completeParamsWithCustomParams:(NSDictionary *)customParams
{
     NSDictionary *allParams = [[CJDemoNetworkEnvironmentManager sharedInstance] completeParamsWithCustomParams:customParams];
    return allParams;
}

- (void)setEnvironmentModel:(CJDemoNetworkEnvironmentModel *)environmentModel {
    _environmentModel = environmentModel;
 
    [CJDemoNetworkEnvironmentManager sharedInstance].environmentModel = environmentModel;
}

- (void)setSpecificCommonParams:(NSMutableDictionary *)specificCommonParams {
    _specificCommonParams = specificCommonParams;
    
    [CJDemoNetworkEnvironmentManager sharedInstance].specificCommonParams = specificCommonParams;
}
     
#pragma mark - Crypt
- (void)setSecretKey:(NSString *)secretKey {
    _secretKey = secretKey;
    [CJDemoCrypt sharedInstance].secretKey = secretKey;
}



@end
