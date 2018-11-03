//
//  OrderListTableViewDataSource.h
//  CJStandardProjectDemo
//
//  Created by ciyouzen on 2018/8/29.
//  Copyright © 2018年 devlproad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "STDemoOrderModel.h"

@interface OrderListTableViewDataSource : NSObject <UITableViewDataSource> {
    
}
@property (nonatomic,strong) NSArray<STDemoOrderModel *> *orders;

@end
