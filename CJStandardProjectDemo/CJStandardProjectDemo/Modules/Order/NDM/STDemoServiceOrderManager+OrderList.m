//
//  STDemoServiceOrderManager+OrderList.m
//  CJStandardProjectDemo
//
//  Created by ciyouzen on 2018/9/7.
//  Copyright © 2018年 devlproad. All rights reserved.
//

#import "STDemoServiceOrderManager+OrderList.h"

@implementation STDemoServiceOrderManager (OrderList)

///获取"待取餐的订单"
- (void)getToTakemealOrdersWithLongitude:(CGFloat)longitude
                                latitude:(CGFloat)latitude
                              dateString:(NSString *)dateString
                                 success:(void (^)(STDemoOrderModel *toTakemealOrderListModel))success
                                 failure:(void (^)(NSString *failureMessage))failure
{
    
}

///获取"待配送的订单"
- (void)getToDeliverOrdersWithLongitude:(CGFloat)longitude
                               latitude:(CGFloat)latitude
                             dateString:(NSString *)dateString
                                success:(void (^)(STDemoOrderModel *toDeliverOrderListModel))success
                                failure:(void (^)(NSString *failureMessage))failure
{
    
}

///获取"配送中的订单"
- (void)getDeliveringOrdersWithLongitude:(CGFloat)longitude
                                latitude:(CGFloat)latitude
                              dateString:(NSString *)dateString
                                 success:(void (^)(STDemoOrderModel *deliveringOrderListModel))success
                                 failure:(void (^)(NSString *failureMessage))failure
{
    
}


///获取"已完成配送的订单"
- (void)getDeliveredOrdersWithLongitude:(CGFloat)longitude
                               latitude:(CGFloat)latitude
                             dateString:(NSString *)dateString
                                success:(void (^)(STDemoOrderModel *deliveredOrderListModel))success
                                failure:(void (^)(NSString *failureMessage))failure
{
    
}

///获取"已完成的订单"
- (void)getDoneOrdersWithLongitude:(CGFloat)longitude
                          latitude:(CGFloat)latitude
                        dateString:(NSString *)dateString
                           success:(void (^)(STDemoOrderModel *doneOrderListModel))success
                           failure:(void (^)(NSString *failureMessage))failure
{
    
}


//#pragma mark - Network
/////获取订单列表
//- (void)requestOrderListWithString:(NSString *)string
//                           success:(void (^)(NSDictionary *responseDict))success
//                           failure:(void (^)(NSError *error))failure
//{
//    NSString *apiName = @"/order/orderList";
//    NSDictionary *params = @{@"username":       self.uid,
//                             @"access_token":   self.accessToken
//                             };
//    
//    [[CJDemoNetworkClient sharedInstance] local_postApi:apiName params:params encrypt:YES success:success failure:failure];
//}

@end
