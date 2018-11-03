//
//  OrderListLogicControl.h
//  CJStandardProjectDemo
//
//  Created by ciyouzen on 2018/8/29.
//  Copyright © 2018年 devlproad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STDemoOrderModel.h"

@interface OrderListLogicControl : NSObject {
    
}

/// 获取指定section的行数
- (NSInteger)getNumberOfRowsInSection:(NSInteger)section;

/// 获取指定indexPath的数据
- (STDemoOrderModel *)getOrderModelForRowAtIndexPath:(NSIndexPath *)indexPath;

/// tableView头部刷新的网络请求
- (void)headerRefreshRequestWithCompleteBlock:(void(^)(void))completeBlock;

/// tableView底部刷新的网络请求
- (void)footerRefreshRequestWithCompleteBlock:(void(^)(void))completeBlock;

@end
