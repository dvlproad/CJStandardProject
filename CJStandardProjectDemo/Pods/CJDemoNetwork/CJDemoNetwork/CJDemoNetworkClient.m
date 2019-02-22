//
//  CJDemoNetworkClient.m
//  CJDemoNetworkDemo
//
//  Created by ciyouzen on 2017/8/1.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "CJDemoNetworkClient.h"
#import "CJDemoCleanHTTPSessionManager.h"
#import "CJDemoCryptHTTPSessionManager.h"
#import "CJDemoNetworkEnvironmentManager.h"

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
        AFHTTPSessionManager *cleanHTTPSessionManager = [CJDemoCleanHTTPSessionManager sharedInstance];
        AFHTTPSessionManager *cryptHTTPSessionManager = [CJDemoCryptHTTPSessionManager sharedInstance];
        [self setupCleanHTTPSessionManager:cleanHTTPSessionManager cryptHTTPSessionManager:cryptHTTPSessionManager];
        
//        //CJDemoNetworkEnvironmentManager *environmentManager = [CJDemoNetworkEnvironmentManager sharedInstance];
//        [self setupCompleteFullUrlBlock:^NSString *(NSString *apiSuffix) {
//            NSMutableString *fullUrl = [NSMutableString string];
//            [fullUrl appendFormat:@"%@", self.baseUrl];
//            if (![self.baseUrl hasSuffix:@"/"]) {
//                [fullUrl appendFormat:@"/"];
//            }
//            [fullUrl appendFormat:@"%@", apiSuffix];
//            return [fullUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//            //return [environmentManager completeUrlWithApiSuffix:apiSuffix];
//        } completeAllParamsBlock:^NSDictionary *(NSDictionary *customParams) {
//            NSMutableDictionary *allParams = [NSMutableDictionary dictionaryWithDictionary:customParams];
//            [allParams addEntriesFromDictionary:self.commonParams];
//            return allParams;
//            //return [environmentManager completeParamsWithCustomParams:customParams];
//        }];
        
        [self setupResponseConvertBlock:^CJResponseModel *(id responseObject, BOOL isCacheData) {
            NSDictionary *responseDictionary = responseObject;
            //CJResponseModel *responseModel = [CJResponseModel mj_objectWithKeyValues:responseDictionary];
            //CJResponseModel *responseModel = [[CJResponseModel alloc] initWithResponseDictionary:responseDictionary isCacheData:isCacheData];
            CJResponseModel *responseModel = [[CJResponseModel alloc] init];
            responseModel.statusCode = [responseDictionary[@"status"] integerValue];
            responseModel.message = responseDictionary[@"message"];
            responseModel.result = responseDictionary[@"result"];
            responseModel.isCacheData = isCacheData;
            
            return responseModel;
            
        } checkIsCommonBlock:^BOOL(CJResponseModel *responseModel) {
            //必须实现：对"请求成功的success回调"做初次判断，设置哪些情况可以继续走success回调(如statusCode==1)，其余转为走failue回调。
            //让只有statusCode==1的操作才继续走success回调,其余在操作完自身业务后，都转为走failue回调里
            if (responseModel.statusCode == 1) {
                return YES;
            } else {
                if (responseModel.statusCode == 5) { //执行退出登录
                    //[CJToast shortShowMessage:@"账号异地登录"];
                    //[[CJDemoUserManager sharedInstance] logout:YES completed:nil];
                }
                return NO;
            }
            
        } getRequestFailureMessageBlock:^NSString *(NSError *error) {
            //可选实现：获取"请求失败的回调"的错误信息
            return NSLocalizedString(@"网络链接失败，请检查您的网络链接", nil);
        }];
        
        NSString *simulateDomain = @"http://localhost/CJDemoDataSimulationDemo";
        self.simulateDomain = simulateDomain;
    }
    return self;
}



@end
