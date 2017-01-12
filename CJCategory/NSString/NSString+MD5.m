//
//  NSString+MD5.m
//  AImageDownloader
//
//  Created by Jason Lee on 12-3-9.
//  Copyright (c) 2012年 Taobao. All rights reserved.
//

#import "NSString+MD5.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (MD5)

- (NSString*)MD5
{
//    if ([self isEqualToString:@""]) {
//        NSLog(@"MD5 failed: 空");
//    }
//    return [self lastPathComponent]; //TODO 为了修正头像下载时候使用url来保存的问题
    
    const char *ptr = [self UTF8String];
    unsigned char md5Buffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(ptr, (CC_LONG)strlen(ptr), md5Buffer);
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) 
        [output appendFormat:@"%02x",md5Buffer[i]];
    
    return output;
}

@end
