//
//  CJDemoCrypt+AES.h
//  CJDemoCryptDemo
//
//  Created by ciyouzen on 2018/10/16.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "CJDemoCrypt.h"

@interface CJDemoCrypt (AES)

//加密
+ (NSString *)AESEncryptForString:(NSString *)string
                    withSecretKey:(NSString *)secretKey;

//解密
+ (NSString *)AESDecryptForString:(NSString *)string
                    withSecretKey:(NSString *)secretKey;

@end
