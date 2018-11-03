//
//  OrderListLogicControl.m
//  CJStandardProjectDemo
//
//  Created by ciyouzen on 2018/8/29.
//  Copyright © 2018年 devlproad. All rights reserved.
//

#import "OrderListLogicControl.h"

@interface OrderListLogicControl () {
    
}
@property (nonatomic, strong) NSMutableArray<STDemoOrderModel *> *orders;

@end

@implementation OrderListLogicControl

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

/// 获取指定section的行数
- (NSInteger)getNumberOfRowsInSection:(NSInteger)section {
    return self.orders.count;
}

/// 获取指定indexPath的数据
- (STDemoOrderModel *)getOrderModelForRowAtIndexPath:(NSIndexPath *)indexPath {
    STDemoOrderModel *orderModel = [self.orders objectAtIndex:indexPath.row];
    return orderModel;
}

/// tableView头部刷新的网络请求
- (void)headerRefreshRequestWithCompleteBlock:(void(^)(void))completeBlock
{
    // 模拟网络请求
    __weak typeof(self)weakSelf = self;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        sleep(2);
        NSMutableArray *orders =[NSMutableArray array];
        for (NSInteger i=0; i<16; i++) {
            NSInteger x = arc4random() % 100;
            NSString *string = [NSString stringWithFormat:@"(random%ld)",x];
            STDemoOrderModel *orderModel=[[STDemoOrderModel alloc] init];
            orderModel.title = string;
            [orders addObject:orderModel];
        }
        
        weakSelf.orders = orders;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (completeBlock) {
                completeBlock();
            }
        });
    });
}

/// tableView底部刷新的网络请求
- (void)footerRefreshRequestWithCompleteBlock:(void(^)(void))completeBlock
{
    // 模拟网络请求
    __weak typeof(self)weakSelf = self;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        sleep(2);
        NSMutableArray *orders = [NSMutableArray array];
        for (NSInteger i=0; i<16; i++) {
            NSInteger x = arc4random() % 100;
            NSString *string=[NSString stringWithFormat:@"(random%ld)",x];
            STDemoOrderModel *orderModel = [[STDemoOrderModel alloc] init];
            orderModel.title=string;
            [orders addObject:orderModel];
        }
        
        [weakSelf.orders addObjectsFromArray:orders];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (completeBlock) {
                completeBlock();
            }
        });
    });
}

@end
