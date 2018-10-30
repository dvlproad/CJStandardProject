//
//  STDemoServiceOrderManager.h
//  CJStandardProjectDemo
//
//  Created by ciyouzen on 2018/9/6.
//  Copyright © 2018年 devlproad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STDemoOrderModel.h"

@interface STDemoServiceOrderManager : NSObject {
    
}
//请求需要的参数
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *accessToken;

//服务的对象
@property (nonatomic, strong) NSMutableArray<STDemoOrderModel *> *toTakeMealOrders;    /**< 待取餐的订单 */
@property (nonatomic, strong) NSMutableArray<STDemoOrderModel *> *toDeliverOrders;    /**< 待配送的订单 */
@property (nonatomic, strong) NSMutableArray<STDemoOrderModel *> *deliveringOrders;   /**< 配送中的订单 */
@property (nonatomic, strong) NSMutableArray<STDemoOrderModel *> *deliveredOrders;    /**< 已完成配送的订单 */

+ (STDemoServiceOrderManager *)sharedInstance;

@end
