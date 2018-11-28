//
//  CJDemoCrypt+AES.m
//  CJDemoCryptDemo
//
//  Created by ciyouzen on 2018/10/16.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "CJDemoCrypt+AES.h"

@implementation CJDemoCrypt (AES)

//加密
+ (NSString *)AESEncryptForString:(NSString *)string
                    withSecretKey:(NSString *)secretKey
{
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSData *encryptData = data;//这里应该通过secretKey来加密生成新的data
    if (encryptData && encryptData.length>0) {
        NSString *base64EncryString = [encryptData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
        base64EncryString = [base64EncryString stringByReplacingOccurrencesOfString:@"+" withString:@"-"];
        base64EncryString = [base64EncryString stringByReplacingOccurrencesOfString:@"/" withString:@"_"];
        return base64EncryString;
    }
    return nil;
}

//解密
+ (NSString *)AESDecryptForString:(NSString *)string
                    withSecretKey:(NSString *)secretKey
{
    string = [string stringByReplacingOccurrencesOfString:@"-" withString:@"+"];
    string = [string stringByReplacingOccurrencesOfString:@"_" withString:@"/"];
    NSData *baseData = [[NSData alloc] initWithBase64EncodedString:string options:NSDataBase64DecodingIgnoreUnknownCharacters];
    NSData *decryptData = baseData; //这里应该通过secretKey来解密生成新的data
    if (decryptData && decryptData.length>0) {
        NSString *base64DecryString = [[NSString alloc] initWithData:decryptData encoding:NSUTF8StringEncoding];
        return base64DecryString;
    }
    return nil;
}

@end
