//
//  DemoNetworkClient+Order.m
//  CJStandardProjectDemo
//
//  Created by 李超前 on 2018/8/30.
//  Copyright © 2018年 devlproad. All rights reserved.
//

#import "DemoNetworkClient+Order.h"

@implementation DemoNetworkClient (Order)

+ (void)requestOrderListWithType:(NSInteger)type
                         success:(void (^)(NSDictionary *responseDict))success
                         failure:(void (^)(NSError *error))failure
{
    NSLog(@"请求订单列表");
}

@end
