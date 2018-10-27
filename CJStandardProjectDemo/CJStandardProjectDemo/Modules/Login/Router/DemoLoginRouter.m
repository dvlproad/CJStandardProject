//
//  DemoLoginRouter.m
//  CJStandardProjectDemo
//
//  Created by ciyouzen on 6/25/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import "DemoLoginRouter.h"
#import "CJDemoLoginVCFactory.h"
#import "CJDemoMainVCFactory.h"


@implementation DemoLoginRouter

#pragma mark - 界面跳转
///进入主页
+ (void)goMainViewController {
    UIViewController *mainViewController = [CJDemoMainVCFactory mainRootViewController];
    [UIApplication sharedApplication].delegate.window.rootViewController = mainViewController;
}

///进入"忘记密码"界面
+ (void)goFindPasswordViewControllerFrom:(UIViewController *)fromViewController {
    UIViewController *viewController = [CJDemoLoginVCFactory forgetPasswordViewController];
    [fromViewController.navigationController pushViewController:viewController animated:YES];
}

///进入"修改密码"界面(初始密码时候需要)
+ (void)goChangePasswordViewControllerFrom:(UIViewController *)fromViewController {
    UIViewController *viewController = [CJDemoLoginVCFactory changePasswordViewController];
    [fromViewController.navigationController pushViewController:viewController animated:YES];
}

///进入"注册"界面
+ (void)goRegisterViewControllerFrom:(UIViewController *)fromViewController {
    UIViewController *viewController = [CJDemoLoginVCFactory registerViewController];
    [fromViewController.navigationController pushViewController:viewController animated:YES];
}


@end
