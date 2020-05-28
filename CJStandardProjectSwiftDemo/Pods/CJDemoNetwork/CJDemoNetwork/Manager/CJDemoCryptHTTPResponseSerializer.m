//
//  CJDemoCryptHTTPResponseSerializer.m
//  CJNetworkDemo
//
//  Created by ciyouzen on 2016/12/20.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "CJDemoCryptHTTPResponseSerializer.h"
#import <CJDemoCryptSDK/CJDemoCrypt.h>

@implementation CJDemoCryptHTTPResponseSerializer

- (id)responseObjectForResponse:(NSURLResponse *)response
                           data:(NSData *)data
                          error:(NSError *__autoreleasing *)error
{
    [self validateResponse:(NSHTTPURLResponse *)response data:data error:error];

//    return data;
    
    NSString *responseString = [[NSString alloc] initWithData:(NSData *)data encoding:NSUTF8StringEncoding];
    NSDictionary *responseObject = [[CJDemoCrypt sharedInstance] decryptResponseString:responseString];
    return responseObject;
}

@end
