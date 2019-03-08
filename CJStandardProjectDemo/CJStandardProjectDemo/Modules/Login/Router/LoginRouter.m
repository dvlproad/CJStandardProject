//
//  LoginRouter.m
//  CJDemoModuleLoginDemo
//
//  Created by ciyouzen on 2018/9/18.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "LoginRouter.h"
#import "Target_CJDemoModuleLogin.h"
#import <CJDemoModuleMainMediator/CTMediator+CJDemoModuleMain.h>

@implementation LoginRouter

#pragma mark - 界面跳转
///进入主页
+ (void)goMainViewController {
    NSDictionary *params = nil;
    UIViewController *mainViewController = [[CTMediator sharedInstance] cjDemo_mainViewControllerWithParams:params];
    [UIApplication sharedApplication].delegate.window.rootViewController = mainViewController;
}

///进入"忘记密码"界面
+ (void)goFindPasswordViewControllerFrom:(UIViewController *)fromViewController {
    NSDictionary *params = nil;
    //UIViewController *viewController = [[CTMediator sharedInstance] cjDemo_forgetPasswordViewControllerWithParams:params];
    UIViewController *viewController = [[Target_CJDemoModuleLogin alloc] Action_loginViewController:params];
    [fromViewController.navigationController pushViewController:viewController animated:YES];
}

///进入"修改密码"界面(初始密码时候需要)
+ (void)goChangePasswordViewControllerFrom:(UIViewController *)fromViewController {
    NSDictionary *params = nil;
    //UIViewController *viewController = [[CTMediator sharedInstance] cjDemo_changePasswordViewControllerWithParams:params];
    UIViewController *viewController = [[Target_CJDemoModuleLogin alloc] Action_changePasswordViewController:params];
    [fromViewController.navigationController pushViewController:viewController animated:YES];
}

///进入"注册"界面
+ (void)goRegisterViewControllerFrom:(UIViewController *)fromViewController {
    NSDictionary *params = nil;
    //UIViewController *viewController = [[CTMediator sharedInstance] cjDemo_registerViewControllerWithParams:params];
    UIViewController *viewController = [[Target_CJDemoModuleLogin alloc] Action_registerViewController:params];
    [fromViewController.navigationController pushViewController:viewController animated:YES];
}


@end
