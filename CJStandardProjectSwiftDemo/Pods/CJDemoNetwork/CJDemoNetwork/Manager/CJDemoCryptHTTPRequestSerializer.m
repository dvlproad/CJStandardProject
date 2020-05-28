//
//  CJDemoCryptHTTPRequestSerializer.m
//  CJNetworkDemo
//
//  Created by ciyouzen on 2016/12/20.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "CJDemoCryptHTTPRequestSerializer.h"
#import <CJDemoCryptSDK/CJDemoCrypt.h>

@implementation CJDemoCryptHTTPRequestSerializer

- (NSMutableURLRequest *)requestWithMethod:(NSString *)method
                                 URLString:(NSString *)URLString
                                parameters:(id)parameters
                                     error:(NSError *__autoreleasing *)error
{
    NSDictionary *newParameters = [[CJDemoCrypt sharedInstance] encryptRequestParams:parameters];
    
    NSMutableURLRequest *request = [super requestWithMethod:method URLString:URLString parameters:newParameters error:error];
    return request;
}


@end
