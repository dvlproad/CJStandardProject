//
//  CTMediator+CJDemoModuleMain.m
//  CJDemoModuleMainDemo
//
//  Created by ciyouzen on 2018/3/23.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "CTMediator+CJDemoModuleMain.h"

@implementation CTMediator (CJDemoModuleMain)

- (UIViewController *)cjDemo_mainViewControllerWithParams:(NSDictionary *)params {
    /*
     AViewController *viewController = [[AViewController alloc] init];
     */
    return [self performTarget:@"CJDemoModuleMain" action:@"mainViewController" params:params shouldCacheTarget:NO];
}


@end
