//
//  DemoUsePermissionModel.m
//  CJDemoServiceDemo
//
//  Created by ciyouzen on 2016/12/14.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "DemoUsePermissionModel.h"

@implementation DemoUsePermissionModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"checked":    @"checked",
             @"menuId":     @"menuId",
             @"menuName":   @"menuName",
             @"menuParent": @"menuParent",
             @"permission": @"permission",
             @"rootNode":   @"rootNode",
             @"typeInfo":   @"typeInfo",
             };
}

@end
