//
//  DemoNetworkClient+Order.h
//  CJStandardProjectDemo
//
//  Created by ciyouzen on 2018/8/30.
//  Copyright © 2018年 devlproad. All rights reserved.
//

#import "DemoNetworkClient.h"

@interface DemoNetworkClient (Order)

+ (void)requestOrderListWithType:(NSInteger)type
                         success:(void (^)(NSDictionary *responseDict))success
                         failure:(void (^)(NSError *error))failure;
@end
