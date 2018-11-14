//
//  OrderListViewModel.m
//  CJStandardProjectDemo
//
//  Created by ciyouzen on 2018/8/29.
//  Copyright © 2018年 devlproad. All rights reserved.
//

#import "OrderListViewModel.h"

@interface OrderListViewModel () {
    
}

@end

@implementation OrderListViewModel

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

/// tableView头部刷新的网络请求
- (void)headerRefreshRequestWithCompleteBlock:(void(^)(NSMutableArray<STDemoOrderModel *> *orders))completeBlock
{
    // 模拟网络请求
    __weak typeof(self)weakSelf = self;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        sleep(2);
        NSMutableArray *orders =[NSMutableArray array];
        for (NSInteger i=0; i<0; i++) {
            NSInteger x = arc4random() % 100;
            NSString *string = [NSString stringWithFormat:@"(random%ld)",x];
            STDemoOrderModel *orderModel=[[STDemoOrderModel alloc] init];
            orderModel.title = string;
            [orders addObject:orderModel];
        }
        
        weakSelf.orders = orders;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (completeBlock) {
                completeBlock(orders);
            }
        });
    });
}

/// tableView底部刷新的网络请求
- (void)footerRefreshRequestWithCompleteBlock:(void(^)(NSMutableArray<STDemoOrderModel *> *orders))completeBlock
{
    // 模拟网络请求
    __weak typeof(self)weakSelf = self;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        sleep(2);
        NSMutableArray *orders = [NSMutableArray array];
        for (NSInteger i=0; i<0; i++) {
            NSInteger x = arc4random() % 100;
            NSString *string=[NSString stringWithFormat:@"(random%ld)",x];
            STDemoOrderModel *orderModel = [[STDemoOrderModel alloc] init];
            orderModel.title=string;
            [orders addObject:orderModel];
        }
        
        [weakSelf.orders addObjectsFromArray:orders];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (completeBlock) {
                completeBlock(weakSelf.orders);
            }
        });
    });
}

@end
