//
//  CJDemoServiceOrderManager+OrderList.h
//  CJStandardProjectDemo
//
//  Created by ciyouzen on 2018/9/7.
//  Copyright © 2018年 devlproad. All rights reserved.
//

#import "CJDemoServiceOrderManager.h"

@interface CJDemoServiceOrderManager (OrderList)

///获取"待取餐的订单"
- (void)getToTakemealOrdersWithLongitude:(CGFloat)longitude
                                latitude:(CGFloat)latitude
                              dateString:(NSString *)dateString
                                 success:(void (^)(DemoOrderModel *toTakemealOrderListModel))success
                                 failure:(void (^)(NSString *failureMessage))failure;

///获取"待配送的订单"
- (void)getToDeliverOrdersWithLongitude:(CGFloat)longitude
                               latitude:(CGFloat)latitude
                             dateString:(NSString *)dateString
                                success:(void (^)(DemoOrderModel *toDeliverOrderListModel))success
                                failure:(void (^)(NSString *failureMessage))failure;

///获取"配送中的订单"
- (void)getDeliveringOrdersWithLongitude:(CGFloat)longitude
                                latitude:(CGFloat)latitude
                              dateString:(NSString *)dateString
                                 success:(void (^)(DemoOrderModel *deliveringOrderListModel))success
                                 failure:(void (^)(NSString *failureMessage))failure;


///获取"已完成配送的订单"
- (void)getDeliveredOrdersWithLongitude:(CGFloat)longitude
                               latitude:(CGFloat)latitude
                             dateString:(NSString *)dateString
                                success:(void (^)(DemoOrderModel *deliveredOrderListModel))success
                                failure:(void (^)(NSString *failureMessage))failure;

///获取"已完成的订单"
- (void)getDoneOrdersWithLongitude:(CGFloat)longitude
                          latitude:(CGFloat)latitude
                        dateString:(NSString *)dateString
                           success:(void (^)(DemoOrderModel *doneOrderListModel))success
                           failure:(void (^)(NSString *failureMessage))failure;

@end
