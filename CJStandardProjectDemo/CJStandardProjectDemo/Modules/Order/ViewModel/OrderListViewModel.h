//
//  OrderListViewModel.h
//  CJStandardProjectDemo
//
//  Created by ciyouzen on 2018/8/29.
//  Copyright © 2018年 devlproad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STDemoOrderModel.h"

@interface OrderListViewModel : NSObject {
    
}
@property (nonatomic, strong) NSMutableArray<STDemoOrderModel *> *orders;

/// tableView头部刷新的网络请求
- (void)headerRefreshRequestWithCompleteBlock:(void(^)(NSMutableArray<STDemoOrderModel *> *orders))completeBlock;

/// tableView底部刷新的网络请求
- (void)footerRefreshRequestWithCompleteBlock:(void(^)(NSMutableArray<STDemoOrderModel *> *orders))completeBlock;

@end
