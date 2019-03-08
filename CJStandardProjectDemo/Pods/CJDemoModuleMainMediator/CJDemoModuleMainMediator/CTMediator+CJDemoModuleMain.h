//
//  CTMediator+CJDemoModuleMain.h
//  CJDemoModuleMainDemo
//
//  Created by ciyouzen on 2018/3/23.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import <CTMediator/CTMediator.h>

@interface CTMediator (CJDemoModuleMain)

/**
 *  返回主页控制器
 *
 *  @param params        主页控制器所需要的参数
 *
 *  @return 主页控制器
 */
- (UIViewController *)cjDemo_mainViewControllerWithParams:(NSDictionary *)params;

@end
