//
//  CJDemoServiceOrderManager.h
//  CJStandardProjectDemo
//
//  Created by 李超前 on 2018/9/6.
//  Copyright © 2018年 devlproad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CJDemoNetwork/DemoNetworkClient.h>
#import "DemoOrderModel.h"

@interface CJDemoServiceOrderManager : NSObject {
    
}
//请求需要的参数
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *accessToken;

//服务的对象
@property (nonatomic, strong) NSMutableArray<DemoOrderModel *> *serviceOrders;    /**< 服务的用户(有set方法，处理通知) */

+ (CJDemoServiceOrderManager *)sharedInstance;


#pragma mark - Network And DB
///获取订单列表
- (void)getOrderListWithString:(NSString *)string
                       success:(void (^)(NSDictionary *responseDict))success
                       failure:(void (^)(NSError *error))failure;

@end
