//
//  OrderListTableViewDelegate.m
//  CJStandardProjectDemo
//
//  Created by ciyouzen on 2018/8/29.
//  Copyright © 2018年 devlproad. All rights reserved.
//

#import "OrderListTableViewDelegate.h"
#import <CJDemoCommon/DemoToast.h>

@implementation OrderListTableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.orders.count > 0) {
        STDemoOrderModel *orderModel = [self.orders objectAtIndex:indexPath.row];
        [DemoToast showMessage:orderModel.title];
    }    
}
@end
