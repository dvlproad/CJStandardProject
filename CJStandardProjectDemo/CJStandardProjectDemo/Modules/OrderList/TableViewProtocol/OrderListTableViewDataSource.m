//
//  OrderListTableViewDataSource.m
//  CJStandardProjectDemo
//
//  Created by ciyouzen on 2018/8/29.
//  Copyright © 2018年 devlproad. All rights reserved.
//

#import "OrderListTableViewDataSource.h"
#import "OrderCell.h"
#import "DemoOrderModel.h"

@implementation OrderListTableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[OrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    DemoOrderModel *dataModel = [_array objectAtIndex:indexPath.row];
    cell.titleLabel.text = dataModel.title;
    return cell;
}

@end
