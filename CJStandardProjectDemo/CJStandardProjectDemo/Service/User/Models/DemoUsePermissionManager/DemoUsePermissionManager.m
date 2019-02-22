//
//  DemoUsePermissionManager.m
//  CJDemoServiceDemo
//
//  Created by ciyouzen on 2016/12/14.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "DemoUsePermissionManager.h"

@interface DemoUsePermissionManager()
@property (strong,nonatomic) NSArray *permissionList;
@property (strong,nonatomic) NSMutableArray *testPermissionList;

@end



@implementation DemoUsePermissionManager

- (instancetype)initWithPermissionList:(NSArray *)permissionList
{
    if (self = [super init])
    {
        if (permissionList == nil || [permissionList isKindOfClass:[NSNull class]]) {
            self.permissionList = [NSArray array];;
        } else {
            self.permissionList = permissionList;
        }
    }
    return self;
}

- (BOOL)hasPermissionWithPermissionID:(HPPermissionID)permissionID
{
    for (DemoUsePermissionModel *e in self.permissionList)
    {
        if (e.permission == permissionID)
        {
            return YES;
        }
    }
    return NO;
}

- (NSMutableArray *)testPermissionList
{
    if (_testPermissionList == nil)
    {
        _testPermissionList = [NSMutableArray array];
        for (int i = 81; i < 81+11; i ++)
        {
            NSInteger num = arc4random()%21 + 81;
            NSDictionary * dic = @{@"aid":[NSNumber numberWithInteger:num]};
            if ([_testPermissionList containsObject:dic]) {
                i --;
            }
            else
            {
                [_testPermissionList addObject:dic];
            }
            
        }
    }
    return _testPermissionList;
}

@end
