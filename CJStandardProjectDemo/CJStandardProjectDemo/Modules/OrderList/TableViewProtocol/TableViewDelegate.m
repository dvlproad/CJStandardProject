//
//  TableViewDelegate.m
//  CJStandardProjectDemo
//
//  Created by 李超前 on 2018/8/29.
//  Copyright © 2018年 devlproad. All rights reserved.
//

#import "TableViewDelegate.h"
#import "CustomModel.h"

@implementation TableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_array.count>0) {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"" message:((CustomModel *)[_array objectAtIndex:indexPath.row]).title delegate:nil cancelButtonTitle:@"sure" otherButtonTitles:nil, nil];
        [alert show];
    }    
}
@end
