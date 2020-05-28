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
        
        [self setupGetSuccessResponseModelBlock:^CJResponseModel *(id responseObject, BOOL isCacheData) {
            NSDictionary *responseDictionary = responseObject;
            //CJResponseModel *responseModel = [CJResponseModel mj_objectWithKeyValues:responseDictionary];
            //CJResponseModel *responseModel = [[CJResponseModel alloc] initWithResponseDictionary:responseDictionary isCacheData:isCacheData];
            CJResponseModel *responseModel = [[CJResponseModel alloc] init];
            responseModel.statusCode = [responseDictionary[@"status"] integerValue];
            responseModel.message = responseDictionary[@"message"];
            responseModel.result = responseDictionary[@"result"];
            responseModel.isCacheData = isCacheData;
            
            return responseModel;
            
        } checkIsCommonFailureBlock:^BOOL(CJResponseModel *responseModel) {
           // 检查是否是共同错误并在此对共同错误做处理，如statusCode == -5 为异地登录(可为ni,非nil时一般返回值为NO)
            if (responseModel.statusCode == 5) { //执行退出登录
                //[CJToast shortShowMessage:@"账号异地登录"];
                //[[CJDemoUserManager sharedInstance] logout:YES completed:nil];
                return YES;
            } else {
                return NO;
            }
            
        } getFailureResponseModelBlock:^CJResponseModel *(NSError *error, NSString *errorMessage) {
            if (errorMessage == nil || errorMessage.length == 0) {
                errorMessage = NSLocalizedString(@"网络链接失败，请检查您的网络链接", nil);
            }
            CJResponseModel *responseModel = [[CJResponseModel alloc] init];
            responseModel.statusCode = -1;
            responseModel.message = errorMessage;
            responseModel.result = nil;
            
            return responseModel;
        }];
        
        self.baseUrl = @"";
        self.commonParams = [NSMutableDictionary dictionaryWithDictionary:@{}];
        self.simulateDomain = @"http://localhost/CJDemoDataSimulationDemo";
    }
    return self;
}


- (void)cjdemo_uploadImage:(UIImage *)image
              settingModel:(CJRequestSettingModel *)settingModel
             uploadSuccess:(void (^)(NSString *imageUrl, NSString *thumbnailUrl))uploadSuccess
             uploadFailure:(void (^)(BOOL isRequestFailure, NSString *errorMessage))uploadFailure
{
    //NSString *Url = @"http://source.beyond.com/pub/image/user_upload2"; //idcard upload
    NSString *apiName = @"/api/image/user_upload2";
    NSDictionary *params = @{@"object_id": @"1111",
                             };
    
    
    
    NSMutableDictionary *imageKeyDataDicts = [[NSMutableDictionary alloc] init];
    if (image) {
        NSData *imageData = UIImageJPEGRepresentation(image, 1);
        [imageKeyDataDicts setObject:imageData forKey:@"upfile"];
    }
    
    [[CJDemoNetworkClient sharedInstance] cjdemoR2_uploadImageApi:apiName urlParams:nil formParams:params imageKeyDataDictionarys:imageKeyDataDicts settingModel:settingModel success:^(CJResponseModel * _Nonnull responseModel) {
        if (responseModel.statusCode == 0) {
            NSDictionary *resultDictionary = responseModel.result;
            NSString *imageUrl = resultDictionary[@"raw"];
            NSString *thumbnailUrl = resultDictionary[@"thumbnail"];
            !uploadSuccess ?: uploadSuccess(imageUrl, thumbnailUrl);
        } else {
            !uploadFailure ?: uploadFailure(NO, @"图片上传失败");
        }
        
    } failure:^(BOOL isRequestFailure, NSString *errorMessage) {
        !uploadFailure ?: uploadFailure(isRequestFailure, errorMessage);
    }];
}

@end
