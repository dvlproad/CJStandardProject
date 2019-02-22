//
//  CTMediator+CJDemoModuleLogin.m
//  CJDemoModuleLoginDemo
//
//  Created by ciyouzen on 2018/3/23.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "CTMediator+CJDemoModuleLogin.h"

@implementation CTMediator (CJDemoModuleLogin)


- (UIViewController *)cjDemo_guideViewControllerWithParams:(NSDictionary *)params {
    return [self performTarget:@"CJDemoModuleLogin" action:@"guideViewController" params:params shouldCacheTarget:NO];
}


- (UIViewController *)cjDemo_guideMainViewControllerWithParams:(NSDictionary *)params {
    return [self performTarget:@"CJDemoModuleLogin" action:@"guideMainViewController" params:params shouldCacheTarget:NO];
}

- (UIViewController *)cjDemo_loginViewControllerWithParams:(NSDictionary *)params {
    /*
     AViewController *viewController = [[AViewController alloc] init];
     */
    return [self performTarget:@"CJDemoModuleLogin" action:@"loginViewController" params:params shouldCacheTarget:NO];
}

- (UIViewController *)cjDemo_forgetPasswordViewControllerWithParams:(NSDictionary *)params {
    return [self performTarget:@"CJDemoModuleLogin" action:@"forgetPasswordViewController" params:params shouldCacheTarget:NO];
}

- (UIViewController *)cjDemo_registerViewControllerWithParams:(NSDictionary *)params {
    return [self performTarget:@"CJDemoModuleLogin" action:@"registerViewController" params:params shouldCacheTarget:NO];
}

///修改密码页(初始密码时候需要)
- (UIViewController *)cjDemo_changePasswordViewControllerWithParams:(NSDictionary *)params {
    return [self performTarget:@"CJDemoModuleLogin" action:@"changePasswordViewController" params:params shouldCacheTarget:NO];
}


@end
