//
//  CJDemoCrypt.m
//  CJDemoCryptDemo
//
//  Created by ciyouzen on 2018/9/10.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "CJDemoCrypt.h"
#import <CommonCrypto/CommonDigest.h> //md5方法要用的
#import "CJDemoCrypt+AES.h"
#import "CJDemoCrypt+Hashes.h"

@implementation CJDemoCrypt

+ (CJDemoCrypt *)sharedInstance {
    static CJDemoCrypt *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

- (NSMutableDictionary *)encryptRequestParams:(NSDictionary *)params {
    NSMutableDictionary *newParams = [self reviseMAPIParameters:params];
    return newParams;
}

//拼接参数
- (NSMutableDictionary *)reviseMAPIParameters:(NSDictionary *)params {
    NSMutableDictionary *newParams = [NSMutableDictionary dictionary];
    
    NSMutableArray *dictArray = [NSMutableArray arrayWithCapacity:newParams.count];
    for (NSString *key in newParams.allKeys) {
        NSString *string = [NSString stringWithFormat:@"%@=%@", key, newParams[key]];
        [dictArray addObject:string];
    }
    
    NSArray *array = [dictArray sortedArrayUsingSelector:@selector(compare:)];
    NSString *signStr = [array componentsJoinedByString:@";"];
    signStr = [NSString stringWithFormat:@"%@%@", signStr, self.secretKey];
    newParams[@"sign"] = [CJDemoCrypt doMD5FroString:signStr];
    
    return newParams;
}

- (NSMutableDictionary *)decryptRequestBodyData:(NSData *)bodyData {
    if (bodyData == nil) {
        return nil;
    }
    
    /*
    NSError *error;
    NSDictionary *bodyParams = [NSJSONSerialization JSONObjectWithData:bodyData options:NSJSONReadingMutableContainers error:&error];
    if(error) {
        NSLog(@"json解析失败：%@", err);
    }
    */
    
    NSMutableDictionary *bodyParams = [[NSMutableDictionary alloc] init];
    NSString *bodyParamsString = [[NSString alloc] initWithData:bodyData encoding:NSUTF8StringEncoding];
    NSArray *paramKeyValueStringArray = [bodyParamsString componentsSeparatedByString:@"&"];
    for (NSString *paramKeyValueString in paramKeyValueStringArray) {
        NSArray *keyValue = [paramKeyValueString componentsSeparatedByString:@"="];
        NSString *key = keyValue[0];
        NSString *value = keyValue[1];
        NSDictionary *paramDictionary = @{key: value};
        [bodyParams addEntriesFromDictionary:paramDictionary];
    }
    return bodyParams;
}

/** 对请求下来字符串的数据进行解密 再转化成字典 或者 数据对象的数据 */
- (NSDictionary *)decryptResponseString:(NSString *)encryptResponseString {
    NSString *responseString = [CJDemoCrypt AESDecryptForString:encryptResponseString withSecretKey:self.secretKey];
    
    if (responseString == nil || responseString.length < 2) {
        //NSLog(@"AESForDecry fail");
        responseString = encryptResponseString;
    }
    
    NSData *objectData = [responseString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *jsonError;
    NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:objectData options:NSJSONReadingMutableContainers error:&jsonError];
    if (jsonError) {
        NSLog(@"json解析失败：%@", jsonError);
        return nil;
    }
    
    return responseDictionary;
}





@end
